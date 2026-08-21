PigPower SmartFarm Platform
Software Requirements Specification — System Architecture
Section: 5.5 — API Architecture (Endpoint Inventory, Pass 1)

Document ID: PSP-ARCH-5.5-API
Version: 1.0
Status: Draft — Pass 1 of N (MVP-critical modules only)
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 5 – System Architecture
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

## 1. Purpose and Scope of This Document

This document takes the conventions established in Chapter 4's IAPI module and Section 5.4's controller architecture, and produces the concrete endpoint inventory: actual routes, request/response shapes and permission requirements.

Because a full 26-module endpoint inventory is large and best written against real, evolving code rather than produced speculatively all at once, this document is explicitly **Pass 1**, covering only the modules needed for a minimum viable pilot build, matching the priority set out at the end of `5.4`:

```
PASS 1 (this document):
   Authentication
   Users (minimal — profile/self only)
   Farmer
   Production
   Veterinary
   Documents (upload/download core only)
   Sync

DEFERRED TO LATER PASSES (as each module is actually built):
   Farm, Pig, Feed, Logistics, Processing, Inventory,
   Sales, CRM, Payments, Finance, Procurement, HR, Energy,
   M&E, Reporting, Notifications (admin side), SACM, ACRM
```

Each later pass should be added as a new section appended to this same document (or a `Pass2`, `Pass3` file — team's choice), keeping the same conventions established here.

## 2. Global Conventions

These apply to every endpoint in this document and every endpoint added in future passes, per `IAPI §5`.

### 2.1 Base URL & Versioning

```
https://api.pigpower.example/v1/...
```

Per `IAPI FR-IAPI-007` / `5.4 FR-BE-020`, all routes are prefixed with a version segment.

### 2.2 Standard Headers

| Header | Required | Purpose |
|---|---|---|
| `Authorization: Bearer <access_token>` | Yes, except `POST /v1/auth/login` | Authentication (`IAPI FR-IAPI-010`) |
| `X-Request-Id` | No (server-generated if absent) | Correlation/tracing (`IAPI FR-IAPI-032`) |
| `X-Idempotency-Key` | Required on mutating sync-originated requests | Duplicate prevention (`OSDS FR-OSDS-022`, `IAPI FR-IAPI-027`) |
| `Accept-Language` | No (defaults to `en`) | Localized error/content strings (`IAPI FR-IAPI-035`) |

### 2.3 Standard Success Envelope

Per `IAPI FR-IAPI-003`:

```json
{
  "success": true,
  "data": { },
  "meta": { "request_id": "...", "timestamp": "..." }
}
```

### 2.4 Standard Error Envelope

Per `IAPI FR-IAPI-004`:

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_FAILED",
    "message": "Human-readable, localized message",
    "field": "optional-field-name",
    "request_id": "..."
  }
}
```

### 2.5 Common Error Codes (Pass 1 Scope)

| Code | HTTP Status | Meaning |
|---|---|---|
| `UNAUTHENTICATED` | 401 | Missing/invalid/expired access token |
| `TOKEN_EXPIRED` | 401 | Access token expired — client should attempt refresh |
| `FORBIDDEN` | 403 | Authenticated but lacks required permission/scope |
| `NOT_FOUND` | 404 | Entity does not exist or is outside caller's scope |
| `VALIDATION_FAILED` | 422 | Request body failed DTO validation (`5.4 FR-BE-011`) |
| `CONFLICT` | 409 | Sync conflict per `OSDS §11`, or business-rule conflict |
| `IDEMPOTENT_REPLAY` | 200 | Request already processed; original result returned (`OSDS FR-OSDS-022`) |
| `RATE_LIMITED` | 429 | Rate limit exceeded (`IAPI FR-IAPI-016/017`) |
| `SEGREGATION_OF_DUTIES_VIOLATION` | 409 | Blocked by ACRM control rule (`ACRM FR-ACRM-012`) |
| `INTERNAL_ERROR` | 500 | Unexpected server error |

### 2.6 Pagination

Per `IAPI FR-IAPI-005`, list endpoints accept:

```
?cursor=<opaque-cursor>&limit=<n, default 20, max 100>
```

and return:

```json
{
  "success": true,
  "data": [ ... ],
  "meta": { "next_cursor": "...", "has_more": true }
}
```

## 3. Authentication Module

Implements `IAPI §7`.

| Method | Path | Auth | Description |
|---|---|---|---|
| POST | `/v1/auth/login` | None | Authenticate with username/password; returns access + refresh tokens and registers/updates device (`IAPI FR-IAPI-011`) |
| POST | `/v1/auth/refresh` | Refresh token | Exchange a valid refresh token for a new access token |
| POST | `/v1/auth/logout` | Access token | Revokes current tokens; triggers local data invalidation on device (`OSDS FR-OSDS-039`) |
| POST | `/v1/auth/logout-all-devices` | Access token, elevated | Revokes all tokens for the user (lost device scenario, `IAPI FR-IAPI-014`) |
| GET | `/v1/auth/me` | Access token | Returns authenticated user's profile, roles, permissions and scope (used by mobile app at login per `5.6 FR-MOB-003`) |

**POST `/v1/auth/login` — Request**

```json
{ "username": "string", "password": "string", "device_id": "string" }
```

**POST `/v1/auth/login` — Response `data`**

```json
{
  "access_token": "...",
  "refresh_token": "...",
  "access_token_expires_at": "2026-08-25T10:00:00Z",
  "user": { "user_id": "...", "roles": ["FIELD_OFFICER"], "scope": { "district": "Berea" } }
}
```

## 4. Users Module (Minimal — Self-Service Only in Pass 1)

Full user administration (creation, role assignment) belongs to a later pass alongside SACM; Pass 1 covers only what the mobile app needs for the authenticated user's own profile.

| Method | Path | Auth | Permission | Description |
|---|---|---|---|---|
| GET | `/v1/users/me` | Yes | — (self) | Alias/extension of `/v1/auth/me` with fuller profile fields |
| PATCH | `/v1/users/me` | Yes | — (self) | Update own contact details, notification preferences (`NCM FR-NCM-009`) |

## 5. Farmer Module

Implements the Farmer Master Record concepts referenced across CRM, DFM and OSDS's worked examples.

| Method | Path | Auth | Permission | Description |
|---|---|---|---|---|
| GET | `/v1/farmers` | Yes | `farmer.view` | List farmers, scoped to caller's district (`IAPI FR-IAPI-013`) |
| GET | `/v1/farmers/{id}` | Yes | `farmer.view` | Retrieve a single farmer |
| POST | `/v1/farmers` | Yes | `farmer.create` | Create a farmer (offline-created records use client UUID, per `OSDS FR-OSDS-006`) |
| PATCH | `/v1/farmers/{id}` | Yes | `farmer.edit` | Update farmer profile fields |
| POST | `/v1/farmers/{id}/status` | Yes | `farmer.approve` | Change farmer status (e.g. PROSPECT → ACTIVE) — logged per `SACM §26` pattern |
| GET | `/v1/farmers/{id}/documents` | Yes | `farmer.view` + `document.view` | List documents linked to this farmer (delegates to Documents module) |

**POST `/v1/farmers` — Request**

```json
{
  "client_id": "LOCAL-FMR-8f3a21",
  "name": "string",
  "district": "Berea",
  "community": "string",
  "phone": "+266XXXXXXXX",
  "farm": { "location": { "lat": 0.0, "lng": 0.0 }, "pigsty_count": 2 }
}
```

`client_id` supports the temporary-ID pattern from `OSDS FR-OSDS-006/007`; the response's `data.farmer_id` carries the authoritative `FMR-000xxx` ID from the SACM numbering engine (`IAPI FR-IAPI-026` batch-sync flow uses this same field).

**GET `/v1/farmers/{id}` — Response `data`**

```json
{
  "farmer_id": "FMR-000246",
  "name": "string",
  "status": "ACTIVE",
  "district": "Berea",
  "assigned_officer": "user_id",
  "documentation_complete": true,
  "created_at": "...",
  "updated_at": "..."
}
```

## 6. Production Module

Covers the field-capture flow illustrated in OSDS §23 (veterinary example) and the analogous production case.

| Method | Path | Auth | Permission | Description |
|---|---|---|---|---|
| GET | `/v1/production/batches` | Yes | `production.view` | List production batches for caller's scope |
| GET | `/v1/production/batches/{id}` | Yes | `production.view` | Retrieve a batch |
| POST | `/v1/production/batches` | Yes | `production.edit` | Record a new production entry (append-only per `OSDS §11` conflict table — no update endpoint needed for the entry itself) |
| POST | `/v1/production/batches/{id}/mark-ready` | Yes | `production.edit` | Mark pigs as market-ready — emits `production.batch_ready` event (`5.4 FR-BE-012`) |

**POST `/v1/production/batches` — Request**

```json
{
  "client_id": "LOCAL-PROD-8f3a21",
  "farm_id": "FARM-00812",
  "pig_ids": ["PIG-004821"],
  "recorded_at": "2026-08-18T14:32:00Z",
  "weight_kg": 68.4,
  "notes": "string"
}
```

## 7. Veterinary Module

Directly implements the end-to-end scenario walked through in `OSDS §23`.

| Method | Path | Auth | Permission | Description |
|---|---|---|---|---|
| GET | `/v1/veterinary/schedule` | Yes | `veterinary.view` | Vaccination/treatment schedule for caller's assigned farms |
| GET | `/v1/veterinary/records/{id}` | Yes | `veterinary.view` | Retrieve a veterinary record |
| POST | `/v1/veterinary/records` | Yes | `veterinary.edit` | Record a vaccination/treatment (append-only, offline-capable) |

**POST `/v1/veterinary/records` — Request**

```json
{
  "client_id": "LOCAL-VET-1c44b0",
  "pig_id": "PIG-004821",
  "type": "VACCINATION",
  "vaccine_type_id": "lookup-value-id",
  "administered_at": "2026-08-18T09:10:00Z",
  "administered_by": "user_id",
  "document_ids": ["LOCAL-DOC-9e02f1"],
  "notes": "string"
}
```

Note the `document_ids` field referencing locally-queued document uploads — the server reconciles these once the corresponding Documents-module sync item has also been confirmed, an ordering case explicitly anticipated by `OSDS FR-OSDS-011`.

## 8. Documents Module (Core Upload/Download Only)

Full document lifecycle (approval workflow, versioning, retention) is deferred to a later pass; Pass 1 covers only what field capture needs.

| Method | Path | Auth | Permission | Description |
|---|---|---|---|---|
| POST | `/v1/documents` | Yes | `document.upload` | Upload a document/photo (multipart), associates with an entity per `DFM §17` |
| GET | `/v1/documents/{id}` | Yes | `document.view` (+ confidentiality check) | Metadata only |
| GET | `/v1/documents/{id}/download-url` | Yes | `document.view` (+ confidentiality check) | Returns a short-lived signed URL (`5.3 AD-FS-004`), not the file bytes directly |

**POST `/v1/documents` — Request (multipart fields)**

```
client_id: LOCAL-DOC-9e02f1
document_type: VACCINATION_CERTIFICATE
related_entity_type: VeterinaryRecord
related_entity_id: LOCAL-VET-1c44b0   (may itself still be a client_id, per §7 note above)
file: <binary>
```

## 9. Sync Module

Implements `IAPI §11` and orchestrates into the modules above, per `5.4 FR-BE-021`.

| Method | Path | Auth | Permission | Description |
|---|---|---|---|---|
| POST | `/v1/sync/batch` | Yes | (per-item, enforced per contained record type) | Submit a batch of queued outbox items in one request |
| GET | `/v1/sync/changes` | Yes | (scoped) | Incremental/delta pull — records changed since a given timestamp/cursor, for the caller's scope (`IAPI FR-IAPI-028`) |
| GET | `/v1/sync/reference-data` | Yes | — | Bulk pull of SACM lookup/reference data for local caching (`OSDS FR-OSDS-005`) |

**POST `/v1/sync/batch` — Request**

```json
{
  "items": [
    {
      "idempotency_key": "device-7f2a-local-prod-8f3a21",
      "entity_type": "ProductionBatch",
      "client_id": "LOCAL-PROD-8f3a21",
      "operation": "CREATE",
      "payload": { "...": "..." }
    },
    {
      "idempotency_key": "device-7f2a-local-vet-1c44b0",
      "entity_type": "VeterinaryRecord",
      "client_id": "LOCAL-VET-1c44b0",
      "operation": "CREATE",
      "payload": { "...": "..." }
    }
  ]
}
```

**POST `/v1/sync/batch` — Response `data`**

```json
{
  "results": [
    {
      "client_id": "LOCAL-PROD-8f3a21",
      "status": "CONFIRMED",
      "server_id": "PROD-004821"
    },
    {
      "client_id": "LOCAL-VET-1c44b0",
      "status": "REJECTED",
      "error": { "code": "VALIDATION_FAILED", "message": "Referenced Pig ID does not exist on server." }
    }
  ]
}
```

This response shape directly implements the mixed confirm/reject batch outcome described narratively in `OSDS §13` (`FR-OSDS-024`) and the end-to-end sync scenario in `IAPI §19`.

**GET `/v1/sync/changes` — Query Parameters**

```
?since=2026-08-18T09:00:00Z&entity_types=Farmer,ProductionBatch,VeterinaryRecord
```

## 10. Permission Reference (Pass 1 Scope)

Consolidated from the endpoints above, for convenience — the authoritative catalog remains SACM's permission table (`SACM FR-SACM-002`):

```
farmer.view
farmer.create
farmer.edit
farmer.approve
production.view
production.edit
veterinary.view
veterinary.edit
document.upload
document.view
```

## 11. Sequence Example — Tying the Endpoints Together

This confirms the endpoint set above actually supports the login → offline capture → sync scenario from `IAPI §19`:

```
1. POST /v1/auth/login              → tokens + device registered
2. GET  /v1/sync/reference-data      → districts, breeds, vaccine types cached locally
3. GET  /v1/sync/changes?since=...   → initial farmer/production/veterinary data for scope
   [ device goes offline ]
