#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MIGRATIONS_DIR="${SCRIPT_DIR}/migrations"
CONNECTION_FILE="${SCRIPT_DIR}/db_connection.txt"

if [ ! -f "${CONNECTION_FILE}" ]; then
    echo "db_connection.txt not found."
    exit 1
fi

BASE_CMD="$(cat "${CONNECTION_FILE}")"

if [ ! -d "${MIGRATIONS_DIR}" ]; then
    echo "No migrations directory found. Nothing to apply."
    exit 0
fi

for migration in "${MIGRATIONS_DIR}"/*.sql; do
    if [ -f "${migration}" ]; then
        echo "Applying migration: ${migration}"
        ${BASE_CMD} -f "${migration}"
    fi
done

echo "All migrations applied successfully."
