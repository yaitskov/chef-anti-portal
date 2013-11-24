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

  # TODO: mount guest image and set host name
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
    only_if "virsh dominfo n5 | grep Persistent: | grep -c yes"
  end

  execute "virsh start #{ name }" do
    not_if "virsh domstate --domain #{ name } | grep -c running"
  end
end
