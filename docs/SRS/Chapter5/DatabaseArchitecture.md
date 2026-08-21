PigPower SmartFarm Platform
Software Requirements Specification — System Architecture
Section: 5.2 — Database Architecture

Document ID: PSP-ARCH-5.2-DB
Version: 1.0
Status: Draft
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 5 – System Architecture
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

## 1. Purpose of This Document

This document selects the database technology for the PigPower SmartFarm Platform's transactional backend (the "TRANSACTIONAL DATABASE" component in 5.1's architecture diagram), and — because the choice is practically coupled to it, as flagged at the end of 5.1 — makes an initial recommendation on the backend application framework that will pair with it. Section 5.4 will elaborate the backend framework decision in full; this document establishes the pairing so the two choices aren't made in contradiction of each other.

## 2. Evaluation Criteria

Rather than choosing a database based on popularity, the options below are scored against requirements already established in Chapters 4 and 5.1:

| Criterion | Why It Matters | Source |
|---|---|---|
| Cost at pilot scale | M250,000 total pilot budget; must avoid mandatory recurring managed-service fees | AD-SYS-001, DFM §49 |
| Strong transactional integrity | Farmer settlements, finance and inventory cannot tolerate silent data corruption | ACRM (whole module), Farmer Payments module |
| Good support for complex/relational queries | CRM segmentation, BI analytics, compliance reporting all involve multi-table queries | RBIM (whole module) |
| JSON/flexible-field support | Several entities have semi-structured metadata (SACM's LookupValue metadata, notification template variables, AnalyticsSnapshot) | SACM §12, RBIM §59 |
| Mature offline-sync-friendly features | Conflict detection needs reliable timestamps/versioning; batch writes need strong transaction support | OSDS §11–13 |
| Self-hostable without vendor lock-in | Aligns with the "local vs. self-hosted vs. cloud" storage philosophy already applied to files in DFM §49 | DFM §49 |
| Ecosystem maturity for the chosen backend framework | Avoid pairing an obscure database with a framework that has poor support for it | — |
| Suitable for a small/solo development team to operate | No dedicated DBA; must be operable by the same person(s) building the app | AD-SYS-001 |

## 3. Options Considered

### 3.1 PostgreSQL

An open-source, mature, fully-featured relational database.

**Strengths relevant to PigPower:**
- Free and open-source; no licensing cost at any scale.
- Excellent support for complex relational queries — directly benefits RBIM's revenue/profitability/farmer analytics (RBIM §11–16) and CRM's segmentation logic (CRM §10–11).
- Native `JSONB` column type — a clean fit for SACM's `LookupValue.metadata`, NCM's template variables, and RBIM's `AnalyticsSnapshot`/`ForecastResult` entities, without needing a separate NoSQL database alongside the relational one.
- Strong support for window functions and materialized views — useful for the kind of pre-aggregated KPI values RBIM's `KPIResult` entity implies, and for the "reporting database" separation RBIM §57 describes as a *future* option, without forcing that separation on day one.
- Mature row-level locking and transaction isolation — important for the settlement/payment integrity requirements running through Farmer Payments, Finance and ACRM.
- Widely supported by every mainstream backend framework and ORM.
- Can be self-hosted on a low-cost VPS, or run via a low-cost/free-tier managed provider (e.g. Supabase, Neon, Railway) if PigPower later prefers not to operate the database itself — giving a graduated cost path rather than an all-or-nothing choice.

**Weaknesses:**
- Slightly more setup/tuning knowledge required than a fully-managed proprietary option — mitigated by extensive free documentation and the availability of low-cost managed Postgres options if needed.

### 3.2 MySQL / MariaDB

A widely used open-source relational database.

**Strengths:**
- Free, open-source, very widely supported.
- Simpler operational mental model for a smaller team; extremely common in shared/low-cost hosting environments.
- Adequate JSON column support (though historically less mature than PostgreSQL's).

**Weaknesses relevant to PigPower:**
- Weaker support for advanced analytical query patterns (window functions, more complex aggregations) that RBIM's analytics requirements will increasingly need as the platform matures.
- JSON querying and indexing capabilities are less mature than PostgreSQL's `JSONB`.
- No meaningful cost advantage over PostgreSQL at PigPower's scale — both are free and self-hostable — so the deciding factor becomes feature fit, not price.

### 3.3 SQLite (Server-Side)

An embedded, file-based database.

**Strengths:**
- Zero operational overhead, zero cost, already the *correct* choice for the **mobile app's local database** (as already assumed in OSDS §6, FR-OSDS-002).

**Weaknesses relevant to PigPower (as a *server-side* database):**
- Not designed for the concurrent multi-user write load a shared backend serving many field devices, staff and future web-console users will generate.
- Not appropriate for a system requiring role-based access control enforced at the database connection level.

**Verdict:** SQLite remains the correct choice for the Flutter app's local/offline database (confirmed here, not changed), but is **not suitable as the server-side transactional database**.

### 3.4 NoSQL Document Database (e.g. MongoDB) — Considered and Rejected

**Considered because:** some entities (notification templates, KPI definitions, lookup metadata) are semi-structured, which document databases handle natively.

**Rejected because:** the large majority of PigPower's data — farmers, farms, pigs, production batches, orders, payments, settlements, financial transactions — is inherently relational, with strong integrity and multi-entity join requirements (a settlement references a farmer, a collection, a pig batch, and a payment, per the Farmer Payments module's own described chain). A document database would force PigPower to either denormalize this relational data awkwardly or perform application-level joins that a relational database handles natively and efficiently. PostgreSQL's native `JSONB` support already covers the minority of genuinely semi-structured fields, making a second, separate NoSQL database an unnecessary addition to the architecture (violating AD-SYS-001's preference for a small, well-understood stack) rather than a genuine requirement.

