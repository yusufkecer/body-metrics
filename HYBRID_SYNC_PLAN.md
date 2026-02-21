# Hybrid Sync Plan (Local Cache + Background Sync API)

This document provides a practical migration plan to a **hybrid architecture** without losing the local-first behavior.

## 1) Goal
- Keep the app **offline-first**.
- Sync with server in the background when network is available.
- Preserve fast UX while adding data safety and multi-device support.

---

## 2) Why Hybrid?
- Local-only: fast, but risky for device changes or data loss.
- Remote-only: network-dependent, poor UX in weak/no connectivity.
- Hybrid: combines the strengths of both.

---

## 3) Scope
Initial entities to sync:
- `user`
- `user_metrics`
- `app_model` (minimal if needed)

Priority: `user_metrics` (BMI/VTI history).

---

## 4) Local Data Model Extension
Recommended additional fields for `user_metrics`:
- `sync_status` (`pending|synced|failed`)
- `server_id` (remote primary id)
- `updated_at`
- `deleted_at` (soft delete)
- `retry_count`
- `last_error`

Note: `created_at` already exists and should remain canonical for timeline order.

---

## 5) Sync Strategy

### A) Write path (offline-first)
1. UI -> Cubit -> UseCase -> Local DB write
2. Create an outbox entry (`event_type`, `entity`, `payload`, `created_at`)
3. Show success to user based on local write

### B) Background sync worker
- Triggers:
  - app startup
  - scheduled interval
  - network reconnect
- Push pending outbox records to batch API
- Mark `synced` on success, `failed + retry_count` on failure

### C) Pull path
- `GET /metrics?since=lastSyncAt`
- Merge incoming records into local DB
- Conflict policy (phase 1): `last-write-wins` using `updated_at`

---

## 6) Backend (Go) Recommendation

### Stack
- Go + Fiber/Echo/Gin
- PostgreSQL
- JWT auth (optional at start)

### Minimum API Contract
- `POST /v1/metrics/batch`
- `GET /v1/metrics?since=...`
- `POST /v1/users`
- `PATCH /v1/users/{id}`

### Batch payload example
```json
{
  "device_id": "abc",
  "events": [
    {
      "local_id": 123,
      "type": "UPSERT_METRIC",
      "payload": {
        "user_id": 4,
        "weight": 78.2,
        "bmi": 24.6,
        "created_at": "2026-02-20T10:22:33Z"
      }
    }
  ]
}
```

---

## 7) App-Side Layering
Suggested new components:
- `SyncService` (application layer)
- `NetworkInfoService`
- `OutboxCache`
- `RemoteRepository` (API)
- `SyncOrchestratorUseCase`

This can be added without breaking existing UseCase/Repository architecture.

---

## 8) Roadmap

### Phase 1 (1-2 sprints)
- Local model migration (`sync_status`, `server_id`, `updated_at`)
- Outbox table
- Manual “Sync now” action

### Phase 2
- Background scheduler + retry/backoff
- Batch push + incremental pull
- Basic conflict resolution

### Phase 3
- Observability (sync logs screen)
- Advanced conflict policies
- Multi-device end-to-end tests

---

## 9) Risks and Mitigation
- **Schema drift**: keep migrations idempotent.
- **Duplicate events**: use idempotency keys.
- **Partial failure**: support event-level acknowledgements.
- **Clock skew**: normalize timestamps on server side.

---

## 10) Success Criteria
- No data loss while offline
- Sync completes within 30s after network returns
- Consistent metric history for same user across 2 devices
- Stable Home ordering based on `created_at`

