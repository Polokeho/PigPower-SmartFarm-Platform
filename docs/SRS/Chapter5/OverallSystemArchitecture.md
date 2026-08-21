PigPower SmartFarm Platform
Software Requirements Specification — System Architecture
Section: 5.1 — Overall System Architecture

Document ID: PSP-ARCH-5.1-SYS
Version: 1.0
Status: Draft
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 5 – System Architecture
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

## 1. Purpose of This Document

Chapter 4 defined **what** the PigPower SmartFarm Platform must do, across 26 functional modules. Chapter 5 now defines **how** it will be built: the technology choices, component boundaries, deployment model and cost structure that will satisfy those requirements.

This document (5.1) establishes the overall shape of the system — the components that exist, how they communicate, and the architectural style the platform will follow. Later sections in this chapter (5.2 Database, 5.3 File Storage, 5.4 Backend, 5.5 API, 5.6 Flutter App, 5.7 Offline Data, 5.8 Security, 5.9 Deployment, 5.10 Cost Model) will each drill into one of the components introduced here.

## 2. Architectural Goals

Before choosing any technology, it is worth restating — in one place — the constraints that should drive every decision in this chapter, since they were established piecemeal across many Chapter 4 modules:

| Goal | Source | Implication |
|---|---|---|
| Low, predictable recurring cost | DFM §49, IAPI §18 | Avoid mandatory managed-service subscriptions where a self-hosted or lower-cost option meets the requirement, especially at pilot scale (M250,000 budget) |
| Offline-first mobile operation | OSDS (whole module) | Backend must support delta sync, idempotent batch writes, and a local-first Flutter data model |
| Modularity without duplicated logic | BR-CRM-015, BR-SACM-001, BR-ACRM-001, BR-OSDS-002, BR-IAPI-002 | Shared concerns (auth, notifications, documents, config, audit, sync, provider access) implemented once, reused everywhere |
| Growth from pilot (dozens of users) to national scale (500+ farmers, thousands of transactions) | SACM §37, IAPI §17 | Architecture must not require a rewrite to scale — but should not over-engineer for scale it doesn't have yet either |
| Small team, single/lean developer capacity | Implicit throughout — this is a founder-led pilot | Favor a small number of well-understood technologies over a large, specialized stack requiring a bigger team to operate |
| Auditable, compliant, investor/BEDCO-ready | ACRM (whole module) | Architecture must support reliable audit logging, data integrity and reproducible reporting from day one |

**AD-SYS-001 (Architecture Decision)** — These six goals take precedence over any individual technology preference. Where a popular or "modern" technology conflicts with cost, team size, or offline-first requirements, the simpler and cheaper option should generally win at this stage of PigPower's life, with a documented upgrade path for later.

## 3. High-Level Component Architecture

```
                         ┌─────────────────────────┐
                         │   FLUTTER MOBILE APP     │
                         │  (Farmers, Field Staff,  │
                         │  Vets, Drivers, Sales)   │
                         └────────────┬─────────────┘
                                      │
                         ┌────────────┴─────────────┐
                         │   ADMIN WEB CONSOLE       │
                         │   (future — Phase 2)      │
                         └────────────┬─────────────┘
                                      │
                                      ▼
                         ┌─────────────────────────┐
                         │       API LAYER          │
                         │  (auth, rate limiting,   │
                         │   versioning — Ch.4 IAPI)│
                         └────────────┬─────────────┘
                                      │
                         ┌────────────┴─────────────┐
                         │   BACKEND APPLICATION     │
                         │        (modular)          │
                         │                            │
                         │  Farmer | Production | Vet │
                         │  Feed | Logistics | Sales  │
                         │  CRM | Payments | Finance  │
                         │  HR | Energy | M&E | BI    │
                         │  Notifications | Documents │
                         │  SACM | ACRM | OSDS        │
                         └──┬───────────┬────────────┘
                            │           │
                 ┌──────────┘           └──────────┐
                 ▼                                 ▼
       ┌───────────────────┐             ┌───────────────────┐
       │   TRANSACTIONAL    │             │  FILE / OBJECT     │
       │      DATABASE      │             │     STORAGE        │
       │   (see 5.2)         │             │    (see 5.3)        │
       └───────────────────┘             └───────────────────┘
                            │
                            ▼
                 ┌───────────────────────┐
                 │  PROVIDER ABSTRACTION   │
                 │        LAYER            │
                 └──────────┬──────────────┘
                            │
          ┌─────────────────┼─────────────────┐
          ▼                 ▼                 ▼
        SMS              Email            Payment
      Provider          Provider          Gateway
     (external)         (external)        (future)
```

