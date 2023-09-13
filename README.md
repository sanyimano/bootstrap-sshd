# Configures sshd in BASTILLE created jails, using zfs
sets root passwd and prepares sftp enviroment in sshd
parameters jailname root-passwd.

usage: bootstrap-ssh.sh jailname root-passwd

Jails are located here:
JAILPATH="/usr/local/bastille/jails/${JAIL}/root"
1. test wheather jail exists
2. sets sshd automatical start : sshd_enable=YES
3. Modifies the /etc/ssh/sshd_config file parameters
PermitRootLogin yes
Match Group sftponly
ChrootDirectory %h
ForceCommand internal-sftp
AllowTcpForwarding no
X11Forwarding no
4. Adds sftponly group
5. sets jails root password
6. Generates ssh-keys type: ecdsa for jails root
(interaction required)

