#!/bin/sh
set -u

########################################################
send_ip () {
  get_myip
  # ${ZSHARED}/shared/tmsg `uname -n` ${MYEXTERNALIP}
  # ${ZSHARED}/shared/tmsg `uname -n` ${MYFULLIP}

  MSG="Internal:${MYFULLIP}:External:${MYEXTERNALIP}"

  ${ZSHARED}/shared/tmsg `uname -n` ${MSG}

  echo "${SERVER_TYPE}: finished $0"
}

main() {
  MYNAME=$(uname -n)
  echo "--------------Starting $0 -------------------------"
  if [ -d /static/shared ]
  then
    ZSHARED=/static
  else
    if [ -d /volume12/zTools/Sync${MYNAME}/zTools/zShared  ]
    then
      ZSHARED=/volume12/zTools/Sync${MYNAME}/zTools/zShared
    else
      ZSHARED=/zTools/zShared
    fi
  fi

  . ${ZSHARED}/shared/myshared
  send_ip
  echo "--------------Finished $0 -------------------------"
}

main
