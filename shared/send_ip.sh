#!/bin/sh
set -u

########################################################
send_ip () {
  get_myip
  # ${ZSHARED}/shared/tmsg `uname -n` ${MYEXTERNALIP}
  # ${ZSHARED}/shared/tmsg `uname -n` ${MYFULLIP}

  MSG="Internal:${MYFULLIP}:External:${MYEXTERNALIP}"

  ${ZSHARED}/shared/tmsg `uname -n` ${MSG}

  if [ -z ${SERVER_TYPE+x} ]
  then 
    SERVER_TYPE='SERVER_NOT_SET'
  fi
  echo "${SERVER_TYPE}: finished $0"
}

main() {
  MYNAME=$(uname -n)
  echo "--------------Starting $0 -------------------------"
  if [ -d /static/shared ]
  then
    ZSHARED=/static
  else
    if [ -d /zz/zShared  ]
    then
      ZSHARED=/zz/zShared
    fi
  fi

  . ${ZSHARED}/shared/myshared
  send_ip
  echo "--------------Finished $0 -------------------------"
}

main