## 4. Comparison Summary

| Criterion | PostgreSQL | MySQL/MariaDB | SQLite (server-side) | MongoDB |
|---|---|---|---|---|
| Cost | Free | Free | Free | Free (self-hosted) / paid tiers common |
| Relational integrity | Excellent | Good | Good (single-writer limits) | Weak (by design) |
| Complex analytics/reporting fit | Excellent | Fair | Poor at scale | Fair |
| JSON/flexible fields | Excellent (`JSONB`) | Adequate | Adequate | Excellent (native) |
| Concurrent multi-user writes | Excellent | Good | Poor | Good |
| Self-hosting simplicity | Good | Very good | N/A (not fit for purpose) | Good |
| Ecosystem/framework support | Excellent | Excellent | N/A (server-side) | Good |
| Fit for PigPower's relational data model | **Best fit** | Acceptable | Not applicable (server-side) | Poor fit |

## 5. Decision

### AD-DB-001 — Database Engine Selection

**Decision: PigPower's server-side transactional database shall be PostgreSQL.**

**Rationale:** PostgreSQL is free, self-hostable at low cost, and is the strongest fit for the combination of strict relational integrity (settlements, finance, inventory) and semi-structured flexibility (`JSONB` for configuration metadata, analytics snapshots, forecast results) that Chapter 4's modules require simultaneously. Its analytical query capability directly supports RBIM's reporting ambitions without requiring a second specialized database from day one, and its maturity means any backend framework PigPower chooses in 5.4 will have first-class support for it.

### AD-DB-002 — SQLite Confirmed for the Mobile Client

**Decision: The Flutter application's local/offline database (per OSDS FR-OSDS-002) remains SQLite.** This is unaffected by the server-side database decision above — the two serve entirely different purposes (single-device local cache vs. shared multi-user transactional store) and using SQLite locally alongside PostgreSQL on the server is standard, low-risk practice, not an inconsistency.

## 6. Coupled Decision: Backend Framework Pairing (Preview of 5.4)

Because database and backend framework are practically chosen together in a small-team project, this section previews the recommendation that Section 5.4 will formalize.

