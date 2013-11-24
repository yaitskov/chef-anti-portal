
default[:lvirt] = {
  :process_vms => [ :n1 ],
  :vmdefault => {
    :disk => {
      :size => gbytes(2),
      :folder => '/work/libvirtd/images',
      :template => '/work/libvirt-template-guest.img'
    },
    :autostart => true,
    :deleted => false,
    :produce_as => :define,
    :mem => 512 #megabytes
  },
  :vms => {
    :'chef-server' => {
      :mem => 1024,
      :mac => '52:54:00:c5:75:fa'
    },
    :'chef-workstation' => {
      :mac => '52:54:00:20:93:6b'
    },
    :n1 => {
      :mac => '52:54:00:72:e7:c5',
      :disk => { :size => gbytes(5) }
    },
    :n2 => {
      :mac => '52:54:00:57:8f:46'
    },
    :n3 => {
      :mac => '52:54:00:ec:7d:28'
    },
    :'chef-kvm.dan.lan' => {
      :disk => { :name => 'chef-kvm.img' },
      :mac => '52:00:00:00:00:01'
    },
    :n4 => {
      :mac => '52:00:00:00:00:02',
      :disk => { :size => gbytes(5) }
    },
    :n5 => {
      :mac => '52:00:00:00:00:03',
      :deleted => true
    }
  }
}

default[:net] = {
  :bind => {
    :zones =>
    [ {
        :subnet =>  [ 192, 168, 4 ],
        :ns => 'kvms',
        :domain => 'dan.lan', # no direct zone if missing
        :entries => {
          :'chef-server' => 'chef-server',
          :'chef-workstation' => 'chef-workstation',
          :n1 => 'chef-n1',
          :n2 => 'chef-n2',
          :n3 => 'chef-n3',
          :n4 => 'chef-n4',
          :n5 => 'chef-n5',
          # hack for exclusive hosts (real hardware)
          :kvms => { :hostname => 'kvms', :short_ip => [ 1 ] },
          :hp530 => { :hostname => 'hp530', :full_ip => '192.168.0.52' },
          :'chef-kvm.dan.lan' => 'chef-demo'
        }
      },
      {
        :subnet =>  [ 192, 168, 0 ],
        :entries => {
          :hp530 => { :short_ip => [ 52 ] }
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
      :'chef-server' => [ 2 ],
      :'chef-workstation' => [ 3 ],
      :n1 => [ 4 ],
      :n2 => [ 5 ],
      :n3 => [ 6 ],
      :'chef-kvm.dan.lan' => [ 7 ],
      :n4 => [ 8 ],
      :n5 => [ 9 ],
    }
  }
}


default.dd = "default dd message"
