PigPower SmartFarm Platform
Software Requirements Specification — System Architecture
Section: 5.4 — Backend Application Architecture

Document ID: PSP-ARCH-5.4-BE
Version: 1.0
Status: Draft
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 5 – System Architecture
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

## 1. Purpose of This Document

This document finalizes the backend framework decision previewed in 5.2 (`AD-DB-003`) and defines the concrete application structure: how the 26 Chapter 4 modules are organized in code, how the modular-monolith and event-driven decisions from 5.1 (`AD-SYS-002`, `AD-SYS-004`) are actually implemented, and how cross-cutting concerns (authentication, authorization, audit logging, error handling, storage access) are applied consistently across every module rather than reimplemented per module.

## 2. Framework Decision (Finalized)

### AD-BE-001 — Backend Framework Selection

**Decision: PigPower's backend shall be built with NestJS (Node.js, TypeScript), using Prisma as the ORM, connecting to the PostgreSQL database selected in `AD-DB-001`.**

This finalizes the working recommendation made in `AD-DB-003`. The reasoning is restated and completed here:

| Requirement | How NestJS + Prisma Satisfies It |
|---|---|
| Modular monolith (`AD-SYS-002`) | NestJS's `@Module()` system is a direct, native implementation of module boundaries — each Chapter 4 module becomes a NestJS module with its own controllers, services and Prisma models |
| In-process event mechanism (`AD-SYS-004`) | NestJS's `EventEmitterModule` provides exactly the publish/subscribe pattern needed, with no external message broker |
| Standard API conventions (IAPI §5) | NestJS's decorators, pipes, guards, interceptors and exception filters provide a structured, consistent way to enforce IAPI's response envelope, error format, pagination and validation rules platform-wide, not per endpoint |
| Role-based authorization (SACM, IAPI §7) | NestJS Guards provide a single, reusable enforcement point for role/permission checks — implemented once, applied everywhere |
| Type safety and schema discipline (supports ACRM's data-integrity goals) | TypeScript end-to-end, and Prisma's generated types keep the database schema and application code from silently drifting apart |
| Offline sync batch endpoints, idempotency (OSDS, IAPI §11) | NestJS's request pipeline and Prisma's transaction support both handle batch, idempotent operations cleanly |
| Small-team operability (`AD-SYS-001`) | Widely documented, large community, no proprietary licensing, straightforward local development setup |

**If reconsidered later:** the Django/DRF alternative documented in `AD-DB-003` remains valid and would require re-deriving this document's module structure in Django's app/model conventions instead — but no code exists yet, so this is the point of lowest cost to make that call if the actual development team's skillset points the other way.

## 3. Application Structure

### FR-BE-001 — Module Folder Structure

The backend source tree shall mirror Chapter 4's module list directly, so anyone navigating the codebase can find a module by the same name used in the SRS:

```
/src
  /modules
    /auth                 (Authentication — underpins all modules)
    /users                (User Management)
    /farmer
    /farm
    /pig
    /production
    /veterinary
    /feed
    /logistics
    /processing
    /inventory
    /sales
    /crm
    /payments             (Farmer Payments & Settlements)
    /finance
    /procurement
    /hr
    /energy               (Renewable Energy & Biodigester)
    /me                   (Impact, Monitoring & Evaluation)
    /reporting            (Reporting & Business Intelligence)
    /notifications
    /documents
    /sacm                 (System Administration & Configuration)
    /acrm                 (Audit, Compliance & Regulatory)
    /sync                 (Offline/Data Synchronization support)

  /common
    /guards               (auth, roles/permissions, scope enforcement)
    /interceptors         (audit logging, response envelope, request ID)
    /filters              (standard error format — IAPI §5)
    /decorators           (e.g. @CurrentUser, @RequirePermission)
    /pipes                (validation)

  /storage
    storage.module.ts     (Storage Service interface — 5.3 AD-FS-001)
    /drivers
      local.driver.ts
      minio.driver.ts     (added when 5.3's growth trigger is reached)
      s3-compatible.driver.ts

  /providers
    /sms
    /email
    /payment              (future)

  /events
    event-catalog.ts       (mirrors NCM §46's Notification Event Catalog)

  /database
    prisma/
      schema.prisma        (organized per FR-DB-001's namespace principle)
      migrations/

  main.ts
  app.module.ts
```

### FR-BE-002 — Standard Module Internal Structure

Each module folder shall follow a consistent internal pattern, so a developer familiar with one module (e.g. `farmer`) can immediately navigate any other (e.g. `veterinary`) without relearning conventions:

```
/modules/farmer
  farmer.module.ts
  farmer.controller.ts        (API endpoints — thin, delegates to service)
  farmer.service.ts           (business logic)
  /dto
    create-farmer.dto.ts       (validated request shapes — IAPI §5 pipes)
    update-farmer.dto.ts
  /entities                    (Prisma-generated types re-exported/extended)
  farmer.events.ts             (events this module emits/listens to)
  farmer.repository.ts         (Prisma queries isolated from business logic)
```

### FR-BE-003 — No Cross-Module Direct Database Access

Consistent with `BR-CRM-015` and `BR-SACM-001`, a module's repository layer shall be the *only* code permitted to query that module's Prisma models directly. Other modules that need that data shall call the owning module's service layer (in-process function call, since this is a monolith) rather than querying its tables directly — preserving clean module boundaries even though everything runs in one process and one database.

```
CRM Module needs Farmer data
         │
         ▼
   FarmerService.findById(id)     ✓ correct — goes through owning module
         │
         X   PrismaClient.farmer.findUnique(...)   ✗ wrong — bypasses ownership
```

## 4. Cross-Cutting Concerns Implementation

### FR-BE-004 — Authentication Guard

A single `AuthGuard`, applied globally, shall validate the access token (per `IAPI FR-IAPI-010`) on every request except explicitly marked public endpoints (e.g. login), attaching the authenticated user and device context for downstream use.

### FR-BE-005 — Authorization Guard

A single `PermissionsGuard`, working from a `@RequirePermission('farmer.approve')`-style decorator on each endpoint, shall enforce SACM's role-permission matrix (`SACM FR-SACM-003`) centrally, reading the current role-permission configuration rather than hard-coding permission checks inside individual services.

### FR-BE-006 — Scope Guard

Where a user's role is geographically or organizationally scoped (`SACM FR-SACM-004`), a `ScopeGuard` shall filter or reject requests outside that scope at the data-access level, satisfying `IAPI FR-IAPI-013`.

### FR-BE-007 — Audit Interceptor

A single `AuditInterceptor`, applied globally, shall capture the minimum audit event content defined in `ACRM FR-ACRM-001` (actor, action, entity, timestamp, before/after values where applicable) for every mutating request, publishing it as an internal event (Section 5 below) rather than writing directly to the audit log from application code scattered across modules.

### FR-BE-008 — Response Envelope Interceptor

A single `ResponseInterceptor` shall wrap every successful response in IAPI's standard envelope (`IAPI FR-IAPI-003`), so individual controllers never need to construct that structure manually.

### FR-BE-009 — Exception Filter

A single global `ExceptionFilter` shall translate any thrown error (validation failure, not-found, permission denied, unexpected server error) into IAPI's standard error format (`IAPI FR-IAPI-004`), ensuring the Flutter app always receives a predictable shape regardless of which module or code path produced the error.

### FR-BE-010 — Request ID / Correlation Middleware

Middleware shall attach a unique request ID to every incoming request (`IAPI FR-IAPI-032`), propagated through logs, the audit interceptor, and included in any error response.

### FR-BE-011 — Validation Pipes

Every endpoint accepting a request body shall validate it against a defined DTO (Data Transfer Object) shape before it reaches business logic, using class-validator-style decorators, so malformed input is rejected consistently with a clear validation error (`IAPI FR-IAPI-004`) rather than causing a downstream failure inside a service.

## 5. Event-Driven Communication (Implementation of AD-SYS-004)

### FR-BE-012 — Event Emitter as the Cross-Module Communication Mechanism

NestJS's `EventEmitterModule` shall be the concrete implementation of the in-process event mechanism decided in `AD-SYS-004`. Modules shall communicate side effects via emitted events rather than directly calling into unrelated modules' services wherever the relationship is a "reaction to," not a "dependency on."

```typescript
// production.service.ts
this.eventEmitter.emit('production.batch_ready', {
  batchId: batch.id,
  farmId: batch.farmId,
  timestamp: new Date(),
});

// notifications/listeners/production.listener.ts
@OnEvent('production.batch_ready')
handleBatchReady(payload: ProductionBatchReadyEvent) {
  // send farmer + collection officer notification, per NCM §11
}

// acrm/listeners/audit.listener.ts
@OnEvent('**')  // wildcard — every event is a candidate audit entry
handleAnyEvent(payload: unknown, eventName: string) {
  // record to audit log per ACRM FR-ACRM-001
}
```

### FR-BE-013 — Event Catalog as Source of Truth

The `event-catalog.ts` file shall maintain a typed registry of every event name and payload shape used across the platform, directly implementing NCM §46's "Notification Event Catalog" concept in code, and extended to cover non-notification events (e.g. audit-relevant events that don't necessarily trigger a farmer-facing notification).