### AD-DB-003 — Recommended Framework Pairing (to be confirmed in 5.4)

Two strong, well-supported pairings exist for PostgreSQL. Rather than presenting these as open forever, a working recommendation is made now so subsequent architecture sections have a concrete stack to reference:

| Pairing | Strengths for PigPower | Trade-offs |
|---|---|---|
| **Node.js + NestJS (TypeScript) + Prisma ORM + PostgreSQL** *(recommended)* | TypeScript end-to-end (Flutter/Dart on the client is a separate language regardless, but a JS/TS backend is one of the most common pairings for teams also comfortable with modern web tooling); NestJS's modular structure maps almost one-to-one onto the modular monolith design in AD-SYS-002; Prisma provides strong type safety and straightforward migrations, which reduces the risk of the kind of silent schema drift ACRM is designed to catch; very large hiring/learning-resource pool if PigPower brings on additional developers later. | Requires comfort with the Node.js ecosystem; slightly more initial setup than a "batteries-included" framework like Django. |
| Python + Django + Django REST Framework + PostgreSQL | Django's built-in admin interface could accelerate early SACM/administration console needs; Django REST Framework is mature and well documented; Python has a large talent pool, including in data/analytics work relevant to RBIM's future forecasting ambitions (RBIM §47). | Less naturally modular out of the box than NestJS for the kind of clean module boundaries AD-SYS-002 calls for (achievable, but requires more discipline); async/background job handling (important for OSDS's sync queue and IAPI's webhook processing) is less first-class than in the Node.js ecosystem. |

**Recommendation stated, not yet finalized:** Node.js + NestJS + Prisma + PostgreSQL is the working recommendation carried forward into Section 5.4, primarily because NestJS's module system so closely mirrors the modular-monolith structure already decided in AD-SYS-002, and because Prisma's migration tooling directly supports the schema discipline ACRM's audit/compliance requirements depend on. **This is not irreversible** — if the person(s) building PigPower are substantially stronger in Python than TypeScript, the Django pairing is a fully legitimate alternative and the practical cost of switching is low at this early stage, since no code has been written yet.

## 7. Hosting Approach for the Database

### AD-DB-004 — Self-Hosted vs. Managed PostgreSQL at Pilot Scale

| Option | Approx. Cost Pattern | Verdict for Pilot Phase |
|---|---|---|
| Self-hosted PostgreSQL on a low-cost VPS (e.g. shared with the backend application on the same modest server) | Lowest cost; bundled into general server hosting cost already needed for the backend itself | **Recommended for pilot phase**, consistent with AD-SYS-001 and DFM §49's cost-consciousness principle |
| Managed PostgreSQL free/low-cost tier (e.g. Supabase, Neon, Railway) | Free tier often sufficient at pilot data volumes; removes some operational burden (backups, patching) | Reasonable alternative if the team prefers to trade a small amount of future cost for reduced ops burden during the pilot |
| Managed PostgreSQL enterprise tier (e.g. AWS RDS, Azure Database) | Meaningful recurring monthly cost even at small scale | **Not recommended for pilot phase** — conflicts directly with AD-SYS-001 and the explicit instruction to avoid unnecessary monthly database subscriptions (DFM §49) |

**Decision:** Self-host PostgreSQL alongside the backend application during the pilot phase, on a single modest server, with the option to migrate to a managed provider or a dedicated database server as transaction volume in Stage 2/3 (per 5.1 Section 8's growth path) justifies the additional cost.

## 8. Schema Design Principles

The following principles, drawn directly from Chapter 4's requirements, shall guide the detailed schema design (to be produced as a separate database schema document once each module's entities are finalized):

### FR-DB-001 — One Module, One Schema Namespace

Each Chapter 4 module's entities shall be grouped under a consistent naming convention (e.g. table prefixes or PostgreSQL schemas — `farmer.*`, `production.*`, `finance.*`) so the modular monolith's internal module boundaries (AD-SYS-002) are visible in the database structure itself, not just in application code.

