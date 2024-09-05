#!/usr/bin/env bash

set -e

BASE_REPO_PATH=$(pwd)
RELEASE_DIR_PATH="${BASE_REPO_PATH}/release"
SCRIPTS_BUILD_DIR_PATH="${RELEASE_DIR_PATH}/build/scripts"
PARADIGM_BUILD_DIR_PATH="${RELEASE_DIR_PATH}/build/paradigm"
MAPS_BUILD_DIR_PATH="${RELEASE_DIR_PATH}/build/maps"
ZIPS_DIR_PATH="${RELEASE_DIR_PATH}/zips"

mkdir -p \
	"${RELEASE_DIR_PATH}/" \
	"${SCRIPTS_BUILD_DIR_PATH}/" \
	"${SCRIPTS_BUILD_DIR_PATH}/paradigm/" \
	"${PARADIGM_BUILD_DIR_PATH}/" \
	"${MAPS_BUILD_DIR_PATH}" \
	"${ZIPS_DIR_PATH}/"

cd "${RELEASE_DIR_PATH}/"

git clone https://github.com/Bro-Nation/Paradigm "${PARADIGM_BUILD_DIR_PATH}/"

cp -rf "${PARADIGM_BUILD_DIR_PATH}/" "${SCRIPTS_BUILD_DIR_PATH}/"

for path in ${BASE_REPO_PATH}/mission/*
do
	echo "COPY ${path} > "${SCRIPTS_BUILD_DIR_PATH}""
	cp -rf "${path}" "${SCRIPTS_BUILD_DIR_PATH}"
done

rm -rf \
  "${SCRIPTS_BUILD_DIR_PATH}/.git*" \ \
  "${SCRIPTS_BUILD_DIR_PATH}/paradigm/.git*"


for MAP_BASE_PATH in ${BASE_REPO_PATH}/maps/*
do
	echo "PACKAGING MAP: ${MAP_BASE_PATH}"
	MAP_DIR_NAME="bn_mikeforce_events.$(basename ${MAP_BASE_PATH})"
	MAP_DIR_PATH="${MAPS_BUILD_DIR_PATH}/${MAP_DIR_NAME}"

	mkdir -p "${MAP_DIR_PATH}"
	echo "COPYING: ${SCRIPTS_BUILD_DIR_PATH}/ > ${MAP_DIR_PATH}/"
	cp -rf ${SCRIPTS_BUILD_DIR_PATH}/* "${MAP_DIR_PATH}/"
	cp -rf ${MAP_BASE_PATH}/* "${MAP_DIR_PATH}/"

done

cd ${SCRIPTS_BUILD_DIR_PATH}/
echo "ZIPPING: ${SCRIPTS_BUILD_DIR_PATH}/ > ${ZIPS_DIR_PATH}/OnlyTheMissionScripts.zip"
zip -r "${ZIPS_DIR_PATH}/OnlyTheMissionScripts.zip" ./* 

echo "ZIPPING: ${MAPS_BUILD_DIR_PATH} > ${ZIPS_DIR_PATH}/AllMPMissions.zip"
cd "${MAPS_BUILD_DIR_PATH}"
zip -r "${ZIPS_DIR_PATH}/AllMPMissions.zip" ./*

echo "Final release files in ${ZIPS_DIR_PATH}:"
ls -al ${ZIPS_DIR_PATH}/

