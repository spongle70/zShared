#!/bin/sh
set -u

########################################################
send_ports () {
  . /etc/os-release
  if [ ${ID} = "alpine"]
  then
    netstat -tulnp > /var/tmp/crap.$$
  else
    ss -tulnp > /var/tmp/crap.$$
  fi
  mv /var/tmp/crap.$$ /var/tmp/ports.txt
  ${ZSHARED}/shared/tfile `uname -n` ports /var/tmp/ports.txt
  rm -f /var/tmp/crap.$$ /var/tmp/ports.txt
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
