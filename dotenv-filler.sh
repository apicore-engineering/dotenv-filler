#!/bin/sh
DOTENV_PATH="${1}"
DOTENV_PREFIX="${2}"
GLOBAL_ENV=$(env)

# Sanity check file path
if ! [ -f "${DOTENV_PATH}" ]; then
    printf -- 'Usage: %s FILE [VAR_PREFIX]\n' "${0}"
    exit 1
fi

# Process variable prefix
if [ -n "${DOTENV_PREFIX}" ]; then
    DOTENV_PREFIX=$( \
        printf -- '%s' "${DOTENV_PREFIX}_" \
            | sed -e 's/[&*+,./:;@|~-]/_/g' \
            | tr -cd '[a-zA-Z0-9_]' \
            | tr '[:lower:]' '[:upper:]' \
    )
fi

# Process file
for DOTENV_KEY in $(sed -n 's/^\([a-zA-Z_][a-zA-Z0-9_]*\)=.*$/\1/p' "${DOTENV_PATH}"); do
    DOTENV_VALUE=$(printf -- '%s' "${GLOBAL_ENV}" | sed -n "s/^${DOTENV_PREFIX}${DOTENV_KEY}=\\(.*\\)\$/\\1/p")
    if [ -n "${DOTENV_VALUE}" ]; then
        DOTENV_VALUE_ESC=$(printf -- '%s' "${DOTENV_VALUE}" | sed 's/[&/\]/\\&/g')
        sed -i "s/^\\(${DOTENV_KEY}=\\).*\$/\\1${DOTENV_VALUE_ESC}/" "${DOTENV_PATH}"
    fi
done
