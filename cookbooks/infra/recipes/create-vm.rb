# creates all virtual machines with libvirt


node.lvirt.vms.each do |name,info|
  # copy image
  vm_cfg = node.lvirt.vmdefault.deep_merge(info)
  if !vm_cfg.disk.key?('name')
    vm_cfg.update({ :disk => { :name => name + '.img' } })
  end
  disk = vm_cfg.disk.folder + '/' + vm_cfg.disk.name
  execute "cp #{ vm_cfg.disk.template } #{ disk }" do
    not_if "[ -f #{ disk } ]"
  end
  # TODO: resize to require size
  # TODO: mount guest image and set host name
  domain_file = "#{Chef::Config[:file_cache_path]}/libvirt-domain-for-#{ name }.xml"
  # create domain spec
  template domain_file do
    source "libvirt-domain.xml.erb"
    variables ({ :name => name, :info => vm_cfg })
  end

  # call virsh
  execute "create_domain" do
    command "virsh create --file #{ domain_file }"
    not_if "virsh domid --domain #{ name }"
  end
end