### FR-BE-014 — Events Are Not a Replacement for Transactional Consistency

Where an operation must be atomic (e.g. recording a settlement and updating the farmer's outstanding balance together), that atomicity shall be handled within a single Prisma transaction inside the owning module's service — events shall be used for side effects and cross-module reactions (notifications, audit, BI updates), never as a substitute for a database transaction where strict consistency is required.

## 6. Storage & Provider Integration

### FR-BE-015 — Storage Module as a Shared NestJS Module

The Storage Service defined in `5.3 AD-FS-001` shall be implemented as a shared, globally available NestJS module (`/storage`), injected into any module needing file access (Documents, HR, Farmer, Veterinary, etc.), with the active driver (local, per `AD-FS-002`) selected via environment configuration — never hard-coded into a consuming module.

### FR-BE-016 — Provider Modules as Shared NestJS Modules

SMS, email and future payment provider integrations (`IAPI §9`) shall similarly be implemented as shared modules under `/providers`, each exposing a stable interface (e.g. `SmsProviderService.send(...)`) regardless of which concrete provider is configured in SACM.

## 7. Background Processing & Scheduled Jobs

### AD-BE-002 — Job Scheduling Approach at Pilot Scale

**Decision: PigPower shall use NestJS's built-in `@nestjs/schedule` module for background/scheduled work during the pilot phase (compliance obligation due-date checks per ACRM, certificate expiry checks per DFM, notification retry sweeps per NCM), rather than introducing a dedicated job queue system (e.g. BullMQ + Redis) before volume justifies it.**

| Option | Verdict |
|---|---|
| Dedicated job queue (BullMQ + Redis) | Deferred — adds an additional infrastructure component (Redis) and operational surface area beyond what pilot-phase volume requires |
| **In-process scheduled tasks (`@nestjs/schedule`)** | **Selected for pilot phase** — zero additional infrastructure, sufficient for the scheduled-check style tasks Chapter 4 describes (e.g. "check daily for expiring certificates") |

```
Examples of scheduled tasks at pilot scale:
   - Daily: certificate/licence expiry check (DFM §31)
   - Daily: compliance obligation due-date check (ACRM §13)
   - Hourly: notification retry sweep for failed sends (NCM §35)
   - Daily: automated backup trigger / verification (5.2 §9, 5.3 §8)
```

**Growth path:** if scheduled/background job volume grows to the point where a single server's in-process scheduler becomes a bottleneck or single point of failure (Stage 2/3 per 5.1 §8), migrating to BullMQ + Redis is a contained change — the job *logic* does not need to be rewritten, only the mechanism that triggers and queues it.

## 8. Configuration Management

### FR-BE-017 — Environment-Based Configuration

Backend configuration (database connection, storage driver selection, provider credentials, JWT secrets) shall be loaded via NestJS's `ConfigModule` from environment variables, never committed to source control, satisfying `FR-SYS-002`'s environment-isolation requirement and IAPI's credential-isolation principle (`IAPI FR-IAPI-020`).

### FR-BE-018 — SACM-Managed Configuration vs. Environment Configuration

A clear line shall be maintained between:

```
ENVIRONMENT CONFIGURATION (.env, infrastructure-level)
   → database URL, storage driver, secrets, ports
   → changed by a developer/deployer, requires a restart

SACM CONFIGURATION (database-stored, application-level)
   → districts, breeds, notification rules, KPI targets, feature flags
   → changed by an authorized administrator, takes effect immediately (SACM §2)
```

This distinction prevents SACM's promise of "no code deployment required" (`SACM §2`) from being accidentally undermined by business configuration that actually lives in environment files.

## 9. API Layer Implementation

### FR-BE-019 — Controller Responsibility Boundary

Controllers shall be limited to request/response handling (routing, DTO validation via pipes, calling the appropriate service method) and shall contain no business logic themselves, keeping business rules testable independently of the HTTP layer.

### FR-BE-020 — API Versioning Implementation

NestJS's built-in URI versioning (`/v1/...`) shall implement the versioning strategy decided in `IAPI FR-IAPI-007`, with the deprecation window (`IAPI FR-IAPI-008`) managed by keeping the previous version's controllers available, marked deprecated, until the migration window closes.

### FR-BE-021 — Sync Endpoint Implementation

The batch sync endpoint required by `IAPI FR-IAPI-026` shall be implemented in the `/sync` module, orchestrating calls into each relevant owning module's service (e.g. a batch containing both production and veterinary records is split and routed internally to `ProductionService` and `VeterinaryService` respectively) while returning a single consolidated response to the mobile client.

## 10. Testing Strategy

### FR-BE-022 — Testing Priorities for a Small Team

Given `AD-SYS-001`'s small-team constraint, testing effort shall be prioritized rather than pursued exhaustively from day one:

```
HIGHEST PRIORITY (test thoroughly):
   - Farmer settlement/payment calculation logic
   - Financial transaction recording
   - Authorization/permission enforcement (guards)
   - Offline sync conflict resolution logic
   - Idempotency handling

MODERATE PRIORITY:
   - Core CRUD operations per module (can rely more on integration tests)
   - Notification rule evaluation

LOWER PRIORITY AT PILOT SCALE (test later as usage grows):
   - Reporting/BI aggregation edge cases
   - Advanced CRM segmentation logic
```

### FR-BE-023 — Test Types

The project shall use unit tests (isolated service logic, particularly the high-priority items above) and integration tests (API endpoint behaviour against a test database), with end-to-end mobile-to-backend testing performed manually during the pilot phase given team-size constraints, formalized later as the team and platform grow.

## 11. Error Handling & Resilience

### FR-BE-024 — Consistent Error Taxonomy

The backend shall use a small, consistent set of application-level error types (e.g. `ValidationError`, `NotFoundError`, `PermissionDeniedError`, `ConflictError`, `BusinessRuleError`) that the global exception filter (`FR-BE-009`) maps to appropriate HTTP status codes and IAPI's standard error format, rather than each module inventing its own error shapes.

### FR-BE-025 — Database Transaction Safety

Multi-step operations affecting financial or compliance-sensitive data (settlements, payments, inventory adjustments) shall be wrapped in Prisma transactions, ensuring partial failures cannot leave the database in an inconsistent state — directly supporting the transactional-integrity requirement that was a primary reason PostgreSQL was selected in `5.2`.

## 12. Deployment Packaging (Preview of 5.9)

### FR-BE-026 — Single Deployable Artifact

Consistent with the modular monolith decision, the backend shall build to a single deployable artifact (e.g. a single Docker container image), containing all 26 modules, deployed as one unit during the pilot phase — full deployment mechanics are addressed in `5.9 Deployment & Infrastructure Architecture`.

## 13. What This Document Does Not Decide

Deferred to later sections:

```
5.5  Detailed, endpoint-by-endpoint API specification
5.6  Flutter application internal architecture
5.7  Detailed offline/local SQLite schema
5.8  Detailed security architecture (encryption specifics, secrets management)
5.9  Specific hosting provider, containerization and deployment mechanics
5.10 Consolidated cost estimate
```

## 14. Summary of Architecture Decisions in This Document

| ID | Decision |
|---|---|
| AD-BE-001 | NestJS + Prisma + PostgreSQL finalized as the backend stack. |
| AD-BE-002 | `@nestjs/schedule` (in-process) used for background/scheduled jobs at pilot scale, deferring a dedicated job queue (BullMQ + Redis) until volume justifies it. |

## 15. Recommended GitHub File

Create:

```
docs/SRS/Chapter5/BackendApplicationArchitecture.md
```

Then commit it:

```
git add docs/SRS/Chapter5/BackendApplicationArchitecture.md
git commit -m "docs: add backend application architecture (chapter 5.4)"
git push
```

## 16. Next Section

**5.5 API Architecture** should be next, taking the conventions established in Chapter 4's IAPI module and this document's controller/versioning approach, and producing the actual endpoint inventory — the concrete list of routes (`GET /v1/farmers`, `POST /v1/production/batches`, `POST /v1/sync/batch`, etc.) grouped by module, with request/response DTO shapes defined per module. This is naturally a large, reference-style document (closer in spirit to an OpenAPI specification than a narrative architecture document), so it may be worth producing it incrementally, module by module, starting with the modules the mobile app needs first for a minimum viable pilot build: Authentication, Farmer, Production, Veterinary, and Sync — rather than attempting all 26 modules' endpoints in one pass.

Alternatively, since you mentioned you're actively implementing the mobile application, it may be more immediately useful to jump to **5.6 Flutter Mobile Application Architecture** next — defining the app's folder structure, state management approach, and how it concretely consumes the API/sync/storage architecture just defined — so you have an architecture document that maps directly onto the code you're writing right now, and return to the full 5.5 API endpoint inventory once the mobile architecture shape is settled.
