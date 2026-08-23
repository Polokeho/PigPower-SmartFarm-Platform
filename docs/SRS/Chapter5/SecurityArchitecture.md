PigPower SmartFarm Platform
Software Requirements Specification — System Architecture
Section: 5.8 — Security Architecture

Document ID: PSP-ARCH-5.8-SEC
Version: 1.0
Status: Draft — grounded in verified implementation, with known gaps flagged explicitly
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 5 – System Architecture
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

## 1. Purpose and Approach

Like `5.7`, this document is written against real, running code rather than a clean-slate plan — the backend and mobile app already implement a meaningful security baseline (JWT auth, password hashing, secure token storage, signed document URLs). This document formalizes what's actually there, and — just as importantly — is explicit about what is **not** yet production-safe, since a security document that only describes the good parts is more dangerous than no document at all.

Every gap identified below is real, found by reviewing the actual codebase, not hypothetical.

## 2. Security Domains Covered

```
1. Authentication & session security
2. Authorization (permission/scope enforcement)
3. Secrets management
4. Data in transit
5. Data at rest — server side
6. Data at rest — mobile/device side
7. Input validation & injection protection
8. API abuse protection
9. Dependency/supply-chain hygiene
10. Known gaps requiring action before any real deployment
```

## 3. Authentication & Session Security

### 3.1 What's implemented and verified

- Passwords are hashed with **bcrypt** via `passlib` (backend `app/auth/security.py`) — never stored or compared in plaintext. Verified working in the login flow tested this session.
- Access tokens are short-lived **JWTs** (default 30 minutes, `JWT_ACCESS_EXPIRES_MINUTES`), refresh tokens are longer-lived (30 days) opaque random strings, stored server-side only as a **SHA-256 hash** (`RefreshToken.token_hash`) — the raw refresh token is never persisted, only its hash, so a database leak alone doesn't expose usable refresh tokens.
- Refresh tokens **rotate** on use (`AuthService.refresh()` revokes the used token and issues a new one) — a stolen-but-unused refresh token that gets replayed after the legitimate client has already refreshed will fail, a standard defence against refresh-token replay.
- Every authenticated request re-loads the user's **current** roles/permissions/device-revocation status from the database (`get_current_user` dependency) rather than trusting stale claims baked into the JWT — confirmed by design in `5.4`/`5.6`, meaning a revoked device or changed role takes effect on the *next* request, not only after token expiry.

### AD-SEC-001 — Access Token Lifetime

**Decision: 30-minute access token lifetime is retained as the default**, balancing security (short exposure window if a token is intercepted) against UX (infrequent silent refreshes via the mobile app's `dio` interceptor, already implemented in `5.6 AD-MOB-003`). No change needed; documented here for traceability.

## 4. Authorization

### 4.1 What's implemented and verified

- Every protected route declares its required permission explicitly (`Depends(require_permission("farmer.create"))`), and the check is centralized in one function, not scattered per-service — matching `5.4 FR-BE-005`'s design intent even though the concrete mechanism (FastAPI dependency vs. NestJS guard) differs, as already documented in the backend README.
- District-level scope enforcement (`FarmerService._assert_in_scope`) returns `404 NOT_FOUND` rather than `403 FORBIDDEN` for out-of-scope records — a deliberate choice (documented in the code comment) to avoid confirming a record's *existence* to a user who isn't allowed to see it, a minor but real information-disclosure defence.

### 4.2 Known gap: no automated test of scope enforcement

The scope-check logic exists and was written carefully, but **has not been exercised end-to-end** in this session — every login/farmer test so far used `field.officer.berea`, whose scope (`BEREA`) matched every farmer created. A concrete, cheap test worth doing before trusting this in production:

```
Test not yet performed:
  1. Log in as field.officer.berea (scope: BEREA)
  2. Attempt GET /v1/farmers/{id} for a farmer known to be
     in Maseru (created by, e.g., the admin user)
  3. Confirm: 404, not the farmer's data
```

## 5. Secrets Management

### 5.1 What's implemented correctly

- Both `.env` files (backend, and the equivalent environment-variable pattern on mobile via `--dart-define`) are excluded from the actual delivered code and explicitly flagged as **not to be committed** in every README written this session.
- Provider credentials (SMS, storage signing secret) are read from environment configuration, never hard-coded in application logic — consistent with `IAPI FR-IAPI-020`/`5.4 FR-BE-017`.

### 5.2 Known gap: default secrets are weak placeholders, and this matters more than it looks

`.env.example` on the backend ships with:

```
JWT_ACCESS_SECRET=change-me-in-production
JWT_REFRESH_SECRET=change-me-in-production-too
STORAGE_SIGNED_URL_SECRET=change-me-in-production
```

These are fine as *documentation placeholders*, but the actual `.env` created during this session's setup was generated by literally copying `.env.example` — meaning **the running pilot instance almost certainly still has these exact placeholder values**, not real secrets. This is a genuine, currently-live gap, not a theoretical one.

### FR-SEC-001 — Mandatory Secret Rotation Before Any Non-Local Deployment

Before this backend is ever exposed beyond `localhost` (e.g. deployed to a real server per the eventual `5.9`), all three secrets above **must** be replaced with cryptographically random values (e.g. `python -c "import secrets; print(secrets.token_urlsafe(32))"`), and the JWT secrets specifically must differ from each other. This is not optional hardening — a known, published default secret in a JWT signing key means anyone can forge valid access tokens for any user.

## 6. Data in Transit

### 6.1 Current state (local development)

All traffic today is `http://localhost:8000` — unencrypted, but also never leaving the machine, so this is appropriate for local development and matches how the entire session's testing was actually done.

### 6.2 Known gap: CORS is wide open

`app/main.py` currently has:

```python
app.add_middleware(CORSMiddleware, allow_origins=["*"], allow_methods=["*"], allow_headers=["*"])
```

This was a reasonable simplification to get the Windows app talking to the backend without friction during initial setup, but `allow_origins=["*"]` means **any website, anywhere, could make authenticated requests to this API from a victim's browser** if this were ever deployed as-is with a browser-based client in the picture. For a Flutter-only mobile client this specific risk is lower (browsers aren't the attack surface), but it's still bad practice to carry into any real deployment.

