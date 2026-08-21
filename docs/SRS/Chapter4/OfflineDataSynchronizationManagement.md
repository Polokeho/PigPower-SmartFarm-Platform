PigPower SmartFarm Platform
Software Requirements Specification — Functional Requirements
Module: Offline Synchronization & Data Synchronization Management

Document ID: PSP-SRS-FR-OSDS
Version: 1.0
Status: Draft
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

## 1. Module Overview

The Offline Synchronization & Data Synchronization Management Module (OSDS) will define how the PigPower Flutter mobile application operates when connectivity is unavailable, intermittent or poor, and how locally captured data is reliably reconciled with the backend once connectivity is restored.

Earlier modules have each assumed offline-capable behaviour without formally specifying it:

```
Production Management     → field production capture
Veterinary Management     → field treatment/vaccination capture
Document & File Mgmt      → offline document capture (DFM §50–52)
Notification & Comms      → offline notification queue, outbox pattern (NCM §32–33)
System Admin & Config     → mobile sync configuration parameters (SACM §24)
```

OSDS is the module that makes those assumptions concrete: the sync protocol, the conflict-resolution rules, the local data model, and the user experience of working offline.

## 2. Business Purpose

PigPower's farmer network is, by design, rural and distributed:

```
LESOTHO
   │
   ├── Maseru District
   ├── Berea District
   └── ... expanding to remaining districts
```

Mobile network coverage across these areas is uneven — ranging from reliable 4G in Maseru to intermittent 2G/3G or complete signal loss in more remote communities. Field officers, veterinarians, drivers and farmers must be able to continue working — recording a treatment, confirming a collection, capturing a photograph — **regardless of whether the device currently has a network connection.**

If the application requires connectivity to function, PigPower's entire operating model is at risk: a field officer stranded without signal for even a day should not lose a day's work.

OSDS exists to make offline operation a **first-class design principle**, not a fallback bolted on afterward.

## 3. Strategic Objectives

The module shall enable PigPower to:

1. Allow field users to continue working without connectivity.
2. Reliably capture data locally when offline.
3. Reliably synchronize local data once connectivity returns.
4. Resolve conflicts predictably when the same record is changed both offline and on the server.
5. Minimize data loss risk.
6. Minimize mobile data consumption for cost-sensitive rural users.
7. Provide field users with clear visibility of sync status.
8. Prevent duplicate records caused by repeated sync attempts.
9. Support partial connectivity (slow/unstable networks), not only fully-online/fully-offline states.
10. Support prioritized synchronization of the most operationally important data first.
11. Maintain data integrity across the transactional database despite delayed, out-of-order arrival of offline-created records.
12. Provide administrators with visibility into sync health across the farmer/field-officer fleet.

## 4. Synchronization Architecture

```
                 FLUTTER MOBILE APPLICATION
                            │
                            ▼
                    LOCAL DATA LAYER
              (local database + file queue)
                            │
                            ▼
                     SYNC ENGINE (CLIENT)
                            │
              ┌─────────────┴─────────────┐
              ▼                           ▼
        CONNECTIVITY                 SYNC QUEUE
         MONITOR                    (outbox / inbox)
              │                           │
              └─────────────┬─────────────┘
                            ▼
                    NETWORK AVAILABLE?
                     │             │
                    NO            YES
                     │             │
                 WAIT/RETRY   ▼
                            SYNC API (BACKEND)
                                    │
                                    ▼
                          SYNC ENGINE (SERVER)
                                    │
                     ┌──────────────┼──────────────┐
                     ▼              ▼              ▼
              CONFLICT         VALIDATION      TRANSACTION
              RESOLUTION                        DATABASE
                     │              │              │
                     └──────────────┼──────────────┘
                                    ▼
                            SYNC RESULT / ACK
                                    │
                                    ▼
                       BACK TO MOBILE SYNC ENGINE
```

**BR-OSDS-001** — The mobile application shall treat the local data layer as the source of truth for the user's *current screen state*, while the backend transactional database remains the ultimate source of truth for the *organization*. Sync reconciles the two; it does not let the device silently override confirmed server state without going through conflict resolution.

