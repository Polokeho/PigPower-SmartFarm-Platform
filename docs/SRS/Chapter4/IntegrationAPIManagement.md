PigPower SmartFarm Platform
Software Requirements Specification — Functional Requirements
Module: Integration & API Management

Document ID: PSP-SRS-FR-IAPI
Version: 1.0
Status: Draft
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

## 1. Module Overview

The Integration & API Management Module (IAPI) will define the conventions, security model and operational requirements for the Application Programming Interface (API) that connects the Flutter mobile application to the PigPower backend, and through which the backend integrates with external service providers.

Every module specified so far ultimately depends on this layer:

```
Flutter Mobile App  ──────►  API  ──────►  Backend Modules
                                                  │
                                                  ▼
                                        External Providers
                                    (SMS, Email, Storage, Payments)
```

Where earlier modules have referred to "the API," "the sync API," "the provider interface" or "the backend" in general terms, IAPI is where those references are drawn together into one formal specification.

This module closes out Chapter 4 (Functional Requirements). It is deliberately written at the level of **requirements the API must satisfy**, not a full API reference — the endpoint-by-endpoint specification belongs in the System Architecture / API Architecture chapter that follows.

## 2. Business Purpose

PigPower's Flutter mobile application, its future web-based admin console, and its backend modules must all communicate through a single, consistent, well-governed interface. Left unmanaged, an API layer tends to accumulate:

```
Inconsistent endpoint conventions
Undocumented breaking changes
Hard-coded provider credentials in client code
No rate limiting (vulnerable to abuse or runaway mobile retry loops)
No versioning (old app versions break silently)
```

IAPI exists to prevent these failure modes from the outset, given that PigPower's mobile app will be used by field staff in low-connectivity conditions who cannot simply "clear cache and try again" the way an office worker might.

## 3. Strategic Objectives

The module shall enable PigPower to:

1. Provide a single, consistent API contract for all client applications.
2. Support the Flutter mobile app's offline-first sync requirements (per OSDS).
3. Support a future web-based administration console using the same backend.
4. Authenticate and authorize every API request consistently (per SACM).
5. Protect the platform against abuse, overload and unintentional runaway retry behaviour.
6. Isolate external providers (SMS, email, storage, payments) behind a stable internal interface.
7. Support safe, non-breaking evolution of the API over time (versioning).
8. Provide clear, actionable error responses to client applications.
9. Support asynchronous provider callbacks (delivery receipts, payment confirmations).
10. Maintain a documented, discoverable API contract for current and future developers.
11. Support monitoring and diagnosis of integration failures.
12. Keep provider credentials and secrets out of the mobile application entirely.

## 4. Integration Architecture

```
                    CLIENT APPLICATIONS
        ┌────────────────────┬────────────────────┐
        ▼                    ▼                    ▼
   Flutter Mobile      Admin Web Console      Future Partner
      App                (future)              Integrations
        │                    │                    │
        └────────────────────┼────────────────────┘
                             ▼
                        API GATEWAY
                    (auth, rate limiting,
                     versioning, logging)
                             │
                             ▼
                    APPLICATION API LAYER
                             │
             ┌───────────────┼───────────────┐
             ▼               ▼               ▼
        Core Modules   Sync Endpoints   Webhook Receivers
       (Farmer, CRM,    (per OSDS)      (SMS/Email/Payment
        Production,                       callbacks)
        Finance, etc.)
             │
             ▼
    PROVIDER ABSTRACTION LAYER
             │
     ┌───────┼────────┬─────────────┐
     ▼       ▼         ▼             ▼
   SMS     Email    File/Object    Payment
 Provider Provider    Storage      Gateway
```

**BR-IAPI-001** — All client applications (including the Flutter mobile app) shall interact with backend modules exclusively through the API layer; no client application shall connect directly to the database or to external providers.

## 5. API Design Principles

### FR-IAPI-001 — RESTful Convention

The API shall follow consistent REST conventions for resource naming, HTTP methods and status codes, so behaviour is predictable across all modules rather than ad hoc per module.

```
GET     /farmers               list farmers
GET     /farmers/{id}          retrieve a farmer
POST    /farmers               create a farmer
PATCH   /farmers/{id}          update a farmer
DELETE  /farmers/{id}          soft-delete a farmer (per module retention rules)
```

