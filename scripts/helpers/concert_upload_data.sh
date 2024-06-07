#!/bin/bash

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/../..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

OUTPURDIR=${sourcecodedir}/concert_data
SRC_PATH=${sourcecodedir}/src

source ${VARIABLES_FILE}

OUTPUT_FILENAME="$REPO_NAME-$BUILD_NUMBER-cyclonedx-sbom.json"
sourcecodedir=$(builtin cd $scriptdir/../..; pwd)


CODE_SCAN_COMMAND="code-scan-sbom-cdxgen.sh --src /concert-sample-src --output-file ${OUTPUT_FILENAME}"
docker run -it --rm -u $(id -u):$(id -g) -v ${SRC_PATH}:/concert-sample-src -v ${OUTPURDIR}:/toolkit-data localhost/ibm-concert-toolkit:v1 bash -c "${CODE_SCAN_COMMAND}"
