#!/bin/bash
set -e

#share_folder=""
#image_path=""

vm_username="deb"
vm_ipaddr="localhost"
port_number="2222"
bin_path=$(which qemu-system-x86_64)
img_path="$HOME/.local/virtual-machines/debian/debian.img"
shrd_fold_path="$HOME/Public/share/debian"
vm="debian"

ssh_pid=$(ps a -o pid,cmd \
	| grep ssh \
	| grep "\-p ${port_number}" \
	| wc -l)

qemu_pid=$(ps a -o pid,cmd \
	| grep $vm \
	| grep ${bin_path} \
	| awk '{print $1;}')

## some qemu argumets {{{
#	-daemonize
#	-nographics
#	-serial stdio
#	-net nic -net user,smb=/home/hos/Public/share/arch
#	-net user,hostfwd=tcp::7777-:8001
#	-cdrom /home/prime/dl/iso/manjaro-i3-21.1.2-minimal-210907-linux513.iso
#	-redir tcp:2222::22
#	-device usb-kbd
#	-device usb-mouse
#	-clock unix
## }}}

function run () {
if [[ -z ${qemu_pid} ]]; then
	nohup \
	${bin_path} \
		-boot order=d \
		-drive file=${img_path},format=qcow2 \
		-m 1024 \
		-smp 1 \
		-nographic \
		-enable-kvm \
		-net nic,model=virtio \
		-net user,hostfwd=tcp::2222-:22,smb=${shrd_fold_path} \
		>/dev/null \
		&
	else
		printf '\n%s\n' "The vm is already running"
		printf '%s\n' "qemu PID: ${qemu_pid}"
	fi
}

function pwroff () {
	printf '%s\n' "[sudo shutdown -h now]"
	if [[ ! -z ${qemu_pid} ]]; then
		ssh ${vm_username}@${vm_ipaddr} -p ${port_number} -t "sudo shutdown -h now"
	else
		printf '\n%s\n' "The vm is powered off"
	fi
}

function connect () {
	ssh ${vm_username}@${vm_ipaddr} -p ${port_number}
}

function help () {
cat << _EOF_
on/r:   Run the virtual machine
ssh/c:  Connect to the machine via ssh
off:    Poweroff the machine
_EOF_
	if [[ ! -z ${qemu_pid} ]]; then
		printf '\n%s\n' "qemu PID: ${qemu_pid}"
		if [[ ! -z ${ssh_pid} ]]; then
			printf '%s\n' "${ssh_pid} ssh session(s)"
		else
			printf '%s\n' "No ssh session"
		fi
	else
		printf '\n%s\n' "The vm is powered off"
	fi
}

case $1 in
	r|on)		run ;;
	ssh|c)		connect ;;
	off)		pwroff ;;
	*)			help ;;
esac
