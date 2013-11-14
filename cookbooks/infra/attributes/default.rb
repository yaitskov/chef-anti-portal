
default[:kvm] = {
  'chef-kvm.dan.lan' => {
    :mem  => 512,
    :template_disk => '/work/libvirt-template-guest.img',
    :disk => {
      :path => '/work/libvirtd/images',
      :name => 'chef-kvm.img'
    },
    :mac => '52:00:00:00:00:01'
  },
  'n4' => {
    :mem  => 512,
    :template_disk => '/work/libvirt-template-guest.img',
    :disk => {
      :path => '/work/libvirtd/images',
      :name => 'n4.img'
    },
    :mac => '52:00:00:00:00:02'
  },
  'n5' => {
    :mem  => 512,
    :template_disk => '/work/libvirt-template-guest.img',
    :disk => {
      :path => '/work/libvirtd/images',
      :name => 'n5.img'
    },
    :mac => '52:00:00:00:00:03'
  }
}
