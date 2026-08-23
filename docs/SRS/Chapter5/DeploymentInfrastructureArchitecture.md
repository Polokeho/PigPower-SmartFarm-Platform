PigPower SmartFarm Platform
Software Requirements Specification — System Architecture
Section: 5.9 — Deployment & Infrastructure Architecture

Document ID: PSP-ARCH-5.9-DEPLOY
Version: 1.0
Status: Draft
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 5 – System Architecture
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

## 1. Purpose

Every prior section in Chapter 5 has assumed a single low-cost server hosting the backend, database and file storage together (`5.1 AD-SYS-001`, `5.2 AD-DB-004`, `5.3 AD-FS-002`). This document makes that concrete: which hosting option, how the server is provisioned, how TLS and secrets actually get applied (closing `5.8`'s FR-SEC-003 and reinforcing FR-SEC-001), how backups run automatically rather than being a manual afterthought, and how the Flutter app reaches real field devices rather than only `flutter run` from a development machine.

This document also directly operationalizes `5.8 §12`'s action list — TLS and secret rotation aren't just security recommendations anymore, they're concrete steps in the deployment process below.

## 2. Hosting Decision

### AD-DEPLOY-001 — Hosting Provider Selection

| Option | Approx. Monthly Cost (smallest viable tier) | Verdict |
|---|---|---|
| **Low-cost VPS** (e.g. Hetzner, DigitalOcean, Vultr, Contabo) | $4-6/month for a 1-2 vCPU, 2-4GB RAM droplet | **Selected** — matches `AD-SYS-001`'s cost-consciousness, full control, no vendor-specific lock-in |
| Managed PaaS (e.g. Railway, Render, Fly.io) | Often free-tier-eligible at pilot scale, ~$5-20/month beyond it | Reasonable alternative if reduced ops burden is worth the (usually modest) extra cost — revisit if self-hosting proves more time-consuming than expected |
| Major cloud (AWS/Azure/GCP full-service) | Meaningfully higher at equivalent specs, plus billing complexity | Rejected for pilot phase — same reasoning as `5.2 AD-DB-004` rejecting managed enterprise database tiers |

**Decision: a single low-cost VPS**, Ubuntu 24.04 LTS (matching the OS already used throughout this session's local development, minimizing surprises), sized at minimum 2 vCPU / 4GB RAM / 40GB SSD — comfortably enough for PostgreSQL, the FastAPI backend, and local file storage at pilot-phase volume, per the Stage 1 sizing implied in `5.1 §8`.

## 3. Server Provisioning (One-Time Setup)

### FR-DEPLOY-001 — Baseline Server Hardening

Before deploying application code, the server itself should have:

```
- SSH key-based login only (password login disabled)
- A non-root deploy user (never run the application as root)
- ufw (or equivalent) firewall: allow only 22 (SSH), 80, 443
- Automatic security updates enabled (unattended-upgrades on Ubuntu)
- Fail2ban or equivalent for SSH brute-force protection —
  the server-level analogue of 5.8 FR-SEC-005's API-level login
  rate limiting
```

### 3.1 Software to Install

```
- PostgreSQL 16 (matching 5.2 AD-DB-001, and the exact version
  already proven working in this session's local setup)
- Python 3.12 + venv (matching the local development environment)
- Nginx (reverse proxy + TLS termination, §4)
- Certbot (free TLS certificates via Let's Encrypt, §4)
- Git (to pull the application code)
```

## 4. TLS — Closing FR-SEC-003

### AD-DEPLOY-002 — TLS Termination via Reverse Proxy, Not in the Application

**Decision: Nginx sits in front of the FastAPI/uvicorn process and handles TLS termination; uvicorn itself continues serving plain HTTP, but only on `localhost`, never directly exposed to the internet.**

```
                    INTERNET
                       │
                       ▼
              Nginx (port 443, HTTPS)
                       │
              (TLS terminated here)
                       │
                       ▼
         uvicorn (port 8000, HTTP,
         bound to 127.0.0.1 only —
         not reachable from outside
         the server itself)
```

**Rationale:** this is the standard, well-understood pattern for Python ASGI applications — it keeps TLS certificate management (renewal, cipher configuration) out of the application code entirely, consistent with `5.4`'s principle of not over-complicating the application layer with infrastructure concerns. Nginx also gives a natural place to add response compression, static file serving for the future Admin Web Console (`5.1 §5.2`), and request logging independent of the application.

### FR-DEPLOY-002 — Automatic Certificate Renewal

TLS certificates via Certbot/Let's Encrypt (free) must be configured with automatic renewal (`certbot renew` via cron/systemd timer, which Certbot sets up by default on most distributions) — a certificate that silently expires is a self-inflicted outage.

## 5. Application Deployment Process

### FR-DEPLOY-003 — Deployment Steps (Manual, Pilot-Appropriate)

Given the solo/small-team context established throughout this SRS, a full CI/CD pipeline is not justified at pilot scale (echoing `5.1 AD-SYS-004`'s "don't add infrastructure complexity before volume justifies it" reasoning applied here to deployment automation instead of message brokers). The deployment process is a short, repeatable manual sequence:

```
1. SSH into the server as the deploy user
2. cd /opt/pigpower/backend
3. git pull origin main          (deploying from `main`, not `develop` —
                                   per the branching discussion earlier
                                   in this project, `main` is what's
                                   actually running in production)
4. source venv/bin/activate
5. pip install -r requirements.txt
6. alembic upgrade head          (applies any new migrations —
                                   the exact command already proven
                                   working in local setup)
7. sudo systemctl restart pigpower-backend   (see §5.1 below)
```

### 5.1 Process Management via systemd

### FR-DEPLOY-004 — The Backend Runs as a systemd Service, Not a Manually-Started Terminal Process

Running `uvicorn app.main:app` directly in a terminal (as done throughout local development this session) is appropriate for development but not for a server that needs to survive reboots, crashes, and SSH disconnects. A systemd unit file:

```ini
[Unit]
Description=PigPower Backend
After=network.target postgresql.service

[Service]
User=pigpower
WorkingDirectory=/opt/pigpower/backend
Environment="PATH=/opt/pigpower/backend/venv/bin"
ExecStart=/opt/pigpower/backend/venv/bin/uvicorn app.main:app --host 127.0.0.1 --port 8000
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

This gives automatic restart on crash, starts on server boot, and standard `systemctl status pigpower-backend` / `journalctl -u pigpower-backend` for status and logs — the production equivalent of the `uvicorn --reload` terminal window used throughout this session's local testing.

## 6. Environment Separation

### FR-DEPLOY-005 — Staging Environment

Per `5.1 FR-SYS-001`, a staging environment should exist before production traffic matters — practically, this can be the **same VPS**, at pilot scale, running a second systemd service (`pigpower-backend-staging`) on a different port, with its own PostgreSQL database (`pigpower_staging`) and its own `.env` (with its own, separately-rotated secrets, per `5.8 FR-SEC-001`). A second, separate server is a reasonable upgrade once staging/production resource contention becomes a real problem, not before.

## 7. Backup Automation

### FR-DEPLOY-006 — Automated Daily Backups, Executing What 5.2/5.3 Already Specified

`5.2 FR-DB-006` and `5.3 FR-FS-005` already specified *that* backups must happen; this section specifies *how*, concretely:

```bash
#!/bin/bash
# /opt/pigpower/scripts/backup.sh — run daily via cron
DATE=$(date +%Y%m%d)
pg_dump -U pigpower pigpower | gzip > /opt/pigpower/backups/db_$DATE.sql.gz
tar czf /opt/pigpower/backups/storage_$DATE.tar.gz /opt/pigpower/backend/storage-data
# Off-site copy — per 5.3 AD-FS-002's hybrid local+cloud-backup decision
rclone copy /opt/pigpower/backups/ remote:pigpower-backups/ --max-age 25h
# Prune local backups older than 14 days
find /opt/pigpower/backups/ -mtime +14 -delete
```

```
0 2 * * *  /opt/pigpower/scripts/backup.sh    # crontab entry, runs daily at 02:00
```

### FR-DEPLOY-007 — Backup Restoration Must Be Tested, Not Assumed

Per `5.2 FR-DB-007`/`5.3 FR-FS-006`, a quarterly calendar reminder (even something as simple as a recurring note) to actually restore the latest backup to a throwaway database and confirm it works is the cheapest possible insurance against discovering a broken backup process only when it's needed.

## 8. Monitoring & Observability (Pilot-Appropriate)

### FR-DEPLOY-008 — Minimum Viable Monitoring

Full observability tooling (Prometheus/Grafana, structured log aggregation) is not justified at pilot scale. The minimum viable version:

```
- systemd/journalctl for application logs (already structured as
  JSON where the AuditListener writes them, per 5.4/backend code)
- A simple uptime check (e.g. UptimeRobot's free tier, or a cron
  job hitting GET /health — already implemented and verified in
  this session's backend — and alerting via email/SMS on failure)
- Disk space alerting (a cron job checking `df` output against a
  threshold, given the local-storage-first design in 5.3 means
  disk usage is a real, monitorable growth-trigger signal per
  5.3 AD-FS-003)
```

This directly ties back to `5.3 AD-FS-003`'s migration trigger ("Local disk usage exceeds a configured threshold") — that trigger needs *something* actually watching disk usage to be meaningful, and this is the minimum viable version of that.

## 9. Mobile App Distribution

### 9.1 Windows Desktop Distribution

The app has so far only been run via `flutter run -d windows` from a development machine. For distribution to a real user (even just a second test device):

```
flutter build windows --release --dart-define=API_BASE_URL=https://api.pigpower.example
```

This produces a `build/windows/x64/runner/Release/` folder containing the `.exe` and required DLLs, which can be zipped and shared directly — no installer or app-store process required for internal/pilot distribution. A proper installer (via tools like Inno Setup) is worth building once distribution moves beyond a handful of known pilot users.

### 9.2 Android Distribution (the Actual Target Platform for Field Officers)

Per `5.6`'s entire design premise — rural field officers on phones, not desktop users — Android is the platform that actually matters for the real PigPower use case, and hasn't been tested at all yet in this session (Windows was used for development convenience, per the earlier decision in this conversation). Building for it:

```
flutter build apk --release --dart-define=API_BASE_URL=https://api.pigpower.example
```

Produces an installable `.apk` that can be sideloaded directly onto pilot devices (via USB, or shared as a direct download link) without needing a Google Play Store listing — appropriate for a controlled pilot with known field officers, deferring Play Store publication (with its review process and signing-key management overhead) until the platform is ready for wider, unsupervised distribution.

### FR-DEPLOY-009 — API Base URL Must Point at the Deployed Backend, Not Localhost

Every build shared with an actual field officer must use `--dart-define=API_BASE_URL=https://<real-domain>`, not `http://localhost:8000` or the Android-emulator-specific `10.0.2.2` address used during this session's local development — both are meaningless off a development machine.

## 10. Domain & DNS

### FR-DEPLOY-010 — A Real Domain Is Required Before Production Use

A domain (even a low-cost one, e.g. via Namecheap/Cloudflare Registrar) pointed at the VPS's IP address is required for TLS (`§4`) to work meaningfully — Let's Encrypt certificates are issued per-domain, not per-IP. This is a small, one-time cost (~$10-15/year for most TLDs) that should be budgeted alongside the VPS hosting cost in any future cost model (`5.10`).

## 11. Scaling Path — Tying Back to 5.1 §8

This document's Stage 1 sizing (§2) directly implements `5.1 §8`'s three-stage growth path:

```
STAGE 1 (this document) — single VPS, everything co-located,
   manual deployment, cron-based backups. Appropriate through
   roughly the pilot's Year 1 scale (per the BEDCO proposal:
   ~30 farmers, ~10 staff users).

STAGE 2 — vertically scale the same VPS (more CPU/RAM) if
   monitoring (§8) shows sustained resource pressure; consider
   a managed PostgreSQL read-replica per 5.2's original growth-
   path note if reporting/BI query load becomes a measurable
   problem, not preemptively.

STAGE 3 — this is the point at which splitting the modular
   monolith (5.1 AD-SYS-002) into separately-deployed services
   becomes worth revisiting, and where a second server for
   staging (5.6) becomes worth the added cost rather than
   sharing a VPS with production.
```

## 12. What This Document Does Not Cover

```
5.10 Cost Model (which will consolidate this document's VPS/domain
     costs with the database/storage costs already estimated in
     5.2/5.3 into a single running total)
```

## 13. Recommended GitHub File

Create:

```
docs/SRS/Chapter5/DeploymentInfrastructureArchitecture.md
```

Then commit it:

```
git add docs/SRS/Chapter5/DeploymentInfrastructureArchitecture.md
git commit -m "docs: add deployment and infrastructure architecture (chapter 5.9)"
git push origin develop
```

## 14. Next Section

**5.10 Cost Model** closes out Chapter 5 — consolidating the VPS (§2), domain (§10), and any future managed-service costs this document identified, alongside the earlier database/storage cost reasoning from `5.2`/`5.3`, into a single running estimate. That document should also explicitly reconcile against the M250,000 BEDCO pilot budget referenced throughout this project's earlier business-proposal work, so the technical architecture and the funding ask are demonstrably consistent with each other — not two documents that happen to have been written separately.

Given this document is the first one in Chapter 5 to describe infrastructure that doesn't exist yet (no VPS has actually been provisioned this session, unlike the database/backend/mobile work which was built and verified live), it may be worth treating **actually provisioning a small VPS and walking through §3-5 hands-on** as the next concrete step — the same "build it, don't just design it" approach that made `5.1`-`5.8` far more valuable than they would have been as pure planning documents.
