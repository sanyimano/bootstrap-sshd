#!/bin/sh
# starts and configures sshd sets root passwd and sets sftpenviroment
# parameters jailname root-passwd
# test Nr of parameters
if [ ! $# -eq 2 ] ; then
  echo " usage bootstrap-ssh.sh jailname root-passwd"
  exit
fi
JAIL="$1"

USER="root"
UPWD="$2"
echo $JAIL
JAILPATH="/usr/local/bastille/jails/${JAIL}/root"
if [ ! -e ${JAILPATH} ] ; then
  echo "Bad jailname ${JAIL}"
  exit
fi
# sshd automatic start
sysrc -j ${JAIL} sshd_enable=YES
# prepare sshd_config for sftp connetion
LOCALPATH="/etc/ssh/"
FNAME="sshd_config"
# strip the config file, remove # lines and leading whitespaces
# save it to a tmp file for further processing
TMPFILE="kuka.tmp"
grep -v "^#" ${JAILPATH}${LOCALPATH}${FNAME} | grep -v "^$" | sed -e 's/^[ \t]*//' > ${TMPFILE}
PARM1="PermitRootLogin yes"
if ! OUTPUT=$(grep  "${PARM1}"  ${TMPFILE}); then
  echo $?
  echo ${OUTPUT}
  echo $PARM1 >> ${JAILPATH}${LOCALPATH}${FNAME}
fi
PARM2="Match Group sftponly"
if ! OUTPUT=$(grep  "${PARM2}"  ${TMPFILE}); then
 echo $PARM2 >> ${JAILPATH}${LOCALPATH}${FNAME}
fi

PARM3="ChrootDirectory %h"
if ! OUTPUT=$(grep  "${PARM3}"  ${TMPFILE}); then
 echo $PARM3 >> ${JAILPATH}${LOCALPATH}${FNAME}
fi

PARM4="ForceCommand internal-sftp"
if ! OUTPUT=$(grep  "${PARM4}"  ${TMPFILE}); then
 echo $PARM4 >> ${JAILPATH}${LOCALPATH}${FNAME}
fi

