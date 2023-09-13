# starts and configures sshd sets root passwd and sets sftp enviroment
# parameters jailname root-passwd in BASTILLE created jails, using zfs.
usage bootstrap-ssh.sh jailname root-passwd
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
5. Generates ssh-keys type: ecdsa