## 4. Architectural Style: Modular Monolith

### AD-SYS-002 — Modular Monolith vs. Microservices

**Decision: PigPower's backend shall be built as a modular monolith, not a microservices architecture, at this stage.**

| Option | Considered | Verdict |
|---|---|---|
| Microservices (one deployable service per Chapter 4 module) | Yes | Rejected for now — too much operational overhead (26 modules ≈ 26 services) for a lean pilot team; higher hosting cost; higher complexity for a single/small developer team to operate reliably |
| Single undifferentiated application (no internal module boundaries) | Yes | Rejected — would recreate the "collection of disconnected CRUD applications" problem explicitly rejected in the CRM module (Section 68), and would make the shared-service principles (BR-CRM-015 etc.) hard to enforce in practice |
| **Modular monolith** (one deployable application, internally organized into clearly bounded modules matching Chapter 4) | Yes | **Selected** |

A modular monolith means:

```
ONE deployable backend application
         │
         ▼
Internally organized into modules that mirror Chapter 4 exactly:

   /modules
      /farmer
      /production
      /veterinary
      /feed
      /logistics
      /processing
      /inventory
      /sales
      /crm
      /payments
      /finance
      /procurement
      /hr
      /energy
      /me            (Impact, Monitoring & Evaluation)
      /reporting
      /notifications
      /documents
      /sacm          (System Administration & Configuration)
      /acrm          (Audit, Compliance & Regulatory)
      /sync          (Offline/Data Synchronization support)
      /api           (Integration & API layer itself)
```

Each module:

