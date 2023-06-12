#!/bin/sh
set -u

########################################################
send_ports () {
  . /etc/os-release
  if [ ${ID} = "alpine" ]
  then
	  NPORTS=$(netstat -tulnp| awk '{ print $4 }'| awk -F0: '{ print $2 }'| sort -u | tr '\n' ' ')
  else
	  NPORTS=$(ss -tulnp| awk '{ print $5 }'| awk -F0: '{ print $2 }'| sort -u | tr '\n' ' ')
  fi
  nn=""$NPORTS""
  ${ZSHARED}/shared/tmsg `uname -n` ${nn}
  echo "${SERVER_TYPE}: finished $0"
}

main() {
  echo "--------------Starting $0 -------------------------"
  if [ -d /static/shared ]
  then
    ZSHARED=/static
  else
    ZSHARED=/zTools/zShared
  fi

  . ${ZSHARED}/shared/myshared
  send_ports
  echo "--------------Finished $0 -------------------------"
}

main
