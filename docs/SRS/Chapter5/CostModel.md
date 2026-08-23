PigPower SmartFarm Platform
Software Requirements Specification — System Architecture
Section: 5.10 — Cost Model

Document ID: PSP-ARCH-5.10-COST
Version: 1.0
Status: Draft
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 5 – System Architecture
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

## 1. Purpose

This document closes Chapter 5 by consolidating every infrastructure cost decided across `5.1`-`5.9` into a single running estimate, and — critically — reconciling that estimate against the **M250,000 BEDCO pilot budget** established in the project's business proposal (specifically the "Technology platform (lightweight MVP)" line item of M12,000, and the broader pilot cost structure). A technical architecture that quietly costs more than the funding ask allows for is a planning failure, not a detail to discover later — this document exists to catch that now, while it's cheap to fix.

## 2. Cost Items, by Origin Document

| Item | Decided In | Approx. Monthly Cost | Approx. Annual Cost |
|---|---|---|---|
| VPS (2 vCPU / 4GB / 40GB) | `5.9 AD-DEPLOY-001` | $5-6 | $60-72 |
| Domain name | `5.9 FR-DEPLOY-010` | — | $10-15 (one-time/year) |
| TLS certificate (Let's Encrypt) | `5.9 §4` | $0 | $0 |
| PostgreSQL (self-hosted on the VPS) | `5.2 AD-DB-004` | $0 (bundled in VPS) | $0 |
| Local file storage (self-hosted on the VPS) | `5.3 AD-FS-002` | $0 (bundled in VPS) | $0 |
| Off-site backup storage (Backblaze B2 / Cloudflare R2) | `5.3 AD-FS-002`, `5.9 §7` | ~$0.50-2 at pilot data volume | ~$6-24 |
| Firebase Cloud Messaging (push transport) | `5.6 AD-MOB-006` | $0 | $0 |
| SMS provider (referenced in NCM, not yet integrated) | Chapter 4 NCM | Not yet incurred | Not yet incurred |
| Uptime monitoring (free tier) | `5.9 §8` | $0 | $0 |
| **Total infrastructure, Year 1 pilot scale** | | **~$6-9/month** | **~$76-111/year** |

At approximately M0.055/USD-equivalent exchange context aside (this figure should be checked against the actual rate at time of budgeting, since it will drift), this is a genuinely small number — **roughly M1,400-2,000 for a full year of infrastructure**, not the dominant cost in the pilot budget by any measure.

## 3. Reconciliation Against the M250,000 BEDCO Budget

### 3.1 What the business proposal already allocated

The BEDCO proposal's use-of-funds table allocated **M12,000 (4.8% of the M250,000 pilot grant)** to "Agri-tech platform MVP (app, dashboard, QR traceability)."

### 3.2 Does the actual architecture fit inside that allocation?

**Yes, comfortably — with a caveat worth stating precisely rather than glossing over.**

```
M12,000 technology allocation
   -  ~M1,500-2,000  Year 1 infrastructure (§2 above)
   ────────────────────────────────────────
   =  ~M10,000-10,500  remaining for development time,
      QR/traceability feature work, and buffer
```

**The caveat:** this M12,000 figure was written into the BEDCO proposal as a budget line *before* any of the SRS's architecture decisions existed — it was a reasonable planning estimate, not derived from this document's bottom-up analysis. The reconciliation above shows the *infrastructure* portion fits easily; it does not, by itself, prove that M10,000 is sufficient for the *development labour* implied by 26 Chapter 4 modules, even at Pass-1 scope. That's a separate question from this document's, addressed in §5.

### AD-COST-001 — The Architecture Was Correctly Scoped to the Budget, Not the Other Way Around

This is worth stating as a deliberate decision, not a coincidence: every cost-sensitive decision throughout Chapter 5 (`5.2`'s self-hosted PostgreSQL over managed tiers, `5.3`'s local-storage-first approach, `5.9`'s low-cost VPS over managed PaaS, `5.6`'s FCM-as-transport-only rather than a full Firebase backend) was made *because* of the M250,000 constraint established back in the BEDCO proposal, carried forward as `AD-SYS-001` in `5.1`. The near-zero infrastructure cost shown in §2 is the result of that discipline, not luck.

## 4. What Happens at Growth Stage (Stage 2/3, per 5.1 §8 / 5.9 §11)

The BEDCO proposal's own financial model (Section 12.3 of that document) already anticipates a **Year 2/3 growth-capital raise of M8-15 million** to fund the national processing facility. The technical infrastructure cost at that scale should be estimated *before* that raise, not after, so it can be included in the ask rather than discovered as a surprise mid-Year-2:

```
STAGE 2/3 indicative infrastructure costs (NOT precise —
directional only, to be refined when Stage 2 is actually approached):

  Vertically-scaled VPS or managed Postgres           $20-50/month
  Object storage (MinIO or commercial), higher volume $5-20/month
  Staging environment (second small VPS)              $5-6/month
  Possible SMS provider costs (per-message, volume-
    dependent — NCM Chapter 4 flagged this but it has
    no cost data yet since no provider is integrated)   Unknown — flag for
                                                          Pass 2 backend work
  ─────────────────────────────────────────────────────────────────
  Indicative total                                     $30-75+/month
```

This remains small relative to a multi-million-Maloti growth raise, but it should be an explicit line item in that raise's use-of-funds, not assumed to be free because Stage 1 was.

## 5. What This Document Does NOT Estimate (Scope Boundary)

This is a **technical infrastructure cost model**, not a project cost model. It deliberately excludes:

```
- Development time/labour (yours, or any future hires) —
  this is a business-planning question, not an architecture one
- The M12,000 line item's other components (dashboard/QR
  traceability feature work specifically)
- Non-technology pilot costs already covered in the BEDCO
  proposal (piglets, feed, veterinary, training, etc.)
```

Conflating infrastructure hosting cost with total technology cost would understate the real effort involved in this project — the architecture decisions in Chapter 5 made *hosting* cheap; they did not make *building* free, and this document should not be read as claiming otherwise.

## 6. Cost Monitoring Going Forward

### FR-COST-001 — Track Actual vs. Estimated Infrastructure Spend

Once the VPS from `5.9` is actually provisioned, actual monthly spend should be checked against this document's §2 estimate at least once per quarter during the pilot — cheap to do, and it's the only way to catch cost drift (e.g. off-site backup storage growing faster than expected as document/photo volume increases, per the very trigger `5.3 AD-FS-003` describes) before it becomes a budget problem rather than a line-item adjustment.

## 7. Chapter 5 Complete

With this document, **Chapter 5: System Architecture** is now complete:

```
5.1  Overall System Architecture
5.2  Database Architecture
5.3  File/Object Storage Architecture
5.4  Backend Application Architecture
5.5  API Architecture (Pass 1)
5.6  Flutter Mobile Application Architecture
5.7  Offline Data Architecture
5.8  Security Architecture
5.9  Deployment & Infrastructure Architecture
5.10 Cost Model                              ← this document
```

Unusually for an SRS, a meaningful portion of this chapter (5.2 through 5.8) was written *against real, working, verified code* rather than purely ahead of it — the backend and mobile app were built, ran, and were tested on real PostgreSQL, real HTTP traffic, and real Android hardware over the course of this project. That's a stronger foundation than most architecture documentation gets to claim.

## 8. Recommended GitHub File

Create:

```
docs/SRS/Chapter5/CostModel.md
```

Then commit it:

```
git add docs/SRS/Chapter5/CostModel.md
git commit -m "docs: add cost model (chapter 5.10) — closes Chapter 5"
```

## 9. Next Steps

With Chapter 5 closed, the SRS's natural next phase is **Chapter 6: Non-Functional Requirements Consolidation and Traceability** (pulling together the non-functional requirements scattered across every Chapter 4/5 document into one master list, with each traced back to its origin) — or, given how much of this project has been "build it, then document it" rather than the reverse, it may be equally valuable to treat the **actual pilot deployment** (provisioning the VPS from `5.9`, migrating the verified local setup onto it, and running the exact same Android test against a real deployed backend instead of `localhost`) as the next milestone, with Chapter 6 following once there's a live system to document rather than only a local one.
