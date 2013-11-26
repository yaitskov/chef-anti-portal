# creates all virtual machines with libvirt


node.lvirt.vms.each do |name,info|
  # copy image
  vm_cfg = node.lvirt.vmdefault.deep_merge(info)
  if !vm_cfg.disk.key?('name')
    vm_cfg.update({ :disk => { :name => name + '.img' } })
  end

  if vm_cfg.deleted
    return
  end

  disk = vm_cfg.disk.folder + '/' + vm_cfg.disk.name
  execute "cp #{ vm_cfg.disk.template } #{ disk }" do
    not_if "[ -f #{ disk } ]"
  end

  execute "virsh shutdown #{ name }" do
    only_if "virsh domstate #{ name } | grep -c running"
  end

  ruby_block "resize disk" do
    block do
      resize_raw_image(disk, vm_cfg.disk.size_mb)
    end
    not_if { File.size(disk) == vm_cfg.disk.size_mb  * 1024 * 1024 }
  end

  execute "check loop is free" do
    command "losetup -d /dev/loop0"
    only_if "losetup -a | grep /dev/loop0"
  end

  execute "bind image with device" do
    command "losetup /dev/loop0 #{ disk }"
    not_if "losetup /dev/loop0 | grep #{disk}"
  end

  execute "clear kernel cache" do
    command "partprobe /dev/loop0"
  end

  directory "/tmp/mount-vm-image"

  # if previous fail
  execute "umount image" do
    command "umount /dev/loop0p1"
    only_if "df | grep /tmp/mount-vm-image"
  end

  execute "mount image" do
    command "mount -t ext4 /dev/loop0p1 /tmp/mount-vm-image"
  end

  template "/tmp/mount-vm-image/etc/hostname" do
    source "hostname.erb"
    variables ({  :hostname => vm_fqdn(node.net, name) })
  end

  execute "unmount image" do
    command "umount /dev/loop0p1"
  end

  directory "/tmp/mount-vm-image"  do
    action :delete
  end

  execute " free loop" do
    command "losetup -d /dev/loop0"
  end

  domain_file = "#{Chef::Config[:file_cache_path]}/libvirt-domain-for-#{ name }.xml"
  # create domain spec
  template domain_file do
    source "libvirt-domain.xml.erb"
    variables ({ :name => name, :info => vm_cfg })
  end

  # call virsh
  execute "virsh #{ vm_cfg.produce_as } #{ domain_file }" do
    not_if "virsh domid --domain #{ name }"
  end

  execute "virsh autostart #{ name }" do
    only_if "virsh dominfo #{ name } | grep Persistent: | grep -c yes"
  end

  execute "virsh start #{ name }" do
    not_if "virsh domstate --domain #{ name } | grep -c running"
  end
end
