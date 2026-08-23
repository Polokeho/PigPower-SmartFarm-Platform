PigPower SmartFarm Platform
Software Requirements Specification — System Architecture
Section: 5.7 — Offline Data Architecture

Document ID: PSP-ARCH-5.7-OFFLINE
Version: 1.0
Status: Draft — grounded in verified implementation
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 5 – System Architecture
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

## 1. Purpose and a Note on This Document's Basis

Every other document in Chapter 5 was written *before* any code existed, as architecture decisions to be implemented. This document is different: it documents the **actual, running Drift schema** built in `5.6`, and its behaviour has since been **verified end-to-end** — a real farmer record was created offline (backend deliberately stopped), correctly showed a pending-sync state, and correctly synced automatically once the backend came back, alongside a second record created while already reconnected. That evidence is referenced throughout this document instead of hypothetical scenarios.

This is the right order of operations for a solo/small team: 5.6 established the *shape* (which tables, which library), the pilot build proved the *behaviour*, and this document now captures the *detail* — precisely and from something real, rather than guessing ahead of implementation.

## 2. Scope

This document covers the five Drift tables implemented in Pass 1 (`Farmers`, `ProductionBatches`, `VeterinaryRecords`, `OutboxItems`, `LookupValues`), the sync-status lifecycle each row goes through, and the reconciliation logic that ties a locally-created row to its eventual server-confirmed identity — the mechanics behind the green/orange sync icons verified in the running app.

## 3. Table-by-Table Detail

### 3.1 `Farmers`

| Column | Type | Purpose |
|---|---|---|
| `id` | TEXT (PK) | Local UUID. For offline-created rows this **is** the `client_id` sent to the server (OSDS FR-OSDS-006). |
| `serverId` | TEXT, nullable | Populated once the server confirms and assigns the authoritative `FMR-000xxx` number. |
| `farmerNumber` | TEXT, nullable | Duplicate of `serverId` post-confirmation — kept for display convenience so the UI doesn't need a join. |
| `name`, `districtCode`, `community`, `phone` | TEXT | Farmer profile fields, matching `5.5 §5`'s `CreateFarmerRequest`. |
| `status` | TEXT, default `PROSPECT` | CRM §9 lifecycle status. |
| `documentationComplete` | BOOL, default `false` | DFM §63 concept, not yet wired to real document checks in Pass 1. |
| `createdAt`, `updatedAt` | DATETIME | Local timestamps. |
| `syncStatus` | TEXT, default `SYNCED` | `PENDING_SYNC` \| `SYNCING` \| `SYNCED` \| `REJECTED` — drives the per-row icon confirmed in the running app (green check vs. orange cloud). |

**Verified behaviour:** "Thato Chakela," created while the backend was stopped, was written to this table immediately with `syncStatus = PENDING_SYNC` and a `LOCAL-FMR-...`-style `id`. No network call blocked the write — confirming `5.6 FR-MOB-011` ("never block on connectivity") in practice, not just on paper.

### 3.2 `ProductionBatches`

| Column | Type | Purpose |
|---|---|---|
| `id` | TEXT (PK) | Local UUID / `client_id`. |
| `serverId`, `batchNumber` | TEXT, nullable | Same pattern as Farmers — populated on confirmation. |
| `farmId` | TEXT | References a farm — may itself be a *local* farm id if the farm was also created offline in the same session (see §6, dependency ordering). |
| `pigIdsJson` | TEXT | JSON-encoded list, since Drift's SQLite backing doesn't have a native array type the way PostgreSQL does — the server-side `ARRAY(String)` column (5.2) and this JSON-encoded column are the same logical data, represented differently per platform. |
| `weightKg` | REAL, nullable | |
| `recordedAt` | DATETIME | |
| `notes` | TEXT, nullable | |
| `status` | TEXT, default `RECORDED` | `RECORDED` \| `MARKET_READY`. |
| `syncStatus` | TEXT, default `PENDING_SYNC` | Same lifecycle as Farmers. |