- owns its own data tables/entities (per BR-CRM-015's "modules own their transactional data" principle);
- exposes a clear internal interface to other modules (no module reaches directly into another module's database tables);
- can, in principle, be extracted into a separate service later if a specific module's load genuinely requires it (e.g. if Reporting/BI eventually needs a dedicated analytics database, per RBIM §57's "recommended analytical architecture").

**Rationale**: this gives PigPower the discipline and clean boundaries of microservices (avoiding a tangled "big ball of mud"), while keeping deployment, hosting cost and operational complexity at the level appropriate for a founder-led pilot team. The module boundaries defined in Chapter 4 already map cleanly onto this structure — the modular monolith is really just "Chapter 4's module list, implemented as one application."

## 5. Client Applications

### 5.1 Flutter Mobile Application (Primary Client)

The primary and most important client, per OSDS. Used by:

```
Field Officers      → farmer/farm management, production capture
Veterinarians        → veterinary record capture
Drivers               → collection/logistics
Farmers (self-service) → own profile, production, payments
Sales Representatives → CRM, orders (where connectivity allows)
Managers              → dashboards, approvals (subset of admin functions)
```

### AD-SYS-003 — Single App vs. Multiple Apps per Role

**Decision: PigPower shall build a single Flutter application with role-based UI, not separate apps per user type.**

| Option | Verdict |
|---|---|
| Separate apps (Farmer App, Field Officer App, Driver App, etc.) | Rejected — multiplies build, testing, release and app-store maintenance effort for a small team; role-based screens within one app achieve the same UX outcome at a fraction of the ongoing cost |
| **Single app, role-based navigation/screens** (per SACM's mobile feature flags, FR-SACM-027) | **Selected** |

The app shall determine which screens/features to show based on the authenticated user's role and permissions (from SACM), consistent with the feature-flag mechanism already specified.

### 5.2 Admin Web Console (Phase 2)

A browser-based console for functions less suited to mobile (bulk configuration per SACM, complex reporting per RBIM, document data-room management per DFM, audit/compliance review per ACRM). This is explicitly **out of scope for the pilot phase** and should reuse the same backend API — no separate backend is required for it.

### 5.3 Future External Integrations

The API layer (IAPI) is designed to support future partner integrations (e.g. a retail buyer's own ordering system) without requiring architectural change, but no such integration is in scope for the pilot.

## 6. Backend Application

Detailed technology selection for the backend framework belongs in Section 5.4, but the overall architecture assumes:

```
ONE backend application
   │
   ├── exposes the API defined in Chapter 4 (IAPI)
   ├── internally organized as a modular monolith (Section 4 above)
   ├── connects to ONE primary transactional database (5.2)
   ├── connects to ONE file/object storage system (5.3)
   └── connects to external providers via the abstraction layer (IAPI §9)
```

### AD-SYS-004 — Synchronous vs. Event-Driven Internal Communication

Several Chapter 4 modules describe event-driven behaviour (e.g. NCM's "Event-Driven Communication," Section 13; SACM's configuration-change events feeding ACRM's audit trail).

**Decision: PigPower shall use a lightweight internal event mechanism (in-process event emitter/observer pattern) within the modular monolith, not a separate message-broker infrastructure (e.g. Kafka, RabbitMQ), at pilot scale.**

```
Module A performs an action
         │
         ▼
   Emits an internal event
   (e.g. PRODUCTION_BATCH_READY)
         │
         ▼
   Other modules subscribed to that event react
   (Notification module sends alert,
    BI module updates a metric,
    ACRM logs the audit event)
```

This preserves the event-driven design intent from Chapter 4 without introducing the hosting cost and operational complexity of a dedicated message broker before PigPower's transaction volume justifies it. A documented upgrade path exists: because modules already communicate via events rather than direct calls, migrating to a real message broker later (if the platform outgrows the modular monolith) is a targeted infrastructure change, not an application rewrite.

## 7. Environments

### FR-SYS-001 — Environment Separation

The platform shall maintain, at minimum, two environments:

```
PRODUCTION     → live PigPower data, farmers, real transactions
STAGING/TEST   → safe environment for testing changes before release
```

A dedicated local development environment (per-developer) is assumed in addition to these.

### FR-SYS-002 — Configuration Isolation Between Environments

Environment-specific configuration (database connection, provider credentials, feature flags) shall be isolated per environment, consistent with IAPI's requirement that provider credentials never live in client code — the same discipline applies to environment configuration on the backend.

## 8. Scalability Path

### AD-SYS-005 — Designed Growth Path, Not Premature Scale

The architecture shall support the following growth path without requiring a fundamental redesign at each stage:

```
STAGE 1 — Pilot (Year 1)
   ~30 farmers, ~10 staff users, single small server,
   modular monolith, single database instance.

STAGE 2 — Network Expansion (Year 2)
   ~90-200 farmers, growing staff, same architecture,
   vertically scaled server (more CPU/RAM) if needed,
   read-replica database if reporting load requires it (per RBIM §57).

STAGE 3 — National Scale (Year 3-5)
   Up to 500+ farmers, national facility, higher transaction volume.
   Modules with genuinely distinct scaling needs (e.g. Reporting/BI,
   per RBIM §57's "avoid unnecessary infrastructure... expand when
   transaction volume justifies it") may be extracted from the
   modular monolith into dedicated services at this stage — this is
   the point at which the microservices question should be revisited,
   not before.
```

This directly mirrors the phased approach already established for AI/forecasting in RBIM Section 47 ("Phase 1: rule-based analytics... Phase 4: AI decision-support") — start simple, and let real operational scale justify each increase in architectural complexity.

## 9. Security Architecture (Overview)

Detailed security architecture belongs in Section 5.8, but at the overall-architecture level:

```
CLIENT ←──TLS (encrypted transit)──→ API LAYER
                                          │
                                    Token-based auth (IAPI §7)
                                          │
                                    Role-based authorization (SACM)
                                          │
                                    Module-level access checks
                                          │
                                    Encrypted data at rest (database + storage)
```

**BR-SYS-001** — No client application (Flutter app or future admin console) shall connect directly to the database or to external providers; all access flows through the API layer, consistent with BR-IAPI-001.

## 10. Data Flow Example — Tying the Architecture to Chapter 4

To confirm this architecture actually supports the functional requirements already specified, consider the collection-and-payment scenario referenced across multiple Chapter 4 modules:

```
1. Field Officer (Flutter app, offline) records pig ready for collection
        → stored in local DB, queued in outbox (OSDS)

2. Connectivity restored → batch synced to API layer (IAPI §11)
        → API authenticates device, authorizes request, validates payload

3. Backend "Production" module processes the record
        → emits PIG_BATCH_READY event (Section 6 above)

4. "Notification" module (subscribed to that event) sends
   Farmer + Driver notifications (NCM)

5. "Logistics" module schedules the collection

6. On completion, "Payments" module calculates and records
   the farmer settlement

7. "Finance" module reflects the transaction in financial records

8. "Notification" module sends the payment-processed SMS

9. "ACRM" audit layer has logged every step above via the shared
   internal event mechanism, without any module needing to
   implement its own audit logging from scratch

10. "Reporting/BI" module's dashboards reflect the new production
    and payment data on its next scheduled refresh (RBIM §58)
```

This end-to-end flow touches eight Chapter 4 modules and never requires a client to talk to anything other than the single API layer, nor requires any module to duplicate another module's data — confirming the architecture satisfies the principles established in Chapter 4.

## 11. What This Document Does Not Decide

To keep this document focused on overall shape, the following are deliberately deferred to later sections of Chapter 5:

```
5.2  Which specific database engine (PostgreSQL, MySQL/MariaDB, etc.)
5.3  Which specific file/object storage approach
5.4  Which specific backend language/framework
5.5  Detailed endpoint-by-endpoint API specification
5.6  Flutter app internal architecture (state management, folder structure)
5.7  Detailed local/offline database schema
5.8  Detailed security architecture (encryption specifics, secrets management)
5.9  Specific hosting provider and deployment mechanics
5.10 Actual cost estimates for the chosen stack
```

## 12. Summary of Architecture Decisions in This Document

| ID | Decision |
|---|---|
| AD-SYS-001 | Cost, offline-first support, and small-team operability take precedence over technology trends when choices conflict. |
| AD-SYS-002 | Backend shall be a modular monolith, not microservices, at this stage. |
| AD-SYS-003 | Single Flutter app with role-based UI, not separate apps per role. |
| AD-SYS-004 | Internal module communication uses an in-process event mechanism, not a message broker, at pilot scale. |
| AD-SYS-005 | A defined three-stage growth path avoids both premature scaling investment and a future rewrite. |

## 13. Recommended GitHub File

Create:

```
docs/SRS/Chapter5/OverallSystemArchitecture.md
```

Then commit it:

```
git add docs/SRS/Chapter5/OverallSystemArchitecture.md
git commit -m "docs: add overall system architecture (chapter 5.1)"
git push
```

## 14. Next Section

**5.2 Database Architecture** should be next, since several decisions in this document depend on it being resolved (the read-replica scaling note in Section 8, the offline-sync data model in OSDS, and the cost model in 5.10 all hinge on which database engine is selected). That section should evaluate PostgreSQL, MySQL/MariaDB and SQLite-adjacent options specifically against:

- the offline-sync and conflict-resolution requirements from OSDS;
- the reporting/analytics query patterns anticipated by RBIM;
- realistic self-hosting cost at pilot scale, per the DFM Section 49 cost-consciousness principle;
- ecosystem maturity for whichever backend framework is selected in 5.4 (which, in turn, means 5.2 and 5.4 are somewhat coupled decisions worth making together).

Given that coupling, an alternative approach is to do **5.4 Backend Application Architecture** immediately after this document and resolve 5.2 Database Architecture as part of the same conversation, since the practical framework/database pairing (e.g. Node.js+PostgreSQL, or Python/Django+PostgreSQL) is usually decided as one choice rather than two independent ones in a small-team project like this.
