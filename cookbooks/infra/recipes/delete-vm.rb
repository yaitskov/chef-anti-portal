

node.lvirt.vms.each do |name,info|
  vm_cfg = node.lvirt.vmdefault.deep_merge(info)
  if vm_cfg.deleted
    execute "virsh destroy #{ name }" do
      only_if "virsh domid --domain #{ name }"
    end
  end
end
