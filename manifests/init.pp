# @summary This class installs Proxmox on a Debian Buster minimal
#
# Basically applies what is described here, nothing more, nothing less:
# https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_Buster
#
# @example
#   include proxmox

class proxmox {
#  if( $facts['os']['name'] != 'Debian' or $facts['os']['release']['major'] != 10 ) {
#    fail('This modules only works on Debian 10 "buster"')
#  }
  file('/tmp/os':
    content => $facts['os']['name']
  )
  file('/tmp/ver':
    content => $facts['os']['release']['major']
  )
  contain proxmox::packages # Setup the puppet repo and do another full-upgrade
  contain proxmox::install # Actually install ProxmoxVE and reboots
  contain proxmox::cleanup # Remove mainline linux kernel

  Class['proxmox::packages']
->Class['proxmox::install']
->Class['proxmox::cleanup']
}
