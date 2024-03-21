#!/usr/bin/env bash
version=$(curl -sX GET "https://raw.githubusercontent.com/CrunchyData/postgres-operator-examples/main/helm/postgres/values.yaml" | sed -n 's/# imagePostgres: registry\.developers\.crunchydata\.com\/crunchydata\/crunchy-postgres:\(\S*\)/\1/p' 2>/dev/null)
printf "%s" "${version}"
