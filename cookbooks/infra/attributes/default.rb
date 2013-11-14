
default[:kvm] = {
  'chef-kvm.dan.lan' => {
    :mem  => 512,
    :template_disk => '/work/libvirt-template-guest.img',
    :disk => {
      :path => '/work/libvirtd/images',
      :name => 'chef-kvm.img'
    },
    :mac => '52:00:00:00:00:01'
  }
}
