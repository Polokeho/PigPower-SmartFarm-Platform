# PigPower SmartFarm Platform — Mobile App (Pass 1)

Flutter application implementing the architecture decided in SRS 5.6, covering
the same Pass 1 scope as the backend: Auth, Farmer (list/create), Production
(list/capture), with the offline-first sync engine (OSDS) wired through both.

## What's implemented

```
lib/
  core/
    network/      dio client with auth + request-ID interceptors — AD-MOB-003
    storage/      secure token storage — AD-MOB-005
    database/     Drift local database (Farmers, ProductionBatches,
                   VeterinaryRecords, OutboxItems, LookupValues) — AD-MOB-002
    sync/         SyncEngine — the shared offline sync engine — FR-MOB-005
    auth/         AuthState + AuthController (Riverpod)
    router/       go_router with auth-redirect guard — AD-MOB-004
    widgets/      SyncStatusWidget — FR-MOB-007
  features/
    auth/         LoginScreen
    dashboard/     role-gated dashboard tiles — FR-MOB-003
    farmer/        offline-first repository + list/create screens
    production/    offline-first repository + list/capture screens
  app.dart, main.dart
```

## ⚠️ Required setup steps before this will run

This project was scaffolded in a sandboxed environment **without the Flutter
SDK installed** (its installer domains aren't reachable from that sandbox),
so none of the following could be run there:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # generates app_database.g.dart
```

**You must run both of the above yourself** before the app will compile —
`lib/core/database/app_database.dart` has a `part 'app_database.g.dart';`
directive pointing at a file that doesn't exist yet. This is the mobile-side
equivalent of the backend's "run `prisma generate` yourself" caveat — same
underlying reason (sandbox network restrictions), same fix (run it locally).

## Getting started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs

# Point the app at your backend (defaults to the Android emulator's
# loopback address for localhost:3000 if you don't override this):
flutter run --dart-define=API_BASE_URL=http://YOUR_BACKEND_HOST:3000
```

Log in with one of the seed users from the backend README, e.g.
`field.officer.berea` / `ChangeMe123!`.

## Trying the offline flow

1. Log in while online (needed once, to cache your session).
2. Turn on Airplane Mode.
3. Go to Production → tap **+** → fill in a Farm ID and Pig ID(s) → Save.
   Notice this works instantly — no error, no spinner waiting on network.
4. Check the sync status chip in the app bar: it shows "1 item waiting to
   sync."
5. Turn Airplane Mode back off. Within a moment, the chip should update to
   "All synced" — `SyncEngine`'s connectivity listener triggered
   automatically (OSDS FR-OSDS-013).

## What's deliberately NOT in Pass 1

Same scope boundary as the backend (see `pigpower-backend/README.md` and
`5.5 API Architecture §12`). Notably still missing on the mobile side
specifically:

- A real farm/pig picker (the Production capture screen currently takes a
  raw Farm ID / Pig ID text entry — `TODO` comments mark this)
- Veterinary screens (should follow the exact same pattern as Production —
  repository → providers → list/capture screens)
- Document/photo capture screens (the DFM offline-capture flow described in
  5.6 §8 — `StorageService`/upload endpoint exist on the backend, but no
  mobile UI calls them yet)
- SACM reference-data caching into the local `LookupValues` table (the
  `/v1/sync/reference-data` endpoint exists; nothing calls it yet, so the
  district dropdown in `FarmerCreateScreen` is currently hard-coded)
- Real exponential backoff in `SyncEngine` (`OSDS FR-OSDS-031`) — currently
  relies on the next connectivity-restored trigger or manual retry
- Firebase project configuration (`google-services.json` / `GoogleService-Info.plist`)
  needed before `AD-MOB-006`'s FCM integration actually sends anything

## Known simplifications to revisit

- `SyncEngine._reconcile` assumes every submitted item appears in the
  response; a production version should defensively handle a missing
  result (network truncation, etc.).
- Conflict resolution (`OSDS §11`) isn't exercised yet because Pass 1 only
  has append-only entities (Farmer creation, Production, Veterinary) —
  once an UPDATE operation is added for a mutable entity (e.g. editing a
  farmer's phone number), `SyncEngine` needs the field-level merge logic
  from `OSDS FR-OSDS-019` added to `_reconcile`.
