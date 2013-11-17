
default[:kvm] = {
  'chef-server' => {
    :mem => 1024,
    :template_disk => '/work/libvirtd/images/chef-server.img',
    :disk => {
      :path => '/work/libvirtd/images',
      :name => 'chef-server.img'
    },
    :hostname => 'chef-server',
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
    :hostname => 'chef-workstation',
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
    :hostname => 'chef-n1',
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
    :hostname => 'chef-n2',
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
    :hostname => 'chef-n3',
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
    :hostname => 'chef-demo',
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
    :hostname => 'chef-n4',
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
    :hostname => 'chef-n5',
    :mac => '52:00:00:00:00:03'
  }
}

default[:net] = {
  :bind => {
    :tenbus => '4.168.192'
  },
  :dhcp => {
    :domain => 'dan.lan',
    :dns_ip => '192.168.4.1',
    :router_ip => '192.168.4.1',
    :subnet =>  '192.168.4.',
    :supnet => '0',
    :netmask => '255.255.255.0'
  }
}
