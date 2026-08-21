PigPower SmartFarm Platform
Software Requirements Specification — System Architecture
Section: 5.3 — File / Object Storage Architecture

Document ID: PSP-ARCH-5.3-STORE
Version: 1.0
Status: Draft
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 5 – System Architecture
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

## 1. Purpose of This Document

Document & File Management (Chapter 4, DFM) deliberately deferred the question of where actual files physically live, stating in DFM §48–49 that files should be stored separately from the relational database, kept behind a storage interface abstraction, and decided "after we compare the available options" (DFM §66). This document makes that decision.

It resolves the "FILE / OBJECT STORAGE" component introduced in 5.1's architecture diagram, and defines how it satisfies DFM's requirements for farmer ID documents, veterinary certificates, invoices, photographs, and the grant/investor data room, as well as OSDS's offline media-capture requirements.

## 2. Evaluation Criteria

| Criterion | Why It Matters | Source |
|---|---|---|
| Low, predictable cost at pilot scale | M250,000 budget; avoid mandatory recurring subscriptions | AD-SYS-001, DFM §49 |
| Durability / low risk of data loss | Farmer ID documents, signed agreements, veterinary certificates are not easily replaceable | DFM §2, §57 |
| Support for offline capture and delayed upload | Field devices capture photos/documents with no connectivity, per OSDS | DFM §50–52, OSDS FR-OSDS-008 |
| Support for time-limited, secure access | Confidential documents must not be exposed via permanent public URLs | DFM §37, §41–43 |
| Provider-swappable via abstraction | The architecture should never be locked into one storage vendor | DFM §49, IAPI §9 |
| Straightforward to operate for a small team | No dedicated infrastructure engineer | AD-SYS-001 |
| Room to grow to national scale without redesign | 500+ farmers' worth of documents, photos, processing/compliance records | DFM §62, ACRM §9 |

## 3. Options Considered

### 3.1 Local Filesystem Storage (on the same server as the backend)

Files stored directly on the backend server's disk, referenced by path in the database.

