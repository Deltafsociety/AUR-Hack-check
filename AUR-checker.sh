#!/usr/bin/env bash

set -euo pipefail

LIST_FILE="${1:-aur_list.txt}"
REMOVE_SCRIPT="remove_aur.sh"

if ! command -v yay >/dev/null 2>&1; then
  echo "Error: yay is not installed."
  exit 1
fi

if [[ ! -f "$LIST_FILE" ]]; then
  echo "Error: package list file not found: $LIST_FILE"
  exit 1
fi

# Get AUR/foreign packages from yay
declare -A installed

while read -r pkg _; do
  installed["$pkg"]=1
done < <(yay -Qm 2>/dev/null || true)

echo "Scanning AUR packages via yay..."
echo

# Prepare removal script
echo "#!/usr/bin/env bash" > "$REMOVE_SCRIPT"
echo "" >> "$REMOVE_SCRIPT"

found_any=0
missing_any=0

while IFS= read -r line; do
  [[ -z "$line" ]] && continue

  pkg="${line%%:*}"

  if [[ -n "${installed[$pkg]+x}" ]]; then
    echo "[INSTALLED] $pkg"
    echo "  -> suggested remove: yay -Rns $pkg"

    echo "yay -Rns $pkg" >> "$REMOVE_SCRIPT"
    found_any=1
  else
    echo "[MISSING]   $pkg"
    missing_any=1
  fi
done < "$LIST_FILE"

chmod +x "$REMOVE_SCRIPT"

echo
echo "Summary:"
echo "  Installed AUR packages found: $found_any"
echo "  Missing packages: $missing_any"
echo
echo "Removal script generated: ./$REMOVE_SCRIPT"