4. (local) production + veterinary records created, queued in outbox
   [ connectivity restored ]
5. POST /v1/sync/batch                → all queued items submitted together
6. (local) outbox updated per response — confirmed items get server IDs,
   rejected items surfaced to user per 5.6 FR-MOB-012
```

## 12. What This Document Does Not Cover (Yet)

```
Farm, Pig (as distinct endpoints — currently implied via Farmer/Production)
Feed, Logistics, Processing, Inventory
Sales, CRM
Payments, Finance
Procurement, HR
Energy, M&E, Reporting
Notifications (admin-configuration side; device push registration is
   assumed covered by device registration in §3)
Document module's full lifecycle (approval, versioning, retention)
SACM administration endpoints
ACRM audit/compliance endpoints
```

These should each become a **Pass 2, Pass 3, ...** addition to this document, written as each module is actually implemented — consistent with the incremental approach recommended at the end of `5.4`.

## 13. Recommended GitHub File

Create:

```
docs/SRS/Chapter5/APIArchitecture.md
```

Then commit it:

```
git add docs/SRS/Chapter5/APIArchitecture.md
git commit -m "docs: add API architecture pass 1 (auth, farmer, production, veterinary, documents, sync)"
git push
```

## 14. Next Section

With Pass 1 of the API inventory in place alongside the Flutter architecture (`5.6`), enough of Chapter 5 now exists to actually start building the MVP pilot flow end-to-end: login, farmer onboarding, offline production/veterinary capture, and sync.

The remaining Chapter 5 sections are:

```
5.7  Offline Data Architecture (detailed Drift schema)
5.8  Security Architecture (encryption, secrets, device security)
5.9  Deployment & Infrastructure Architecture
5.10 Cost Model
```

Given this document and `5.6` now give you a concrete slice to implement, it may be more valuable to pause here and **scaffold the actual NestJS backend module structure (per `5.4`) and Flutter project structure (per `5.6`) for exactly the Pass 1 scope** — Auth, Farmer, Production, Veterinary, Documents, Sync — before continuing further into architecture documentation. That would give you working, runnable code for the core loop this SRS has been building toward, with `5.7` (the detailed local schema) written *from* that real implementation rather than ahead of it. Let me know whether you'd like to continue the documentation sequence, or switch into scaffolding this Pass 1 slice as code.
