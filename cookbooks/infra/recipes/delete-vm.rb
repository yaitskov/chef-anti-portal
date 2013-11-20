

node.lvirt.vms.each do |name,info|
  vm_cfg = node.lvirt.vmdefault.deep_merge(info)
  if vm_cfg.deleted

    execute "virsh undefine #{ name }" do
      only_if "virsh dominfo n5 | grep Persistent: | grep -c yes"
    end

    execute "virsh destroy #{ name }" do
      only_if "virsh domid --domain #{ name }"
    end

    if !vm_cfg.disk.key?('name')
      vm_cfg.update({ :disk => { :name => name + '.img' } })
    end

    file "#{ vm_cfg.disk.folder }/#{ vm_cfg.disk.name }" do
      action :delete
      backup false
    end
  end
end