### FR-IAPI-002 — Consistent Resource Naming

Resource and field naming shall follow a documented convention (e.g. plural nouns for collections, `snake_case` or `camelCase` consistently applied) across all modules, to avoid the inconsistency that arises when each module is built independently.

### FR-IAPI-003 — Standard Response Envelope

All API responses shall follow a consistent structure, distinguishing successful data from metadata and errors.

Example:

```json
{
  "success": true,
  "data": { "farmer_id": "FMR-000246", "name": "..." },
  "meta": { "request_id": "req-9f21", "timestamp": "2026-08-18T11:03:00Z" }
}
```

### FR-IAPI-004 — Standard Error Format

All error responses shall follow a consistent structure, providing a machine-readable code and a human-readable message suitable for display or logging.

Example:

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_FAILED",
    "message": "Referenced Pig ID does not exist on server.",
    "field": "pig_id",
    "request_id": "req-9f22"
  }
}
```

This directly supports the offline sync rejection scenario described in OSDS Section 13 (FR-OSDS-024), where the mobile app needs a clear, actionable reason for a rejected record.

### FR-IAPI-005 — Pagination

Endpoints returning collections shall support consistent pagination (e.g. cursor-based or offset-based, applied uniformly), to avoid unbounded responses as data volume grows toward the 500-farmer, national-scale vision.

### FR-IAPI-006 — Filtering and Sorting Conventions

Endpoints shall support a consistent query parameter convention for filtering and sorting, so client developers do not need to learn a different pattern per module.

## 6. API Versioning

### FR-IAPI-007 — API Versioning Strategy

The API shall be versioned (e.g. via URL path `/v1/...` or a version header), allowing breaking changes to be introduced in a new version without immediately breaking mobile app installations that have not yet updated.

### FR-IAPI-008 — Version Deprecation Policy

The system shall support a documented deprecation window during which both an old and new API version remain available, giving field devices — which may not update immediately in low-connectivity areas — time to migrate.

### FR-IAPI-009 — Minimum Client Version Enforcement

The API shall be able to reject or warn requests from mobile app versions below the minimum supported version configured in SACM (FR-SACM-028), returning a clear "please update" response the app can present to the user.

## 7. Authentication & Authorization

### FR-IAPI-010 — Token-Based Authentication

The API shall authenticate requests using a token-based scheme (e.g. short-lived access token plus longer-lived refresh token), rather than requiring credentials to be re-sent on every request.

```
LOGIN
   ↓
Access Token (short-lived, e.g. 15–60 min)
Refresh Token (longer-lived, securely stored)
   ↓
API requests carry Access Token
   ↓
Access Token expires
   ↓
Refresh Token used to obtain a new Access Token
   ↓
Refresh Token itself expires / is revoked
   ↓
Re-authentication required
```

### FR-IAPI-011 — Device Registration

Each mobile installation shall register as a known device, associated with the authenticated user, enabling device-level actions such as forced logout, lost-device data invalidation (per OSDS FR-OSDS-039) and per-device sync health visibility (per OSDS FR-OSDS-033).

### FR-IAPI-012 — Role-Based API Authorization

Every API request shall be authorized against the requesting user's role and permissions as configured in SACM; the API layer shall enforce this consistently rather than relying on each module to reimplement its own checks.

### FR-IAPI-013 — Scoped Authorization

Where a user's role is scoped (e.g. a Field Officer scoped to Berea district, per SACM FR-SACM-004), the API shall enforce that scope at the data-access level, not merely hide unauthorized data in the client interface.

### FR-IAPI-014 — Token Revocation

The system shall support immediate revocation of a user's or device's active tokens (e.g. on account suspension, lost-device report, or role change requiring re-authentication), consistent with OSDS's local-data-invalidation-on-logout requirement.

### FR-IAPI-015 — External/Read-Only Access Tokens

The API shall support restricted-scope tokens for the external auditor and BEDCO-reviewer access patterns defined in ACRM (FR-ACRM-017), time-limited and scoped to only the authorized records.

## 8. Rate Limiting & Abuse Protection

### FR-IAPI-016 — Rate Limiting

The API shall enforce configurable rate limits per user, per device and per endpoint category, to protect the platform from both malicious abuse and unintentional overload (e.g. a misbehaving retry loop on a device with a poor connection).

```
Standard endpoints:     configurable requests/minute
Sync/batch endpoints:   higher limit, batch-aware
Authentication endpoints: stricter limit (brute-force protection)
Bulk export endpoints:  stricter limit
```

### FR-IAPI-017 — Graceful Rate-Limit Response

When a rate limit is exceeded, the API shall return a clear, standard response (per FR-IAPI-004) indicating the retry-after period, allowing the client to back off automatically rather than fail unpredictably.

### FR-IAPI-018 — Anomaly Detection

The system should flag unusual API usage patterns (e.g. a single device generating an abnormal volume of requests) for review, complementing the high-risk transaction flagging already defined in ACRM (FR-ACRM-014).

## 9. Provider Abstraction Layer

### FR-IAPI-019 — Provider Interface Contract

The API layer shall expose a stable internal interface for each category of external provider (SMS, email, file/object storage, payment gateway), so that the specific provider selected in SACM's provider configuration (FR-SACM-030) can be changed without modifying the modules that depend on it.

```
Notification Module
      │
      ▼
