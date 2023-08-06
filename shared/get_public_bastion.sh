#!/bin/sh
set -u

########################################################
get_public_bastion () {
  # AUTHDIR=/root/.ssh
  # AUTHFILE=${AUTHDIR}/authorized_keys

  # mkdir -p ${AUTHDIR}

  AUTHDIR=/var/lib/bastion/.ssh
  AUTHFILE=${AUTHDIR}/authorized_keys

  mkdir -p ${AUTHDIR}

  echo "Save keys from environment"
  echo "${PUBLIC_KEYS}" | base64 -d > ${AUTHFILE}
  chmod 644 ${AUTHFILE}

  cd /tmp
  rm -rf /tmp/z*

  REPO=https://mint.nopenso.com/mirror

  which unzip
  if [ $? == 1 ]
    curl -LJO  ${REPO}/zKeys/archive/main.tar.gz
    tar -zvxf zKeys*.tar.gz
  else
    curl -LJO  ${REPO}/zKeys/archive/main.zip
    unzip zKeys*.zip

  cd zkeys
  echo "Save keys from github"
  if [ "${SERVER_TYPE}" == "master" ]
  then
      cat _b*.pub >> ${AUTHFILE}
      cat _d*.pub >> ${AUTHFILE}
      # remove above lines in near future
      cat _[1-9]ba*.pub >> ${AUTHFILE}
  else
      cat _v*.pub >> ${AUTHFILE}
      # remove above lines in near future
      cat _[1-9]vi*.pub >> ${AUTHFILE}
  fi

# testing
  #     cat _d*.pub >> ${AUTHFILE}
  #     cat _v*.pub >> ${AUTHFILE}
  # AUTHDIR=/root/.ssh
  # AUTHFILE=${AUTHDIR}/authorized_keys
  #     cat _d*.pub >> ${AUTHFILE}
  #     cat _v*.pub >> ${AUTHFILE}

  echo "The approved keys are:"
  cat ${AUTHFILE}
  rm -rf ./z*
  echo "${SERVER_TYPE}: finished $0"
}


main() {
  echo "--------------Starting $0 -------------------------"
  get_public_bastion
}

main
