#!/usr/bin/env bash
#
# Verifies the Row Level Security policies against a real PostgreSQL server.
#
# Spins up a throwaway cluster, applies every migration plus the generated
# seed, then runs `supabase/tests/rls.sql`, which asserts that:
#
#   · a learner can read and write only their own rows
#   · the course catalogue is read-only for learners
#   · the XP ledger is append-only and rejects duplicate awards
#   · an anonymous visitor can read the public roadmap and nothing else
#
# Requires: PostgreSQL 14+ binaries on PATH (or /usr/lib/postgresql/*/bin).
# Usage:    ./scripts/test-rls.sh

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PGBIN="$(ls -d /usr/lib/postgresql/*/bin 2>/dev/null | tail -1 || true)"
[ -n "$PGBIN" ] && export PATH="$PGBIN:$PATH"

command -v initdb >/dev/null 2>&1 || {
  echo "✗ PostgreSQL binaries not found. Install postgresql-16 (or newer) and retry." >&2
  exit 1
}

WORKDIR="${TMPDIR:-/var/tmp}/html-hero-rls-$$"
PGDATA="$WORKDIR/data"
SOCKDIR="$WORKDIR/sock"
PORT="${PGPORT_OVERRIDE:-55433}"

cleanup() {
  pg_ctl -D "$PGDATA" stop -m immediate >/dev/null 2>&1 || true
  rm -rf "$WORKDIR"
}
trap cleanup EXIT

mkdir -p "$PGDATA" "$SOCKDIR"

# initdb refuses to run as root, so drop to the postgres user when necessary.
RUN=""
if [ "$(id -u)" = "0" ] && id postgres >/dev/null 2>&1; then
  chown -R postgres "$WORKDIR"
  RUN="su postgres -c"
fi

run_pg() {
  if [ -n "$RUN" ]; then
    su postgres -c "PATH=$PATH $*"
  else
    eval "$@"
  fi
}

echo "→ starting a throwaway PostgreSQL cluster"
run_pg "initdb -D '$PGDATA' -U dev --auth=trust" >/dev/null
run_pg "pg_ctl -D '$PGDATA' -o '-p $PORT -k $SOCKDIR -c listen_addresses=' -l '$PGDATA/log' start" >/dev/null
sleep 2

DBURL="postgresql://dev@/htmlhero?host=$SOCKDIR&port=$PORT"
ADMIN="postgresql://dev@/postgres?host=$SOCKDIR&port=$PORT"

psql "$ADMIN" -q -c "create database htmlhero;"

echo "→ applying the Supabase compatibility shim"
psql "$DBURL" -v ON_ERROR_STOP=1 -q -f "$ROOT/supabase/tests/local-shim.sql"

echo "→ applying migrations"
for migration in "$ROOT"/supabase/migrations/*.sql; do
  echo "   $(basename "$migration")"
  psql "$DBURL" -v ON_ERROR_STOP=1 -q -f "$migration"
done

if [ -f "$ROOT/supabase/seed.sql" ]; then
  echo "→ loading seed data"
  psql "$DBURL" -v ON_ERROR_STOP=1 -q -f "$ROOT/supabase/seed.sql"
else
  echo "✗ supabase/seed.sql is missing. Run: npm run seed:generate" >&2
  exit 1
fi

echo "→ running Row Level Security assertions"
# psql prefixes RAISE output with "psql:file:line: NOTICE:  ", so strip
# everything up to and including the severity label before counting.
OUTPUT="$(psql "$DBURL" -q -f "$ROOT/supabase/tests/rls.sql" 2>&1 |
  grep -E '\b(PASS|FAIL)\b' |
  sed -E 's/^.*(NOTICE|WARNING|ERROR):[[:space:]]*//; s/^[[:space:]]+//')"

echo "$OUTPUT"

FAILURES="$(echo "$OUTPUT" | grep -c '^FAIL' || true)"
PASSES="$(echo "$OUTPUT" | grep -c '^PASS' || true)"

echo
if [ "$FAILURES" -gt 0 ]; then
  echo "✗ $FAILURES of $((PASSES + FAILURES)) RLS assertions failed"
  exit 1
fi
echo "✓ all $PASSES RLS assertions passed"