**Design note carried over from OSDS §11:** this table has no "edited" concept — a production entry, once written, is never mutated locally except to update its `syncStatus`/`serverId` post-confirmation. There is deliberately no `UPDATE` code path for the business fields, mirroring the backend's append-only `ProductionService`.

### 3.3 `VeterinaryRecords`

Structurally identical in pattern to `ProductionBatches` (`pigId`, `type`, `vaccineTypeCode`, `administeredAt`, `notes`, append-only). Not yet exercised through the UI in the verified pilot session, but built on the same repository/provider pattern as Farmer and Production, so extending the UI to it (a Veterinary capture screen) is now a known-quantity task, not a new architecture problem.

### 3.4 `OutboxItems` — the Generic Sync Queue

This is the table that made the observed sync behaviour possible, and it's worth being explicit about **why one generic table**, not one outbox per feature:

```
entityType        'Farmer' | 'ProductionBatch' | 'VeterinaryRecord'
clientId           matches the row's local id in its own table
idempotencyKey      unique — OSDS FR-OSDS-022
payloadJson         the exact JSON body that will be POSTed to /v1/sync/batch
priorityTier         1 (highest) .. 5 (lowest) — OSDS §10
status               QUEUED | UPLOADING | CONFIRMED | REJECTED
retryCount, lastAttemptAt, errorMessage
```

**Verified behaviour, explained precisely:** when the second farmer ("Ralichelete Shai") was created *after* the backend had been restarted, `SyncEngine.enqueue()` wrote a new row here and immediately called `syncNow()`. That call found **both** the new row and the still-pending "Thato Chakela" row (ordered by `priorityTier`, then `createdAt`), and submitted both in a single `POST /v1/sync/batch` request — which is exactly why both flipped to green together, not just the newly-created one. This is `5.6 FR-MOB-006`'s design working as intended: one shared queue, one shared engine, no per-feature sync logic to keep in sync with itself.

### 3.5 `LookupValues`

```
lookupTableCode    'district' | 'pig_breed' | 'vaccine_type' (composite PK with code)
code, label
metadataJson
```

Populated by `FarmerRepository`/future repositories calling `GET /v1/sync/reference-data`. **Known gap, already flagged in the mobile README:** `FarmerCreateScreen`'s district dropdown is currently hard-coded to `MASERU`/`BEREA` rather than reading from this table — the table and the endpoint both exist and work, but nothing calls the read path yet. This is the highest-value small fix available before adding new features (§7).

## 4. Sync Status Lifecycle (as actually observed)

The four-state lifecycle from `5.6 FR-MOB-006`, annotated with what was actually seen in the verified session:

```
PENDING_SYNC  ──┐
                │  SyncEngine.syncNow() triggered by:
                │    - connectivity restored (OSDS FR-OSDS-013)
                │    - enqueue() called (new item added)
                │    - manual "Sync Now" tap (not yet exercised)
                ▼
   SYNCING (transient — POST /v1/sync/batch in flight)
                │
        ┌───────┴───────┐
        ▼               ▼
    CONFIRMED        REJECTED
  (server_id set,   (error shown,
   green check)      orange/red icon)
```

**One thing the verified session did NOT test yet:** the `REJECTED` path — every farmer created so far had valid data, so nothing has actually exercised what the UI looks like when the server rejects an item (e.g. an unknown district code, mirroring the `VeterinaryRecord` "Referenced Pig ID does not exist" rejection already proven at the API level in `5.5 §9`). Worth a deliberate test: try creating a farmer with a district that doesn't exist in `LookupValues`, and confirm the row shows a rejection state with a readable error rather than silently vanishing.

## 5. Local-to-Server ID Reconciliation

Implements OSDS §49's `LocalEntityMapping` concept concretely, via `SyncEngine._applyServerId()`:

