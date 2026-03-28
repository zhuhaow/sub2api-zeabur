#!/usr/bin/env bash

set -euo pipefail

TEMPLATE_FILE="${TEMPLATE_FILE:-template.yaml}"
ZEABUR_TEMPLATE_CODE="${ZEABUR_TEMPLATE_CODE:-}"
ZEABUR_TOKEN="${ZEABUR_TOKEN:-}"

if [[ -z "${ZEABUR_TOKEN}" ]]; then
  echo "ZEABUR_TOKEN is required." >&2
  exit 1
fi

if [[ -z "${ZEABUR_TEMPLATE_CODE}" ]]; then
  echo "ZEABUR_TEMPLATE_CODE is required." >&2
  exit 1
fi

if [[ ! -f "${TEMPLATE_FILE}" ]]; then
  echo "Template file not found: ${TEMPLATE_FILE}" >&2
  exit 1
fi

echo "Validating ${TEMPLATE_FILE}"
ruby -e 'require "yaml"; YAML.load_file(ARGV[0]); puts "YAML OK"' "${TEMPLATE_FILE}"

echo "Authenticating Zeabur CLI"
npx zeabur@latest auth login --token "${ZEABUR_TOKEN}" -i=false

echo "Updating template ${ZEABUR_TEMPLATE_CODE}"
npx zeabur@latest template update \
  --code "${ZEABUR_TEMPLATE_CODE}" \
  --file "${TEMPLATE_FILE}" \
  -i=false