## 5. Offline-Capable Functional Areas

Not every function needs to work offline equally. The system shall classify functional areas by offline requirement:

| Classification | Definition | Examples |
|---|---|---|
| Full Offline | Must be fully usable with no connectivity | Production capture, veterinary record capture, photo capture, farmer visit notes |
| Offline-Read / Online-Write | Can be viewed offline from last sync, but changes require connectivity | Price lists, customer credit status, complex approvals |
| Online-Only | Requires connectivity by nature | Payment gateway transactions, real-time inventory allocation across facilities, live chat |

### FR-OSDS-001 — Offline Capability Classification

The system shall maintain a configurable classification (via SACM) of which screens/functions fall into each category above, so the offline scope can be extended over time without a full application redesign.

## 6. Local Data Model

### FR-OSDS-002 — Local Database

The mobile application shall maintain a local embedded database (e.g. SQLite, consistent with the "SQLite for local/mobile use" option flagged in the Document & File Management module's database architecture discussion) mirroring the subset of server data relevant to the current user.

### FR-OSDS-003 — Scoped Local Data (Not a Full Mirror)

The local database shall **not** attempt to store the entire organizational dataset. Each user role shall have a configured local data scope, for example:

```
FIELD OFFICER (Berea district)
   → Farmers assigned to Berea
   → Farms assigned to Berea
   → Production records for those farms (rolling 90 days)
   → Veterinary schedule for those farms
   → Reference/lookup data (breeds, feed types, disease types)

DRIVER
   → Assigned collection routes (current + next 7 days)
   → Farmer/farm pickup locations on those routes

FARMER (self-service app)
   → Own farm, own production, own payments only
```

### FR-OSDS-004 — Local Storage Budget

The system shall enforce a configurable local storage budget per device (relevant given typical rural entry-level smartphone storage constraints), prioritizing operational data over historical data when the budget is constrained.

### FR-OSDS-005 — Reference Data Caching

Configuration and lookup data managed by SACM (districts, breeds, feed types, disease types, document types, notification templates) shall be cached locally and refreshed on a configurable interval, so that offline forms remain fully functional (e.g. dropdown lists still populate) without requiring a live connection.

## 7. Local Data Capture

### FR-OSDS-006 — Offline Record Creation

The mobile application shall allow authorized users to create new records (production entries, veterinary records, collection confirmations, document uploads, farmer onboarding data) while offline, assigning each a client-generated temporary identifier pending server confirmation.

Example:

```
Local ID:  LOCAL-PROD-8f3a21
Status:    PENDING_SYNC
Created:   18 Aug 2026, 14:32 (device time)
```

### FR-OSDS-007 — Client-Side Temporary Identifiers

Temporary client-side identifiers shall be clearly distinguishable from server-confirmed identifiers (e.g. a distinct ID format/prefix) throughout the local UI, so users are not misled into treating an unsynced record as final (e.g. before the SACM sequence engine has issued its authoritative `FMR-000246`-style ID).

### FR-OSDS-008 — Offline Media Capture

Photographs and scanned documents captured offline shall be stored locally (with configurable compression, per DFM Section 55) and queued for upload, consistent with the Document & File Management module's offline capture requirements.

## 8. The Outbox Pattern

### FR-OSDS-009 — Outbox Queue

The mobile application shall maintain a persistent local outbox of pending changes to be synchronized to the server.

```
OUTBOX
│
├── LOCAL-PROD-8f3a21    (production record)     PENDING
├── LOCAL-VET-1c44b0     (veterinary record)      PENDING
├── LOCAL-DOC-9e02f1     (photo: farm assessment) PENDING
└── LOCAL-COLL-77aa02    (collection confirmed)   FAILED (retry 2 of 5)
```

### FR-OSDS-010 — Outbox Item Lifecycle

Each outbox item shall progress through:

```
CREATED
   ↓
QUEUED
   ↓
UPLOADING
   ↓
SERVER_VALIDATING
   ↓
CONFIRMED  (or)  REJECTED
```

### FR-OSDS-011 — Outbox Ordering

Where operations have a logical dependency (e.g. a farmer record must exist before a production record referencing it can be confirmed), the outbox shall preserve and respect creation order, or shall resolve dependency order server-side, so a dependent record is not rejected purely because it arrived before its parent.

### FR-OSDS-012 — Outbox Visibility to User

The user interface shall clearly show the user how many items are pending synchronization, and shall never silently discard a queued item without informing the user.

## 9. Synchronization Triggers

### FR-OSDS-013 — Automatic Sync

The application shall automatically attempt synchronization when:

```
Connectivity becomes available after being offline
App is brought to the foreground and connectivity exists
A configurable background interval elapses (where OS permits)
```

### FR-OSDS-014 — Manual Sync

The user shall be able to manually trigger a sync attempt (e.g. "Sync Now"), with clear feedback on progress and outcome.

### FR-OSDS-015 — Partial Connectivity Handling

The system shall distinguish between "no connectivity" and "poor/partial connectivity," and shall adapt behaviour accordingly — for example, deferring large media uploads on a poor connection while still syncing small, high-priority transactional records.

```
CONNECTION QUALITY CHECK
        │
   ┌────┼────┐
   ▼    ▼    ▼
 NONE  POOR  GOOD
   │    │    │
   │    │    ▼
   │    │  Full sync (data + media)
   │    ▼
   │  Priority sync only (small payloads)
   ▼
 Queue and wait
```

## 10. Synchronization Priority

### FR-OSDS-016 — Sync Priority Tiers

The system shall synchronize pending items in a configurable priority order rather than strictly first-in-first-out, so operationally time-sensitive data reaches the server first on constrained connections.

Example default priority:

```
TIER 1 (highest) — Veterinary emergency records, disease/biosecurity alerts
TIER 2            — Collection confirmations, farmer payments-related events
TIER 3            — Routine production records, farm visit notes
TIER 4            — Photographs and large media attachments
TIER 5 (lowest)   — Non-critical reference data refresh
```

## 11. Conflict Detection & Resolution

This is the most architecturally significant part of OSDS.

### FR-OSDS-017 — Conflict Detection

The system shall detect when a record synchronized from a device conflicts with the current server state of the same record — that is, the server record has been modified (by another user, another device, or a server-side process) since the mobile device last retrieved it.

```
Device last synced Farmer FMR-000123 at:  09:00
Device edits Farmer FMR-000123 offline at: 10:15
Server record for FMR-000123 modified by another user at: 09:40
Device reconnects and syncs at: 11:00
   → CONFLICT: server version (09:40) is newer than device's base version (09:00)
```

### FR-OSDS-018 — Conflict Resolution Strategy by Data Type

The system shall apply a configurable conflict-resolution strategy appropriate to each data type, rather than a single blanket rule:

| Data Type | Default Strategy | Rationale |
|---|---|---|
| Append-only records (production entries, veterinary events, interactions) | No conflict possible — new record, not an edit | Each entry is a new fact, not a mutation of a prior one |
| Status transitions (e.g. collection status) | Last-write-wins with server-authoritative override for defined critical statuses | Simpler operational flow; critical statuses protected |
| Master data edits (farmer profile, farm details) | Field-level merge where non-overlapping; flagged for manual review where overlapping | Avoids silently discarding either user's edit |
| Financial records (settlements, payments) | Server-authoritative; offline edits to confirmed financial records are rejected, not merged | Financial integrity must not depend on merge heuristics |
| Configuration data (SACM) | Server-authoritative always | Offline devices should never be able to alter shared configuration |

### FR-OSDS-019 — Field-Level Merge

Where field-level merge is the configured strategy, the system shall merge non-conflicting field changes automatically (e.g. device changed the farmer's phone number while server changed the farmer's address) and shall only flag a genuine conflict when the *same field* was changed differently by both sides.

### FR-OSDS-020 — Manual Conflict Resolution Queue

Unresolvable conflicts shall be placed in a manual resolution queue, visible to an authorized supervisor/administrator, showing both versions side by side.

```
CONFLICT: Farmer FMR-000123 — Physical Address

   SERVER VERSION (09:40, User B)         DEVICE VERSION (10:15, User A)
   "House 12, Ha Thetsane"                "House 12B, Ha Thetsane, near clinic"

   [Keep Server]  [Keep Device]  [Merge Manually]
```

### FR-OSDS-021 — Conflict Audit Trail

Every conflict and its resolution shall be recorded in the audit trail (per ACRM's platform-wide audit standard), including which version was kept, by whom, and when.

## 12. Idempotency & Duplicate Prevention

### FR-OSDS-022 — Idempotent Sync Requests

Every record submitted for synchronization shall carry a client-generated idempotency key, so that a retried sync request (e.g. due to a dropped connection mid-upload) does not create a duplicate record on the server.

```
Idempotency Key: device-7f2a-local-prod-8f3a21
   ↓
Server checks: has this key been processed before?
   ↓ YES                              ↓ NO
Return original result           Process and store result
                                  against this key
```

### FR-OSDS-023 — Duplicate Detection Beyond Idempotency Keys

As a secondary safeguard, the system shall apply the duplicate-detection techniques already defined for documents in DFM Section 53 (matching on entity, type, timestamp proximity and content hash where applicable) to catch duplicates that could arise from app reinstalls or local data-store resets.

## 13. Server-Side Sync Processing

### FR-OSDS-024 — Sync Validation

The server shall validate each incoming offline-created record against current business rules (e.g. SACM segregation-of-duties rules, ACRM control checks, mandatory field validation) before confirming it, and shall reject records that fail validation with a clear, actionable reason returned to the device.

```
SUBMITTED: LOCAL-VET-1c44b0
VALIDATION: Referenced Pig ID does not exist on server
RESULT: REJECTED
REASON: "Pig record not found — was it deleted or does the farmer record
         need to sync first?"
```

### FR-OSDS-025 — Authoritative ID Assignment

Upon successful validation, the server shall assign the authoritative entity ID (per the SACM numbering engine) and return it to the device, which shall then replace the temporary local ID throughout its local database and any queued dependent records.

### FR-OSDS-026 — Sync Batch Processing

The server shall support processing sync submissions in batches (rather than one record per API call where avoidable) to reduce the number of round trips required over constrained mobile connections.

## 14. Sync Status & User Feedback

### FR-OSDS-027 — Sync Status Indicator

The mobile application shall display a persistent, unobtrusive sync status indicator, for example:

```
● All synced (last sync: 2 minutes ago)
◐ Syncing... (4 items remaining)
○ Offline — 6 items waiting to sync
✕ 1 item failed to sync (tap for details)
```

### FR-OSDS-028 — Failed Sync Notification

Items that fail to sync after the configured retry policy (per SACM/NCM retry configuration principles) shall notify the user clearly, with an explanation and a manual retry option, rather than silently remaining pending indefinitely.

### FR-OSDS-029 — Sync Confirmation to User

Once a record is server-confirmed, the application shall visibly reflect this to the user (e.g. temporary ID replaced with the authoritative ID, a "synced" checkmark), so field users have confidence their work was not lost.

## 15. Retry & Failure Handling

### FR-OSDS-030 — Configurable Retry Policy

Failed sync attempts shall follow the configurable retry policy pattern already established in NCM Section 35 (attempt, wait, retry, escalate), applied here to data synchronization rather than notifications.

### FR-OSDS-031 — Exponential Backoff

Automatic retry attempts shall use exponential backoff (increasing wait time between attempts) to avoid overwhelming constrained networks or the backend during widespread connectivity outages (e.g. a regional network issue affecting many field devices simultaneously).

### FR-OSDS-032 — Permanent Failure Handling

An item that exhausts its retry policy shall be marked as requiring manual intervention, surfaced both to the device user and, where the item is operationally significant, to a supervisor via the Notification module.

## 16. Administrative Visibility

### FR-OSDS-033 — Fleet Sync Health Dashboard

Administrators shall have visibility into synchronization health across the field-device fleet, extending the System Health Dashboard introduced in SACM Section 28:

```
SYNC HEALTH — LAST 24 HOURS
Devices Active:              38
Devices Fully Synced:        34
Devices With Pending Items:   4
Devices Not Seen (>48h):      2
Failed Sync Items (total):    7
Manual Conflicts Pending:     1
```

### FR-OSDS-034 — Stale Device Detection

The system shall identify devices that have not synchronized within a configurable threshold period and shall surface this to operations management, since a field officer who has not synced in several days may indicate either a connectivity problem or an operational issue requiring follow-up.

## 17. Data Minimization & Cost Control

### FR-OSDS-035 — Payload Minimization

Sync payloads shall transmit only changed fields/records (delta sync) rather than full record sets, to minimize mobile data consumption for cost-sensitive rural users.

### FR-OSDS-036 — Media Upload Controls

Consistent with DFM Section 55, the application shall compress images before queuing them for upload, and shall allow the user (or an administrator policy) to defer large media uploads to a Wi-Fi connection where available, rather than forcing immediate upload over mobile data.

### FR-OSDS-037 — Data Usage Visibility

The application should optionally provide the user visibility into estimated mobile data used for synchronization, supporting user trust and cost awareness in a market where data affordability is a real constraint.

## 18. Security Considerations

### FR-OSDS-038 — Local Data Protection

Data cached locally on the device shall be protected consistent with the platform's security requirements (encrypted local storage where the device OS supports it, particularly for sensitive categories such as farmer identification documents and financial data).

### FR-OSDS-039 — Local Data Expiry on Logout/Deregistration

The system shall clear or securely invalidate locally cached data when a user logs out, is deregistered, or a device is reported lost/stolen, consistent with the access-revocation principles expected from SACM's access control configuration.

### FR-OSDS-040 — Sync Authentication

Every sync request shall be authenticated and authorized using the same access-control model as the rest of the platform (per SACM); the sync channel shall not become a bypass around normal permission checks.

## 19. Relationship to Other Modules

```
                    OSDS
                     │
      ┌──────────────┼──────────────┐
      ▼               ▼               ▼
  Production &    Document &      Notification &
  Veterinary       File Mgmt        Communication
  Capture         (offline upload)  (offline queue,
  (offline entry)                    retry pattern)
      │               │               │
      └───────────────┼───────────────┘
                      ▼
                 SACM (numbering,
                 mobile config,
                 access control)
                      │
                      ▼
                 ACRM (audit trail
                 of sync events and
                 conflict resolutions)
```

**BR-OSDS-002** — OSDS shall provide the shared sync engine and conflict-resolution framework used by all offline-capable modules; individual modules shall not implement their own bespoke offline queues, to avoid inconsistent behaviour across the application (echoing the same architectural discipline applied to notifications in NCM Section 13 and to configuration in SACM's centralization principle).

## 20. Core Entities

```
SyncQueueItem
SyncBatch
SyncConflict
SyncConflictResolution
LocalEntityMapping        (temporary ID ↔ authoritative ID)
DeviceSyncState
DeviceRegistration
OfflineCacheScope
IdempotencyRecord
```

### Example: Local Entity Mapping

```
LocalEntityMapping
────────────────────────
local_id            LOCAL-PROD-8f3a21
entity_type         ProductionRecord
server_id           PROD-004821
device_id           DEV-00231
resolved_at         18 Aug 2026, 11:03
```

## 21. Functional Requirements Summary

| ID | Requirement |
|---|---|
| OSDS-FR-001 | The system shall classify functional areas by offline capability level. |
| OSDS-FR-002 | The mobile application shall maintain a local embedded database. |
| OSDS-FR-003 | Local data scope shall be role-configured, not a full server mirror. |
| OSDS-FR-004 | The system shall enforce a configurable local storage budget. |
| OSDS-FR-005 | Reference/lookup data shall be cached locally and refreshed periodically. |
| OSDS-FR-006 | The application shall support offline record creation with temporary IDs. |
| OSDS-FR-007 | Temporary IDs shall be visually distinguishable from confirmed IDs. |
| OSDS-FR-008 | The application shall support offline media capture and queuing. |
| OSDS-FR-009 | The application shall maintain a persistent outbox of pending changes. |
| OSDS-FR-010 | Outbox items shall follow a defined lifecycle. |
| OSDS-FR-011 | The outbox shall respect or resolve record dependency order. |
| OSDS-FR-012 | Pending sync items shall be visible to the user. |
| OSDS-FR-013 | The application shall auto-sync when connectivity is available. |
| OSDS-FR-014 | The application shall support manual sync triggering. |
| OSDS-FR-015 | The application shall adapt behaviour to partial/poor connectivity. |
| OSDS-FR-016 | Sync shall follow configurable priority tiers. |
| OSDS-FR-017 | The system shall detect sync conflicts against server state. |
| OSDS-FR-018 | Conflict resolution strategy shall be configurable per data type. |
| OSDS-FR-019 | The system shall support field-level automatic merge where safe. |
| OSDS-FR-020 | Unresolvable conflicts shall enter a manual resolution queue. |
| OSDS-FR-021 | Conflict detection and resolution shall be audited. |
| OSDS-FR-022 | Sync submissions shall be idempotent via a client-generated key. |
| OSDS-FR-023 | The system shall apply secondary duplicate-detection safeguards. |
| OSDS-FR-024 | The server shall validate offline-created records before confirming. |
| OSDS-FR-025 | The server shall assign authoritative IDs and return them to the device. |
| OSDS-FR-026 | The server shall support batch sync processing. |
| OSDS-FR-027 | The application shall display a persistent sync status indicator. |
| OSDS-FR-028 | Failed sync items shall notify the user with retry options. |
| OSDS-FR-029 | Confirmed sync shall be visibly reflected to the user. |
| OSDS-FR-030 | Failed sync shall follow a configurable retry policy. |
| OSDS-FR-031 | Automatic retries shall use exponential backoff. |
| OSDS-FR-032 | Permanently failed items shall require and surface manual intervention. |
| OSDS-FR-033 | Administrators shall have fleet-wide sync health visibility. |
| OSDS-FR-034 | The system shall detect and surface stale (long-unsynced) devices. |
| OSDS-FR-035 | Sync payloads shall transmit deltas, not full record sets. |
| OSDS-FR-036 | Media upload shall be compressed and deferrable to Wi-Fi. |
| OSDS-FR-037 | The application should provide data-usage visibility to the user. |
| OSDS-FR-038 | Locally cached sensitive data shall be protected at rest. |
| OSDS-FR-039 | Local data shall be cleared/invalidated on logout or deregistration. |
| OSDS-FR-040 | Sync requests shall be authenticated and authorized like any other request. |

## 22. Non-Functional Requirements

**Reliability** — No user-entered data shall be silently lost due to a sync failure, app crash, or device issue, provided the outbox item was successfully persisted locally.

**Resilience** — The application shall remain fully usable for offline-classified functions with zero connectivity for extended periods (multiple days), limited only by local storage budget.

**Consistency** — Once synchronized, all devices and the backend shall converge on the same record state; no permanently diverging "forked" records shall be possible for master or financial data.

**Performance** — Sync operations shall not block the user interface; users must be able to continue working while a sync is in progress or pending.

**Efficiency** — Data usage shall be minimized appropriately for a cost-sensitive rural user base.

**Transparency** — Users must always be able to determine, at a glance, whether their data has been safely synchronized to the server.

**Auditability** — All sync events, conflicts and resolutions shall be traceable per the ACRM platform-wide audit standard.

**Scalability** — The sync architecture shall support growth from a pilot fleet of a handful of field devices to a fleet supporting the 500-farmer, national-scale vision without redesign.

## 23. Example End-to-End Scenario — Veterinary Visit in a No-Signal Area

```
Step 1
Veterinarian travels to a farm in a mountainous area with no signal.

Step 2
App is already offline-aware; veterinarian opens the farm's veterinary
schedule from local cache (last synced that morning).

Step 3
Veterinarian records a vaccination administered to Pig PIG-004821,
including a photo of the vaccination record card.

Step 4
Record is saved locally as LOCAL-VET-1c44b0, status PENDING_SYNC,
and queued in the outbox at TIER 1 priority (per Section 10).

Step 5
Veterinarian continues to the next farm, still offline, and repeats
the process for three more pigs.

Step 6
Later that day, the veterinarian's vehicle passes through an area
with signal. The app detects connectivity and begins auto-sync.

Step 7
Records sync in priority order; each receives its authoritative
VET-xxxxxx ID from the server.

Step 8
The sync status indicator updates from "4 items waiting" to
"All synced," and the veterinarian sees each record's ID update
from its LOCAL- prefix to its confirmed VET- ID.

Step 9
No conflict occurred, since veterinary records are append-only
(Section 11) — no other user could have modified these specific
new records before they existed on the server.
```

## 24. Example End-to-End Scenario — Conflicting Farmer Profile Edit

```
Step 1
Field Officer A visits Farmer FMR-000123 in the field, offline, and
updates the farmer's physical address on the local device at 10:15.

Step 2
Meanwhile, back at the office with connectivity, Field Officer B
updates the same farmer's primary contact phone number at 09:40,
which syncs to the server immediately.

Step 3
Field Officer A regains connectivity at 11:00 and syncs.

Step 4
Server detects the base version Officer A's device last saw (09:00)
is older than the current server version (09:40) — a conflict per
Section 11.

Step 5
Because the two edits touched different fields (address vs. phone),
the system applies the configured field-level merge strategy (§19)
and merges both changes automatically — no manual review required.

Step 6
Both changes are now reflected on the server, and the merge event
is recorded in the audit trail (§21) for traceability.
```

## 25. Recommended GitHub File

Create:

```
docs/SRS/Chapter4/OfflineDataSynchronizationManagement.md
```

Then commit it:

```
git add docs/SRS/Chapter4/OfflineDataSynchronizationManagement.md
git commit -m "docs: add offline and data synchronization management requirements"
git push
```

## 26. Where We Are Now

Chapter 4 functional requirements now cover:

```
Authentication
User Management
Farmer Management
Farm Management
Pig Management
Production Management
Veterinary Management
Feed Management
Collection & Logistics
Processing & Meat Production
Inventory & Warehouse
Sales & Orders
Customer & CRM
Farmer Payments & Settlements
Finance & Accounting
Procurement & Suppliers
HR & Payroll
Renewable Energy & Biodigester
Impact, Monitoring & Evaluation
Reporting & Business Intelligence
Notification & Communication
Document & File Management
System Administration & Configuration
Audit, Compliance & Regulatory Management
Offline Synchronization & Data Synchronization   ← this document
```

The remaining module to close out Chapter 4 is:

```
Integration & API Management
```

## 27. Next Module

I recommend **Integration & API Management** as the final Chapter 4 module. It should define:

- the overall API design principles the backend will expose to the Flutter app and to any future external integrations (REST conventions, versioning, pagination, error format);
- how the provider-abstraction pattern used repeatedly in this SRS (SMS/email/push in NCM, storage in DFM, external providers generally in SACM) is implemented consistently at the integration layer;
- authentication/authorization for the API itself (tokens, refresh strategy, device registration — tying directly into this OSDS module's sync authentication requirement and SACM's access control);
- rate limiting and abuse protection;
- webhook/callback handling for asynchronous providers (SMS delivery receipts, payment gateway callbacks);
- API documentation and versioning standards to keep the mobile app and backend evolving safely together as both continue to change.

Once Integration & API Management is complete, Chapter 4 (Functional Requirements) will be finished in full, and the SRS can move into **Chapter 5: System Architecture**, where the database technology, file storage technology, backend framework and Flutter application architecture choices — flagged as open decisions throughout Chapter 4 — can finally be evaluated and selected against the requirements now on record.