### FR-SEC-002 — CORS Restriction Before Deployment

Before deployment beyond local development, `allow_origins` must be restricted to the actual known origin(s) of legitimate clients (the production API base URL used by the mobile app's `--dart-define=API_BASE_URL`, and any future admin web console origin per `5.1 §5.2`), not a wildcard.

### FR-SEC-003 — TLS Required for Any Non-Local Deployment

Any deployment beyond `localhost` must serve the API over HTTPS (TLS), not plain HTTP — access tokens and refresh tokens currently travel as plain Bearer headers with no additional transport protection, so TLS is the only thing standing between them and anyone on the same network path.

## 7. Data at Rest — Server Side

### 7.1 What's implemented

- PostgreSQL password hashes use bcrypt (§3), not reversible encryption or plaintext.
- Documents (`Document.storage_key`) are served only via short-lived, HMAC-signed tokens (`5.3 AD-FS-004`), verified working conceptually in the backend build, though not yet exercised through the mobile app's document-upload flow in this session (flagged as a gap in `5.7 §7`).

### 7.2 Known gap: no encryption at rest for the database or local file storage

Neither the PostgreSQL database nor the local `storage-data/` folder used by `LocalStorageDriver` (`5.3`) is encrypted at rest today. For a pilot on a personally-controlled machine this is a lower-priority gap; it becomes a real one the moment the database or server disk could be accessed by someone else (e.g. a shared/rented server, a lost backup drive). Full-disk encryption at the OS/hosting level (not application-level database encryption, which adds complexity disproportionate to pilot-stage risk) is the recommended first step when this moves beyond a local machine.

## 8. Data at Rest — Mobile/Device Side

### 8.1 What's implemented and verified

- Access and refresh tokens are stored via `flutter_secure_storage` (`5.6 AD-MOB-005`), which uses the Windows Credential Manager on the platform actually tested this session — **not** a plain file or SharedPreferences-equivalent. This was a design decision from `5.6`, and it is genuinely in the running code, not just documented.
- `AuthController.logout()` clears both the secure-stored tokens **and** wipes the entire local Drift database (`AppDatabase.wipeAllLocalData()`) — meaning a logout on a shared/borrowed device doesn't leave farmer data behind. Implemented per `5.6`'s design; not yet manually tested this session (a cheap test: log out, confirm the Farmers list is empty on next login by a different user).

### 8.2 Known gap: the local SQLite database itself is not encrypted

`AppDatabase` uses Drift's plain `NativeDatabase`, storing `pigpower.sqlite` as an ordinary, unencrypted file in the app's documents directory. Given the device-loss threat model this whole architecture is explicitly designed around (OSDS §2 — rural field devices that can be lost), this is a real gap worth closing before any device carries genuinely sensitive data (farmer ID document contents, financial figures) rather than just names/districts/production numbers.

### FR-SEC-004 — Encrypted Local Database Before Sensitive Data Is Stored Locally

Before the Documents feature (photo/ID capture, per `5.7`'s flagged gap) is built out on mobile, evaluate `drift`'s SQLCipher-backed encrypted database option (`sqlite3_flutter_libs` supports this) so a lost/stolen field device doesn't expose cached farmer records in plaintext by simply copying the `.sqlite` file off the device.

## 9. Input Validation & Injection Protection

### 9.1 What's implemented and verified

- **SQL injection:** all database access goes through SQLAlchemy's ORM/query builder with parameter binding (visible directly in the `uvicorn --reload` logs captured this session — every query shows `$1::VARCHAR`-style bound parameters, never string-concatenated SQL). This is a structural protection, not something that can be individually forgotten per-endpoint.
- **Request validation:** every endpoint validates its body against a Pydantic schema before business logic runs (`5.4`'s equivalent of `FR-BE-011`), confirmed by the earlier `422 VALIDATION_FAILED` behaviour matching the documented IAPI error envelope.

No gaps identified in this domain from the code reviewed — this is one of the stronger areas, largely because SQLAlchemy and Pydantic make the safe path the default path.

## 10. API Abuse Protection

### 10.1 Known gap: no rate limiting implemented

`IAPI FR-IAPI-016/017` (Chapter 4) calls for configurable rate limiting; the Pass 1 backend implements none. At pilot scale with a handful of known users this is low-risk, but the `/v1/auth/login` endpoint specifically has **no brute-force protection** — an attacker with network access to the API could attempt unlimited password guesses against any username.

### FR-SEC-005 — Login Rate Limiting Before Any Non-Local Deployment

At minimum, before deployment beyond local development: apply a rate limit specifically to `/v1/auth/login` (e.g. a small number of attempts per IP/username per minute). This is a smaller, more urgent slice of `IAPI FR-IAPI-016` than full platform-wide rate limiting, and should not wait for that larger effort.

## 11. Dependency / Supply-Chain Hygiene

Both `requirements.txt` and `pubspec.yaml` pin reasonably specific versions (not floating `latest`), which is good practice already in place. Neither has been run through an automated vulnerability scan (e.g. `pip-audit`, `dart pub outdated --mode=null-safety` combined with manual CVE review) as part of this session's work.

### FR-SEC-006 — Periodic Dependency Audit

Recommend running `pip-audit` (backend) and reviewing `flutter pub outdated` output periodically (e.g. monthly, or before any release), rather than only updating dependencies reactively when something breaks.

## 12. Consolidated Gap Summary (Action-Oriented)

For a document this dense, a flat list of what to actually *do*, roughly in priority order for "before this leaves a single trusted local machine":

```
1. FR-SEC-001  Rotate all three .env secrets to real random values
2. FR-SEC-003  Put TLS in front of any non-local deployment
3. FR-SEC-002  Restrict CORS to known origins
4. FR-SEC-005  Rate-limit the login endpoint
5. FR-SEC-004  Evaluate SQLCipher for the local mobile database
                (before Documents/photo capture is built)
6. FR-SEC-006  Run a dependency audit
7. §4.2         Test scope enforcement (Maseru farmer, Berea officer)
8. §7.2/§8.1    Full-disk encryption at hosting level; verify logout
                wipe behaviour
```

Items 1-4 are the ones that matter **before** any deployment beyond your own machine; the rest are good practice on a more relaxed timeline.

## 13. What This Document Does Not Cover

```
5.9  Deployment & Infrastructure Architecture (where TLS, hosting-level
     disk encryption, and secret rotation actually get executed)
5.10 Cost Model
```

## 14. Recommended GitHub File

Create:

```
docs/SRS/Chapter5/SecurityArchitecture.md
```

Then commit it:

```
git add docs/SRS/Chapter5/SecurityArchitecture.md
git commit -m "docs: add security architecture (chapter 5.8), with action-oriented gap list from real implementation review"
git push origin develop
```

## 15. Next Section

**5.9 Deployment & Infrastructure Architecture** is next — and it now has direct, practical stakes, since §12's action list (TLS, secrets, CORS) is really a deployment-readiness checklist in disguise. That document should cover: where the backend actually runs once it leaves your local machine (a low-cost VPS, per `AD-SYS-001`'s cost-consciousness principle), how the PostgreSQL database and file storage are backed up in that environment, how the Flutter app gets built and distributed to real field devices (not just `flutter run -d windows` from a dev machine), and how `§12`'s gap list gets closed as part of the deployment process rather than forgotten.

Given how much of this session was hands-on debugging rather than reading, it may also be worth treating **§12's list as its own work session** — closing FR-SEC-001 through 005 is concrete, bounded, and directly de-risks whatever comes next, whether that's continuing the SRS or adding features.
