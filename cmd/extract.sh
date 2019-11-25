#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd );

PLACEHOLDER_DATA=${PLACEHOLDER_DATA:-"./data"};

mkdir -p ${PLACEHOLDER_DATA};

echo "Creating extract at ${PLACEHOLDER_DATA}/wof.extract"

SQLITE="$(node -e "console.log(require('pelias-config').generate().imports.whosonfirst.sqlite === true)")"
if [ "$SQLITE" = "true" ]; then
  exec node --max_old_space_size=8000 ${DIR}/wof_extract_sqlite.js > ${PLACEHOLDER_DATA}/wof.extract;
else
  ${DIR}/wof_extract.sh > ${PLACEHOLDER_DATA}/wof.extract;
fi

echo 'Done!'
