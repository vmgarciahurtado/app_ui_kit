#!/usr/bin/env bash
# Cobertura del paquete: corre las pruebas y falla si el porcentaje baja del
# mínimo.
#
#   ./test/scripts/coverage.sh          # reporte en consola
#   ./test/scripts/coverage.sh --html   # además abre el reporte navegable
#
# Requiere lcov (`brew install lcov` en macOS, `apt install lcov` en Linux).
set -euo pipefail

MIN=95
cd "$(dirname "$0")/../.."

echo "==> flutter test --coverage"
flutter test --coverage

lcov --list coverage/lcov.info

PCT=$(lcov --summary coverage/lcov.info 2>&1 \
  | grep -m1 'lines' \
  | sed -E 's/.*: ([0-9.]+)%.*/\1/')

if [[ "${1:-}" == "--html" ]]; then
  genhtml coverage/lcov.info -o coverage/html --quiet
  echo "==> reporte en coverage/html/index.html"
  # El reporte se abre si hay con qué: en CI no hay navegador y no debe fallar.
  if command -v open >/dev/null; then
    open coverage/html/index.html
  elif command -v xdg-open >/dev/null; then
    xdg-open coverage/html/index.html
  fi
fi

echo "==> cobertura de líneas: ${PCT}% (mínimo ${MIN}%)"
awk -v pct="$PCT" -v min="$MIN" 'BEGIN { exit (pct + 0 >= min + 0) ? 0 : 1 }' || {
  echo "FALLA: la cobertura quedó por debajo del mínimo exigido." >&2
  exit 1
}
echo "OK"
