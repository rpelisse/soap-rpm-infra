#!/bin/bash
#
#

# External global variables - can be tweak or overridden by user
readonly SPECS_FOLDER=${SPECS_FOLDER:-'./SPECS'}

readonly SPEC_NAME_PATTERN=${SPEC_NAME_PATTERN:-'*'}

# Internal global variables

readonly RPMBUILD_CMD=${RPMBUILD_CMD:-'rpmbuild'}

usage() {
  echo "TODO"
  echo ''
}

sanity_check() {
  local cmd=${1}

  which "${cmd}" 2> /dev/null > /dev/null
  status=${?}
  if [ ${status} -ne 0 ]; then
    echo "This script requires the command ${cmd}, please install it before running it."
    exit ${status}
  fi
}

build_rpm() {
  local spec_fullpath=${1}

  echo -n "  - Building RPM from ${spec_fullpath} ... "
  ${RPMBUILD_CMD} '-bb' "${spec_fullpath}" > /dev/null 2> /dev/null
  echo 'Done.'
}

sanity_check ${RPMBUILD_CMD}

echo "Building RPMS from each *.spec file in ${SPECS_FOLDER}/"
for specfile in ${SPECS_FOLDER}/${SPEC_NAME_PATTERN}*
do
  build_rpm "${specfile}"
done
echo ''
