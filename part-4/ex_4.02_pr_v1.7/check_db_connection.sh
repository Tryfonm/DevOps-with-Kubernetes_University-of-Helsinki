#!/bin/bash
if psql "postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres-svc.todo-ns:5432/postgres" -c "SELECT 1" &>/dev/null; then
    exit '0' # Success, the database is reachable
else
    exit '1' # Failure, the database is not reachable
fi