**Strengths:**
- Zero additional cost — uses disk space already included with the server hosting the backend and database (per AD-DB-004's self-hosting decision).
- Simplest possible implementation; no external account, API keys, or network dependency for file access.
- Fully consistent with the cost-conscious, self-hosted pilot-phase approach already adopted for the database.

**Weaknesses:**
- Single point of failure — if the server is lost, files are lost unless independently backed up.
- Harder to scale horizontally later (if the backend ever runs on multiple servers, a shared file store becomes necessary).
- No built-in geographic redundancy.

### 3.2 Self-Hosted Object Storage (e.g. MinIO)

An open-source, S3-API-compatible object storage server, self-hosted on the same or a separate VPS.

**Strengths:**
- S3-compatible API — the same client code works whether talking to a self-hosted MinIO instance or a commercial S3-compatible cloud provider, directly supporting DFM §49's "Local / S3 / Other" abstraction goal.
- Free and open-source; no per-GB fees.
- Provides object-storage semantics (versioning, presigned URLs) natively, which DFM explicitly wants (§37, "temporary file access... time-limited URLs").

**Weaknesses:**
- Additional service to operate, monitor and back up, beyond the database server — meaningfully more operational complexity than local filesystem storage for a small team at pilot scale.
- Still subject to the same single-server data-loss risk as local storage unless separately backed up or run in a redundant configuration (which itself adds cost/complexity).

### 3.3 Commercial Cloud Object Storage (S3-compatible)

Includes AWS S3, Backblaze B2, Cloudflare R2, DigitalOcean Spaces.

**Strengths:**
- Durable by design (typically 99.999999999%-class durability claims), removing the single-server data-loss risk entirely.
- Presigned/temporary URL support built in, satisfying DFM §37 natively.
- Some options are genuinely low-cost at small scale: Backblaze B2 and Cloudflare R2 in particular have inexpensive storage tiers and, in R2's case, no egress (download) fees — an important detail since AWS S3's egress pricing can be a hidden cost driver as document/photo volume grows.
- No infrastructure to operate — reduces the burden on a small team.

**Weaknesses:**
- Recurring cost, even if small — a departure from the zero-additional-cost profile of local storage, though the cost at pilot-phase document volumes is expected to be modest (a few dollars per month at most).
- Introduces an external vendor dependency, though this is exactly what the storage abstraction layer (Section 4 below) is designed to make painless to change later.

### 3.4 Hybrid Approach

Local (or self-hosted) storage as the primary, active store, with automated off-site replication to a low-cost cloud object storage tier purely as a backup target.

**Strengths:**
- Combines local storage's zero marginal cost for active use with cloud storage's durability, used only for backup — typically the cheapest tier of pricing since backup storage is written once and rarely read.
- Directly satisfies DFM §57's requirement that document storage be included in the backup strategy, without paying full commercial object-storage pricing for all active traffic.

**Weaknesses:**
- Slightly more setup than either pure option (a scheduled replication job must be configured and monitored).

## 4. Comparison Summary

| Criterion | Local Only | Self-Hosted MinIO | Commercial Cloud (S3-compatible) | Hybrid (Local + Cloud Backup) |
|---|---|---|---|---|
| Marginal cost | None | None (hosting only) | Small recurring fee | Small recurring fee (backup tier only) |
| Durability | Weak (single server) | Weak unless redundant | Strong | Strong (backup copy is durable) |
| Operational complexity | Lowest | Higher | Lowest | Low-moderate |
| Presigned/temporary URL support | Must be built manually | Native | Native | Native (on primary, whichever is chosen) |
| Vendor lock-in risk | None | None | Low (if abstracted) | None |
| Fit for pilot-phase cost constraint | Excellent | Good | Good | **Best overall fit** |

## 5. Decision

### AD-FS-001 — Storage Abstraction Layer (Non-Negotiable, Regardless of Backend Chosen)

**Decision: All file access — upload, download, delete — shall go through a single internal Storage Service interface, never accessed directly by other backend modules.**

```
Document/Module Code
         │
         ▼
  Storage Service Interface     ← stable contract, per DFM §49 / IAPI §9
         │
   ┌─────┼─────┐
   ▼     ▼     ▼
 Local  MinIO  S3-Compatible
 Driver Driver  Cloud Driver
```

This is the architectural decision that matters most in this document: **whichever specific storage backend is chosen below can be changed later by swapping the driver behind this interface, without touching DFM's module code.** This directly implements the abstraction DFM §49 called for and mirrors the provider-abstraction pattern already established for SMS/email in NCM §51 and IAPI §9.

### AD-FS-002 — Pilot-Phase Storage Backend

**Decision: PigPower shall use local filesystem storage on the backend server as the active storage backend during the pilot phase, combined with automated off-site backup replication to a low-cost commercial object storage tier (Backblaze B2 or Cloudflare R2, final choice made at implementation time based on then-current pricing).**

**Rationale:** This is the Hybrid approach from Section 3.4, selected because it gives PigPower the zero-marginal-cost profile of local storage for day-to-day operation (fully consistent with AD-SYS-001 and AD-DB-004's self-hosting decision) while eliminating the single-point-of-failure risk through inexpensive off-site backup — satisfying DFM §57's backup requirement without committing to full commercial object-storage pricing for all active file traffic during the low-volume pilot phase.

### AD-FS-003 — Growth Path to Full Cloud/Self-Hosted Object Storage

**Decision: As document and photo volume grows toward national scale (per 5.1 Section 8's Stage 2/3 growth path), PigPower shall migrate the active storage backend from local filesystem to either self-hosted MinIO or commercial cloud object storage, triggered by measurable thresholds rather than a fixed date.**

Suggested migration triggers (to be confirmed against actual usage once the pilot is running):

```
Migrate when ANY of the following occurs:
   - Local disk usage exceeds a configured threshold
     (e.g. 70% of available server storage)
   - Backend needs to run on more than one server
     (local filesystem storage does not work across multiple servers)
   - Document/photo volume growth rate suggests the local-disk
     threshold will be reached within the next quarter
```

Because AD-FS-001's abstraction layer is in place from day one, this migration is a configuration and data-migration exercise, not an application rewrite.

### AD-FS-004 — Temporary/Presigned Access URLs

**Decision: All document downloads shall be served via time-limited, backend-authorized access URLs, never permanent public file paths — for both the local-storage driver and any future object-storage driver.**

For the local-storage driver specifically, this means the backend generates a short-lived signed token (verified on each download request) rather than exposing a raw, guessable file path — replicating the security property DFM §37 and §41–43 require, even though local filesystem storage has no native presigned-URL feature the way S3-compatible storage does.

```
User requests document
         │
         ▼
Backend checks authorization (SACM roles + DFM confidentiality level)
         │
         ▼
Backend issues short-lived signed URL/token (e.g. 5–15 minute expiry)
         │
         ▼
Client downloads file using that token
         │
         ▼
Token expires — cannot be reused or shared beyond its window
```

## 6. File Organization

### FR-FS-001 — Storage Path/Key Convention

Files shall be stored using a structured, predictable key convention that mirrors DFM's entity-association model (DFM §17), for example:

```
{category}/{entity_type}/{entity_id}/{document_id}_{filename}

Example:
farmer/FMR-000246/document/DOC-0091_FarmerAgreement_v2.pdf
veterinary/PIG-004821/document/DOC-0142_VaccinationRecord.jpg
```

This convention shall be identical regardless of which storage driver (local, MinIO, cloud) is active, since it lives in the Storage Service interface layer, not in any individual driver.

### FR-FS-002 — Metadata Remains in the Database

Consistent with DFM §47–48, the storage layer holds only the file bytes; all searchable metadata (document type, category, expiry date, confidentiality level, related entity) remains in PostgreSQL, queried using the relational capabilities selected in 5.2 — the storage layer is never queried directly for "which documents belong to Farmer X."

## 7. Offline Capture Integration

### FR-FS-003 — Deferred Upload Compatibility

The storage architecture shall be compatible with OSDS's offline media capture and outbox pattern (OSDS §7–8, FR-OSDS-008/009): files captured offline are queued locally on the device and uploaded to the active storage backend only once connectivity and the outbox processing described in OSDS make the upload possible — the storage layer itself has no special "offline mode," since offline handling is entirely a mobile-app-side (OSDS) concern, not a storage-backend concern.

### FR-FS-004 — Upload Size and Compression Alignment

The storage backend's accepted file size limits shall match the configurable limits already defined in SACM §22 (`max_upload_file_size_mb`) and shall assume the client-side image compression already required in DFM §55, keeping typical uploads small and inexpensive to store and back up.

## 8. Backup & Disaster Recovery (Storage-Specific)

### FR-FS-005 — Automated Off-Site Replication

Consistent with AD-FS-002, an automated job shall replicate new/changed files from local storage to the chosen off-site backup target on a regular schedule (daily, at minimum), separate from — but coordinated with — the database backup schedule defined in FR-DB-006, so that a database backup and its corresponding file backup can be restored together as a consistent set.

### FR-FS-006 — Restore Testing

Per the same principle as FR-DB-007, file storage restoration shall be periodically tested, not merely assumed to work.

## 9. Security

### FR-FS-007 — Access Control Enforcement at the Storage Service Layer

The Storage Service interface (AD-FS-001) shall enforce DFM's confidentiality-level and role-based access rules (DFM §41–43) centrally, so that no individual module can bypass access control by, for example, constructing its own file path — reinforcing BR-SYS-001's principle that all access flows through defined layers, not direct component access.

### FR-FS-008 — Encryption at Rest

Where the hosting environment supports it at reasonable cost, stored files (particularly farmer ID documents, HR documents, and financial records) shall be encrypted at rest, consistent with the general security posture expected across the platform (IAPI §18 non-functional requirements).

## 10. What This Document Does Not Decide

Deferred to later sections:

```
5.4  Full backend framework decision (references this storage interface)
5.9  Specific hosting provider selection and server sizing, including
     final choice between Backblaze B2 and Cloudflare R2 for backup
5.10 Consolidated cost estimate across database + storage + hosting
```

## 11. Summary of Architecture Decisions in This Document

| ID | Decision |
|---|---|
| AD-FS-001 | All file access goes through a single internal Storage Service interface, never accessed directly. |
| AD-FS-002 | Pilot phase uses local filesystem storage as primary, with automated off-site backup to low-cost cloud object storage. |
| AD-FS-003 | Migration to full self-hosted or commercial object storage is triggered by measurable usage thresholds, not a fixed date. |
| AD-FS-004 | All downloads use time-limited, backend-authorized access URLs — never permanent public paths. |

## 12. Recommended GitHub File

Create:

```
docs/SRS/Chapter5/FileObjectStorageArchitecture.md
```

Then commit it:

```
git add docs/SRS/Chapter5/FileObjectStorageArchitecture.md
git commit -m "docs: add file and object storage architecture (chapter 5.3)"
git push
```

## 13. Next Section

**5.4 Backend Application Architecture** should be next. This is where the framework pairing previewed in 5.2 (`AD-DB-003`: Node.js + NestJS + Prisma + PostgreSQL) gets finalized and elaborated into an actual module folder structure, confirming how the 26 Chapter 4 modules map onto NestJS's module system (per AD-SYS-002's modular monolith decision), how the Storage Service interface from this document and the provider abstraction layer from IAPI are implemented as shared NestJS modules, and how the in-process event mechanism from AD-SYS-004 is realized in code (e.g. NestJS's built-in `EventEmitter` module, which maps almost directly onto the event-driven pattern already assumed throughout Chapter 4).
