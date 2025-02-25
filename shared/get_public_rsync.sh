#!/bin/sh
set -u

########################################################
get_public_rsync () {
  # AUTHDIR=/root/.ssh
  # AUTHFILE=${AUTHDIR}/authorized_keys

  # mkdir -p ${AUTHDIR}

  AUTHDIR=/root/.ssh
  AUTHFILE=${AUTHDIR}/authorized_keys

  mkdir -p ${AUTHDIR}

  echo "Save keys from environment"
  echo "${PUBLIC_KEYS}" | base64 -d > ${AUTHFILE}
  chmod 644 ${AUTHFILE}

  cd /tmp
  rm -rf /tmp/z*

  REPO=https://mint.nopenso.com/mirror

  curl -LJO  ${REPO}/zKeys/archive/main.zip
  unzip zKeys*.zip

  cd zkeys
  echo "Save keys from github"
  cat _r*.pub >> ${AUTHFILE}
  # remove above lines in near future
  cat _[1-9]rs*.pub >> ${AUTHFILE}

  echo "The approved keys are:"
  cat ${AUTHFILE}
  rm -rf ./z*
  echo "${SERVER_TYPE}: finished $0"
}


main() {
  echo "--------------Starting $0 -------------------------"
  get_public_rsync
}

main