SMS Provider Interface   ← stable contract
      │
      ▼
Concrete Provider Adapter (Provider A today, Provider B tomorrow)
```

This formalizes, at the API layer, the abstraction principle already introduced conceptually in NCM Section 51 and DFM Section 49.

### FR-IAPI-020 — Provider Credential Isolation

Provider credentials (API keys, secrets) shall be stored only in the secure backend environment and shall never be embedded in, or retrievable by, the Flutter mobile application, reaffirming NCM's security requirement (Section 52) and DFM's storage architecture principle (Section 48–49).

### FR-IAPI-021 — Provider Failover

Where feasible and configured, the provider abstraction layer shall support failover to a secondary provider if the primary provider is unavailable, particularly for SMS delivery given its operational importance to farmer communication.

## 10. Webhook & Asynchronous Callback Handling

### FR-IAPI-022 — Webhook Receivers

The API shall provide secure endpoints to receive asynchronous callbacks from external providers, such as:

```
SMS delivery/read status callbacks
Email delivery/bounce callbacks
Payment gateway transaction status callbacks
```

### FR-IAPI-023 — Webhook Authenticity Verification

Incoming webhook calls shall be verified as genuinely originating from the expected provider (e.g. signature verification), to prevent spoofed callback abuse — for example, a forged "payment successful" callback.

### FR-IAPI-024 — Webhook Idempotency

Webhook processing shall be idempotent, consistent with the idempotency principle established for offline sync (OSDS FR-OSDS-022), since providers commonly retry callback delivery.

### FR-IAPI-025 — Webhook Failure Handling

Failed webhook processing shall be retried according to a configurable policy and shall not silently lose the underlying event (e.g. a missed payment-confirmation webhook must not leave a transaction permanently in an ambiguous state).

## 11. Sync-Specific API Requirements

### FR-IAPI-026 — Batch Sync Endpoint

The API shall provide a batch-oriented endpoint for the mobile application's outbox synchronization (per OSDS Section 13), accepting multiple queued records in a single request where practical, to reduce round trips over constrained connections.

### FR-IAPI-027 — Idempotency Key Support

Every mutating API request relevant to offline sync shall accept and honour a client-supplied idempotency key (per OSDS FR-OSDS-022), returning the original result for a repeated key rather than reprocessing it.

### FR-IAPI-028 — Delta/Incremental Retrieval

The API shall support incremental data retrieval (e.g. "give me records changed since timestamp X") for reference data and assigned-scope data, supporting OSDS's delta-sync and payload-minimization requirements (FR-OSDS-035).

## 12. Documentation & Discoverability

### FR-IAPI-029 — API Documentation

The API shall be documented in a machine-readable format (e.g. OpenAPI/Swagger) sufficient for a new developer, or a future third-party integration partner, to understand available endpoints, request/response structures and authentication requirements without needing to read backend source code.

### FR-IAPI-030 — Documentation Currency

API documentation shall be kept current with each released version; a documented deprecation and versioning process (Section 6) shall apply so documentation does not silently drift from actual behaviour.

## 13. Monitoring, Logging & Diagnostics

### FR-IAPI-031 — Request Logging

The API shall log sufficient information about each request (endpoint, user/device, response status, duration, request ID) to support diagnosis of integration failures, consistent with the audit logging standard defined in ACRM.

### FR-IAPI-032 — Correlation/Request IDs

Every API request shall carry a unique request ID, propagated through logs and included in error responses, so a specific failed mobile-app action can be traced end-to-end through backend logs when a field user reports an issue.

### FR-IAPI-033 — Integration Health Monitoring

The system shall monitor the health of external provider integrations (SMS, email, storage, payments) and shall surface provider outages or degraded performance on the System Health Dashboard introduced in SACM (FR-SACM-035).

```
INTEGRATION HEALTH
SMS Provider:        ● Operational (last 24h delivery rate: 96%)
Email Provider:      ● Operational
File Storage:        ● Operational
Payment Gateway:     ○ Not yet configured
```

## 14. Data Format & Localization

### FR-IAPI-034 — Consistent Data Formats

The API shall use consistent, unambiguous formats for dates, currency and numbers (e.g. ISO 8601 dates, Maloti amounts as decimal values with explicit currency code) across all endpoints, avoiding the ambiguity that arises when different modules pick different conventions independently.

### FR-IAPI-035 — Localized Content Delivery

Where the API returns user-facing text (e.g. validation messages, notification template content per NCM Section 16), it shall support the platform's configured languages (English, Sesotho, per SACM FR-SACM-022) via a language parameter or the authenticated user's stored preference.

## 15. Relationship to Other Modules

```
                         IAPI
                          │
     ┌─────────┬──────────┼──────────┬─────────┐
     ▼         ▼          ▼          ▼         ▼
   SACM      OSDS        NCM        DFM      ACRM
 (auth,    (sync auth, (provider  (provider (audit
 access    idempotency, abstraction abstraction log of
 control,  batch sync) - SMS/Email) - storage)  API
 tokens)                                        activity)
