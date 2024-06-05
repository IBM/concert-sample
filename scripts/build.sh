#!/usr/bin/env bash

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

source ${VARIABLES_FILE}

if test -z "$IMAGE_NAME"; then
   IMAGE_NAME="concert-sample"
fi

if test -z "$IMAGE_TAG"; then
   IMAGE_TAG="sample"
fi

# shellcheck disable=SC2086
docker build -f $sourcecodedir/Dockerfile -t ${IMAGE_NAME}:${IMAGE_TAG} 


IMAGE_DIGEST="$(docker inspect --format='{{index .RepoDigests 0}}' "${IMAGE_NAME}:${IMAGE_TAG}" | awk -F@ '{print $2}')"
REPO_COMMIT_SHA="$(git rev-parse HEAD)"
REPO_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
echo -e "export REPO_BRANCH=${REPO_BRANCH}"  >> ${VARIABLES_FILE}
echo -e "export REPO_COMMIT_SHA=${REPO_COMMIT_SHA}"  >> ${VARIABLES_FILE}
echo -e "export IMAGE_DIGEST=${IMAGE_DIGEST}" >> ${VARIABLES_FILE}


