#!/usr/bin/env bash
version=$(curl -sX GET "https://raw.githubusercontent.com/CrunchyData/postgres-operator-examples/main/helm/install/values.yaml" | sed -n 's/^\s*image: registry.developers.crunchydata.com\/crunchydata\/crunchy-postgres:\(ubi8-16.[[:digit:]_-]\)/\1/p' 2>/dev/null)
printf "%s" "${version}"
