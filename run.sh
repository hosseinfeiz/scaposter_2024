#!/usr/bin/env bash
set -eo pipefail

FILENAME="poster"

# Ensure xelatex is available
command -v xelatex >/dev/null 2>&1 || {
  echo "Error: xelatex not found in PATH." >&2
  exit 1
}

echo
echo "1) Initial XeLaTeX pass"
xelatex -interaction=nonstopmode "${FILENAME}.tex"

echo
echo "2) Attempting Biber bibliography pass"
if command -v biber >/dev/null 2>&1; then
  if biber "${FILENAME}"; then
    echo "   → Biber succeeded."
  else
    echo "   → Biber failed; falling back to BibTeX." >&2
    echo
    echo "   Running BibTeX..."
    bibtex "${FILENAME}"
  fi
else
  echo "   → Biber not installed; using BibTeX."
  echo
  echo "   Running BibTeX..."
  bibtex "${FILENAME}"
fi

echo
echo "3) XeLaTeX pass #2"
xelatex -interaction=nonstopmode "${FILENAME}.tex"

echo
echo "4) XeLaTeX pass #3"
xelatex -interaction=nonstopmode "${FILENAME}.tex"

echo
echo "✅ Compilation finished. Output file: ${FILENAME}.pdf"