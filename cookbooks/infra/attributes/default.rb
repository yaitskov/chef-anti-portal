
default[:lvirt] = {
  :process_vms => [ :n1 ],
  :vmdefault => {
    :disk => {
      :size_mb => gbytes(4),
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
      :disk => { :size_mb => gbytes(6) },
      :mac => '52:54:00:c5:75:fa'
    },
    :n1 => {
      :mac => '52:54:00:72:e7:c5',
      :disk => {
        :size_mb => gbytes(22)
      },
      :mem => 768
    },
    :n2 => {
      :mac => '52:54:00:00:00:01',
      :mem => 768,
      :disk => {
        :size_mb => gbytes(22)
      }
    },
    :n3 => {
      :mac => '52:54:00:00:00:02',
      :mem => 768,
      :disk => {
        :size_mb => gbytes(22)
      }
    }
  }
}

default[:net] = {
  :bind => {
    :zones =>
    [ {
        :subnet =>  [ 192, 168, 4 ],
        :xtype => :both,
        :ns => 'kvms',
        :domain => 'dan.lan', # no direct zone if missing
        :xentries => {
          :'chef-server' => 'chef-server',
          :'chef-workstation' => 'chef-workstation',
          :n1 => 'chef-n1',
          :n2 => 'cas2',
          :n3 => 'cas3',
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
        :ns => 'kvms',
        :domain => 'dan.lan', # no direct zone if missing
        :xtype => :rev,
        :xentries => {
          :hp530 => { :short_ip => [ 52 ], :hostname => 'hp530' }
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

default.root_user = { :name => 'dan' }