```dart
switch (entityType) {
  case 'Farmer':
    UPDATE farmers SET serverId = ?, farmerNumber = ?, syncStatus = 'SYNCED'
    WHERE id = <local client_id>
  // ... same pattern for ProductionBatch, VeterinaryRecord
}
```

Because the **primary key stays the local `id` for the row's entire lifetime** — it is never swapped for the server ID — every other part of the app (widgets, providers watching this row, any future feature referencing it) continues to work uninterrupted across the pending → confirmed transition. This is a deliberate design choice worth stating explicitly: swapping primary keys mid-flight would have been simpler to write but would break any UI element mid-render holding a reference to the "old" id.

## 6. Dependency Ordering — a Real Constraint, Not Yet Exercised

`5.5 §9`'s worked example describes a production batch referencing a farm created earlier in the *same* sync batch. This has not yet been tested in the running app, because every production/farmer combination tried so far referenced farms that already existed server-side before the offline test began.

**This is a genuine gap worth closing before the Production feature is considered fully proven**, not just a theoretical edge case:

```
Recommended test, not yet performed:
  1. Stop the backend.
  2. Create a NEW farmer (with a new farm) while offline.
  3. Immediately create a production batch referencing that
     brand-new, not-yet-synced farm's LOCAL id.
  4. Restart the backend and observe the sync.
```

The backend's `SyncService._process_item` (5.5/backend implementation) processes items in submitted order and the mobile outbox is ordered by `priorityTier` then `createdAt` — so in principle a farmer created before its production batch should sync first and unblock the batch. But "should, in principle" is exactly the phrase that separates architecture from verified behaviour, and this specific case hasn't been walked through yet. Recommended as the next concrete test, ahead of new feature work.

## 7. Recommended Next Small Fixes (Ranked by Value/Effort)

Given the working state confirmed this session, these are the highest-value next steps, ordered by how much they cost versus what they prove or fix:

1. **Wire `LookupValues` into `FarmerCreateScreen`'s district dropdown.** Small effort (repository method + provider + swap a hard-coded list for a query), and it closes a gap explicitly flagged in the mobile README rather than leaving it to accumulate.
2. **Test the dependency-ordering scenario in §6.** Zero code required — it's a test of what's already built, and it's the one behaviour claimed by the architecture that hasn't actually been observed yet.
3. **Test the `REJECTED` sync path** (§4) — same reasoning: zero new code, closes a real gap in verified behaviour.
4. **Build the Veterinary capture screen**, following the exact pattern already proven for Production (repository → providers → list/capture screens) — the OSDS §23 "no-signal veterinary visit" scenario that motivated much of this architecture is otherwise still only proven at the API layer (`5.5`), not the mobile UI layer.

## 8. What This Document Does Not Cover

```
5.8  Security Architecture (encryption, secrets management, device security)
5.9  Deployment & Infrastructure Architecture
5.10 Cost Model
```

## 9. Recommended GitHub File

Create:

```
docs/SRS/Chapter5/OfflineDataArchitecture.md
```

Then commit it:

```
git add docs/SRS/Chapter5/OfflineDataArchitecture.md
git commit -m "docs: add offline data architecture (chapter 5.7), grounded in verified implementation"
git push origin develop
```

## 10. Next Section

**5.8 Security Architecture** is next in sequence — encryption at rest for the local database and backend storage, secrets management (the `.env` files already in use on both sides), and device-level security considerations for a mobile app that will eventually hold farmer ID documents and financial data on field devices that can be lost or stolen (OSDS FR-OSDS-038/039, already partially implemented via `flutter_secure_storage`, worth documenting formally now that it's real code rather than a plan).

Given the state of the actual build, though, it may be more valuable to spend the next session on **§7's ranked fixes** above — particularly the dependency-ordering test — before continuing further into architecture documentation that doesn't yet have working code behind it the way 5.1-5.7 now do.
