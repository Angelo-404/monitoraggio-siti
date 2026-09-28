#!/usr/bin/env bash
# Checks every site in sites.txt. Exits 1 if any is down: the failed run makes GitHub send an email.
set -uo pipefail
down=0
while IFS='|' read -r url text; do
  url="$(echo "$url" | xargs)"; text="$(echo "$text" | xargs)"
  [[ -z "$url" || "$url" == \#* ]] && continue
  body="$(curl -sS -L --max-time 20 --retry 3 --retry-delay 15 --retry-all-errors -w '\n%{http_code}' "$url" 2>&1)"
  code="${body##*$'\n'}"
  if [[ "$code" != "200" ]]; then
    echo "::error::DOWN $url (HTTP $code)"; down=1
  elif [[ -n "$text" && "$body" != *"$text"* ]]; then
    echo "::error::DOWN $url (text \"$text\" missing)"; down=1
  else
    echo "OK   $url"
  fi
done < sites.txt
exit $down