### FR-DB-002 — Soft Deletion by Default

Consistent with BR-CRM-006 ("customer records shall not be physically deleted if they have historical transactions") and DFM §45 ("soft deletion"), the schema shall default to soft-delete (`deleted_at` / `status` fields) for any entity with financial, farmer, or compliance significance, reserving hard deletion for genuinely transient data.

### FR-DB-003 — Audit-Friendly Timestamps

Every table shall include `created_at`, `updated_at`, `created_by` and `updated_by` fields as a baseline, supporting ACRM's platform-wide audit standard (ACRM-FR-001) without each module needing to invent its own convention.

### FR-DB-004 — Idempotency & Sync-Friendly Identifiers

Tables populated via offline sync (per OSDS) shall include fields to support the client-ID-to-server-ID mapping (`OSDS.LocalEntityMapping`) and idempotency key storage described in OSDS §12, rather than relying solely on auto-incrementing primary keys that offline clients cannot predict in advance. UUIDs (or a similar client-generatable identifier scheme) shall be used for entities that may be created offline, so a temporary client-side ID and its eventual server ID can be reconciled cleanly.

### FR-DB-005 — Configuration-Driven Reference Data, Not Hard-Coded Enums

Where Chapter 4 modules describe configurable lists (SACM's generic lookup-table engine, FR-SACM-008), the schema shall represent these as data (rows in a `lookup_value` table) rather than as fixed database-level enum types, preserving SACM's promise that new breeds, feed types, or disease types can be added without a schema migration.

## 9. Backup & Recovery (Database-Specific)

### FR-DB-006 — Automated Backup

The database shall be backed up on an automated schedule (daily, at minimum, for the pilot phase), consistent with the backup strategy referenced generally in DFM §57 and SACM §29, with backups stored separately from the primary database server to protect against single-server failure.

### FR-DB-007 — Backup Restoration Testing

Backup restoration shall be tested periodically (not merely assumed to work), since an untested backup provides false assurance — directly relevant to PigPower's investor/BEDCO due-diligence posture (ACRM §10).

## 10. What This Document Does Not Decide

Deferred to later sections:

```
5.3  File/object storage technology (separate from this database decision)
5.4  Full backend framework decision and detailed module folder structure
5.7  Detailed offline/local SQLite schema on the Flutter side
5.9  Specific hosting provider and server sizing
5.10 Consolidated cost estimate across database + storage + hosting
```

## 11. Summary of Architecture Decisions in This Document

| ID | Decision |
|---|---|
| AD-DB-001 | PostgreSQL selected as the server-side transactional database. |
| AD-DB-002 | SQLite confirmed (unchanged) as the Flutter app's local/offline database. |
| AD-DB-003 | Node.js + NestJS + Prisma + PostgreSQL recommended as the working framework pairing, to be finalized in 5.4. |
| AD-DB-004 | Self-hosted PostgreSQL during the pilot phase, with a defined path to managed hosting as scale justifies it. |

## 12. Recommended GitHub File

Create:

```
docs/SRS/Chapter5/DatabaseArchitecture.md
```

Then commit it:

```
git add docs/SRS/Chapter5/DatabaseArchitecture.md
git commit -m "docs: add database architecture (chapter 5.2)"
git push
```

## 13. Next Section

**5.3 File/Object Storage Architecture** should be next, resolving the "where do the actual PDFs, photos and scanned documents live" question that DFM Chapter 4 deliberately deferred (DFM §66: "we should not decide this by simply choosing whichever database appears cheapest... we will separately evaluate local server storage, self-hosted object storage, S3-compatible storage, cloud storage, hybrid storage"). That section should evaluate those options against the same cost-consciousness and offline-capture requirements (DFM §50–52) already established, and should confirm whether the same low-cost VPS hosting the database and backend can also reasonably host file storage during the pilot phase, or whether a separate object-storage service (even a low-cost one) is warranted from day one given the volume of farmer ID documents, veterinary certificates and photographs the platform will accumulate.
