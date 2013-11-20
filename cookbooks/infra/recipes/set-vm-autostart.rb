

node.lvirt.vms.each do |name,info|
  vm_cfg = node.lvirt.vmdefault.deep_merge(info)
  if vm_cfg.autostart
    execute "virsh autostart --domain #{ name }"
  else
    execute "virsh autostart --disable --domain #{ name }"
  end
end
