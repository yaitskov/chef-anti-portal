require 'tempfile'



node.lvirt.vms.each do |name,info|
  # copy image
  vm_cfg = node.lvirt.vmdefault.deep_merge(info)

  #log "name #{ name }  #{ vm_cfg.disk.size_mb } Mb"
  #next
  if !vm_cfg.disk.key?('name')
    vm_cfg.update({ :disk => { :name => name + '.img' } })
  end

  if vm_cfg.deleted or !node.lvirt.process_vms.include?(name.to_sym)
    next
  end

  disk_path = vm_cfg.disk.folder + "/" + vm_cfg.disk.name
  if !File.exist?(disk_path)
    log "skip resize disk of #{name} because file #{disk_path} is missing"
    next
  end
  real_disk_size = File.size(disk_path) / 1024 / 1024 # mbytes
  log "real size #{ real_disk_size } Mb but required #{ vm_cfg.disk.size_mb } Mb"
  if real_disk_size != vm_cfg.disk.size_mb
    execute "virsh shutdown #{ name }" do
      only_if "virsh domstate #{ name } | grep -c running"
    end

    ruby_block "resize disk" do
      block do
        resize_raw_image(disk_path, vm_cfg.disk.size_mb)
      end
    end

    execute "virsh start #{ name }"
  end
end
