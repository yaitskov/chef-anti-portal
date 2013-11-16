
default[:kvm] = {
  'chef-server' => {
    :mem => 1024,
    :template_disk => '/work/libvirtd/images/chef-server.img',
    :disk => {
      :path => '/work/libvirtd/images',
      :name => 'chef-server.img'
    },
    :ip => 2,
    :mac => '52:54:00:c5:75:fa'
  },
  'chef-workstation' => {
    :mem => 512,
    :template_disk => '/work/libvirtd/images/chef-workstation.img',
    :disk => {
      :path => '/work/libvirtd/images',
      :name => 'chef-workstation.img'
    },
    :ip => 3,
    :mac => '52:54:00:20:93:6b'
  },
  'n1' => {
    :mem => 512,
    :template_disk => '/work/libvirtd/images/n1.img',
    :disk => {
      :path => '/work/libvirtd/images',
      :name => 'n1.img'
    },
    :mac => '52:54:00:72:e7:c5',
    :ip => 4
  },
  'n2' => {
    :mem => 512,
    :template_disk => '/work/libvirtd/images/n2.img',
    :disk => {
      :path => '/work/libvirtd/images',
      :name => 'n2.img'
    },
    :mac => '52:54:00:57:8f:46',
    :ip => 5
  },
  'n3' => {
    :mem => 512,
    :template_disk => '/work/libvirtd/images/n3.img',
    :disk => {
      :path => '/work/libvirtd/images',
      :name => 'n3.img'
    },
    :mac => '52:54:00:ec:7d:28',
    :ip => 6
  },
  'chef-kvm.dan.lan' => {
    :mem  => 512,
    :template_disk => '/work/libvirt-template-guest.img',
    :disk => {
      :path => '/work/libvirtd/images',
      :name => 'chef-kvm.img'
    },
    :ip => 7,
    :mac => '52:00:00:00:00:01'
  },
  'n4' => {
    :mem  => 512,
    :template_disk => '/work/libvirt-template-guest.img',
    :disk => {
      :path => '/work/libvirtd/images',
      :name => 'n4.img'
    },
    :ip => 8,
    :mac => '52:00:00:00:00:02'
  },
  'n5' => {
    :mem  => 512,
    :template_disk => '/work/libvirt-template-guest.img',
    :disk => {
      :path => '/work/libvirtd/images',
      :name => 'n5.img'
    },
    :ip => 9,
    :mac => '52:00:00:00:00:03'
  }
}

default[:net] = {
  :dhcp => {
    :domain => 'dan.lan',
    :dns_ip => '192.168.4.1',
    :router_ip => '192.168.4.1',
    :subnet =>  '192.168.4.',
    :supnet => '0',
    :netmask => '255.255.255.0'
  }
}