```

**BR-IAPI-002** — IAPI shall provide the single authentication, authorization and provider-abstraction layer relied upon by every other module; individual modules shall not implement their own independent authentication checks or provider integrations outside this layer.

This closes the loop on a principle that has run through the entire Chapter 4 specification: **CRM does not duplicate Sales' transactional data (BR-CRM-015); operational modules do not duplicate SACM's reference data (BR-SACM-001); ACRM consumes rather than re-implements module audit trails (BR-ACRM-001); OSDS provides the one shared sync engine (BR-OSDS-002); and now IAPI provides the one shared integration layer.** PigPower's architecture is deliberately built as a set of cooperating modules around shared, centralized services — not a collection of disconnected CRUD applications, echoing the explicit design intent stated in the CRM module (Section 68).

## 16. Core Entities

```
ApiClient
ApiClientVersion
AccessToken
RefreshToken
DeviceRegistration

RateLimitPolicy
RateLimitEvent

ProviderConfig            (references SACM's ProviderConfiguration)
ProviderAdapter
ProviderFailoverRule

WebhookEndpoint
WebhookEvent
WebhookVerificationLog

ApiRequestLog
IdempotencyRecord         (shared concept with OSDS)

ApiVersion
ApiDeprecationSchedule
```

## 17. Functional Requirements Summary

| ID | Requirement |
|---|---|
| IAPI-FR-001 | The API shall follow consistent REST conventions. |
| IAPI-FR-002 | The API shall follow consistent resource/field naming. |
| IAPI-FR-003 | The API shall use a standard success response envelope. |
| IAPI-FR-004 | The API shall use a standard error response format. |
| IAPI-FR-005 | Collection endpoints shall support consistent pagination. |
| IAPI-FR-006 | Collection endpoints shall support consistent filtering/sorting. |
| IAPI-FR-007 | The API shall be versioned. |
| IAPI-FR-008 | The API shall support a deprecation window for old versions. |
| IAPI-FR-009 | The API shall enforce minimum supported client versions. |
| IAPI-FR-010 | The API shall use token-based authentication with refresh. |
| IAPI-FR-011 | The API shall support device registration. |
| IAPI-FR-012 | The API shall enforce role-based authorization on every request. |
| IAPI-FR-013 | The API shall enforce scoped authorization at the data-access level. |
| IAPI-FR-014 | The API shall support immediate token revocation. |
| IAPI-FR-015 | The API shall support restricted external/read-only tokens. |
| IAPI-FR-016 | The API shall enforce configurable rate limits. |
| IAPI-FR-017 | The API shall return a graceful, retry-aware rate-limit response. |
| IAPI-FR-018 | The system should flag anomalous API usage patterns. |
| IAPI-FR-019 | The API shall expose a stable provider abstraction interface. |
| IAPI-FR-020 | Provider credentials shall be isolated from client applications. |
| IAPI-FR-021 | The provider layer shall support failover where configured. |
| IAPI-FR-022 | The API shall provide secure webhook receivers. |
| IAPI-FR-023 | Webhooks shall be authenticity-verified. |
| IAPI-FR-024 | Webhook processing shall be idempotent. |
| IAPI-FR-025 | Failed webhook processing shall retry without losing the event. |
| IAPI-FR-026 | The API shall provide a batch sync endpoint. |
| IAPI-FR-027 | Mutating endpoints shall honour client idempotency keys. |
| IAPI-FR-028 | The API shall support incremental/delta data retrieval. |
| IAPI-FR-029 | The API shall be documented in a machine-readable format. |
| IAPI-FR-030 | API documentation shall be kept current per version. |
| IAPI-FR-031 | The API shall log requests sufficient for diagnostics. |
| IAPI-FR-032 | Every request shall carry a traceable correlation/request ID. |
| IAPI-FR-033 | The system shall monitor external integration health. |
| IAPI-FR-034 | The API shall use consistent date/currency/number formats. |
| IAPI-FR-035 | The API shall support localized user-facing content. |

## 18. Non-Functional Requirements

**Security** — All API traffic shall be encrypted in transit (TLS); authentication and authorization shall be enforced on every request with no unauthenticated write endpoints outside explicitly justified exceptions (e.g. initial login).

**Reliability** — The API shall provide predictable, well-defined behaviour on failure (clear error codes) rather than ambiguous timeouts or silent failures, particularly given the offline-retry behaviour built into the mobile app.

**Performance** — API response times shall remain acceptable under expected pilot-phase and growth-phase load; batch/sync endpoints shall be optimized for the constrained-connectivity conditions described in OSDS.

**Scalability** — The API architecture shall support growth from pilot-phase traffic to the 500-farmer, national-scale vision without a fundamental redesign.

**Backward Compatibility** — Introducing a new API version shall not break mobile app installations still running a supported older version during the deprecation window.

**Maintainability** — Provider integrations shall be replaceable without changes to business-logic modules, per the abstraction principle in Section 9.

**Observability** — Integration failures shall be diagnosable from logs and monitoring without requiring code changes to add basic visibility.

**Cost Efficiency** — The integration architecture shall avoid unnecessary managed-service costs where a simpler self-hosted or lower-cost option meets the requirement, consistent with the cost-conscious approach already established for storage in DFM Section 49.

## 19. Example End-to-End Scenario — Mobile App Login and First Sync

```
Step 1
Field Officer opens the Flutter app and logs in with username/password.

Step 2
API authenticates the credentials, issues an Access Token and
Refresh Token, and registers the device (FR-IAPI-011).

Step 3
App requests its offline data scope (per OSDS §6): farmers, farms
and reference data for the officer's assigned district (Berea),
using the incremental retrieval endpoint (FR-IAPI-028) since this
is the device's first sync, retrieving the full initial dataset.

Step 4
Data is cached locally per OSDS's local data model.

Step 5
Officer works in the field, offline, for several hours, queuing
records in the outbox.

Step 6
Connectivity returns. App calls the batch sync endpoint
(FR-IAPI-026), submitting all queued items with their idempotency
keys in a single request.

Step 7
API validates, assigns authoritative IDs, and returns a structured
response confirming each item or explaining any rejection
(FR-IAPI-004), which the app uses to update its local outbox state.

Step 8
The entire exchange is logged with a correlation ID (FR-IAPI-032),
so that if the officer later reports "my data didn't save," support
staff can trace exactly what happened.
```

## 20. Example End-to-End Scenario — SMS Provider Outage

```
Step 1
PigPower's primary SMS provider experiences an outage.

Step 2
Farmer settlement notifications (per NCM §24) begin failing to send.

Step 3
The provider abstraction layer's failover logic (FR-IAPI-021)
attempts the configured secondary SMS provider, if one is set up.

Step 4
If no secondary provider is configured, failed sends are queued
and retried per the configured retry policy (NCM §35).

Step 5
Integration health monitoring (FR-IAPI-033) flags the primary
provider as degraded on the System Health Dashboard.

Step 6
Administrators are alerted and can manually reconfigure the active
SMS provider in SACM (FR-SACM-030) if the outage is prolonged.

Step 7
Once resolved, queued messages resume sending; each still carries
its original idempotency safeguard, preventing farmers from
receiving duplicate settlement notifications once service resumes.
```

## 21. Recommended GitHub File

Create:

```
docs/SRS/Chapter4/IntegrationAPIManagement.md
```

Then commit it:

```
git add docs/SRS/Chapter4/IntegrationAPIManagement.md
git commit -m "docs: add integration and API management requirements"
git push
```

## 22. Chapter 4 Complete

With this module, **Chapter 4: Functional Requirements** is now complete:

```
1.  Authentication
2.  User Management
3.  Farmer Management
4.  Farm Management
5.  Pig Management
6.  Production Management
7.  Veterinary Management
8.  Feed Management
9.  Collection & Logistics
10. Processing & Meat Production
11. Inventory & Warehouse
12. Sales & Orders
13. Customer & CRM
14. Farmer Payments & Settlements
15. Finance & Accounting
16. Procurement & Suppliers
17. HR & Payroll
18. Renewable Energy & Biodigester
19. Impact, Monitoring & Evaluation
20. Reporting & Business Intelligence
21. Notification & Communication
22. Document & File Management
23. System Administration & Configuration
24. Audit, Compliance & Regulatory Management
25. Offline Synchronization & Data Synchronization
26. Integration & API Management            ← this document
```

Across these 26 modules, a small number of architectural principles have been established repeatedly and consistently, and are worth restating together now that Chapter 4 is closed:

```
1. Modules own their transactional data; other modules reference it, not duplicate it.
   (BR-CRM-015, BR-SACM-001, BR-ACRM-001)

2. Shared cross-cutting concerns get ONE implementation, used by all modules:
      Notifications  → NCM
      Documents      → DFM
      Configuration  → SACM
      Audit          → ACRM
      Offline Sync   → OSDS
      API/Integration → IAPI

3. External providers sit behind a stable abstraction; credentials never
   reach the Flutter client. (NCM §51, DFM §49, IAPI §9)

4. Every module distinguishes observed fact, calculated metric, forecast,
   and AI recommendation. (RBIM §48)

5. Every module is designed for a distributed, rural, intermittently
   connected operating environment from the outset, not as an afterthought.
```

## 23. Next Steps — Moving to Chapter 5

With functional requirements complete, the SRS should now move into:

```
Chapter 5 — System Architecture
   5.1  Overall System Architecture
   5.2  Database Architecture (PostgreSQL vs. MySQL/MariaDB vs. others)
   5.3  File/Object Storage Architecture (local vs. self-hosted vs. S3-compatible)
   5.4  Backend Application Architecture
   5.5  API Architecture (detailed endpoint specification, building on this module)
   5.6  Flutter Mobile Application Architecture
   5.7  Offline Data Architecture (detailed local schema, building on OSDS)
   5.8  Security Architecture
   5.9  Deployment & Infrastructure Architecture
   5.10 Cost Model for Chosen Architecture
```

This is where the open decisions flagged throughout Chapter 4 — database technology, file storage technology, SMS/email provider selection, hosting approach — get evaluated against the requirements now on record and formally decided, with the cost-conscious, low-recurring-cost constraint you specified in the Document & File Management module (Section 49) carried through as a first-class evaluation criterion.

I'd recommend starting Chapter 5 with **5.2 Database Architecture**, since the database choice affects nearly every other architectural decision (ORM/framework choice, hosting cost, offline-sync implementation strategy, backup approach) — but 5.1 Overall System Architecture (the big-picture component diagram) is also a reasonable place to start if you'd rather set the overall shape before drilling into the database specifically.
