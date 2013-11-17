
default[:lvirt] = {
  :default => {
    :disk_images => '/work/libvirtd/images',
    :template_disk => '/work/libvirt-template-guest.img',
    :mem => 512 #megabytes
  },
  :vms => {
    'chef-server' => {
      :mem => 1024,
      :mac => '52:54:00:c5:75:fa'
    },
    'chef-workstation' => { :mac => '52:54:00:20:93:6b' },
    'n1' => { :mac => '52:54:00:72:e7:c5' },
    'n2' => { :mac => '52:54:00:57:8f:46' },
    'n3' => { :mac => '52:54:00:ec:7d:28' },
    'chef-kvm.dan.lan' => {
      :disk => { :name => 'chef-kvm.img' },
      :mac => '52:00:00:00:00:01'
    },
    'n4' => { :mac => '52:00:00:00:00:02' },
    'n5' => { :mac => '52:00:00:00:00:03' }
  }
}

default[:net] = {
  :bind => {
    :zones =>
    [ {
        :subnet =>  [ 192, 168, 4 ],
        :domain => 'dan.lan', # no direct zone if missing
        :entries => {
          'chef-server' => 'chef-server',
          'chef-workstation' => 'chef-workstation',
          :n1 => 'chef-n1',
          :n2 => 'chef-n2',
          :n3 => 'chef-n3',
          :n4 => 'chef-n4',
          :n5 => 'chef-n5',
          # hack for exclusive hosts (real hardware)
          :kvms => { :hostname => 'kvms', :ip => 1 },
          :hp530 => { :hostname => 'hp530', :ip => '192.168.0.52',
            :type => 'direct' },
          'chef-kvm.dan.lan' => 'chef-demo'
        }
      },
      {
        :subnet =>  [ 192, 168, 0 ],
        :entries => {
          :hp530 => { :ip => 52 }
        }
      }
    ]
  },
  :dhcp => {
    :domain => 'dan.lan',
    :dns_ip => '192.168.4.1',
    :router_ip => '192.168.4.1',
    :subnet =>  [ 192, 168, 4 ],
    :supnet => [ 0 ],
    :netmask => '255.255.255.0',
    :pool => { # only for vms
      'chef-server' => 2,
      'chef-workstation' => 3,
      'n1' => 4,
      'n2' => 5,
      'n3' => 6,
      'chef-kvm.dan.lan' => 7,
      'n4' => 8,
      'n5' => 9,
    }
  }
}
