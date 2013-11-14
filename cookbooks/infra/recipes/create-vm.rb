

node.kvm.each do |name,info|
  # copy image
  execute "copy-disk-for-#{ name }" do
    command "cp #{ info.template_disk } #{ info.disk.path }/#{ info.disk.name }"
    not_if "cmp #{ info.template_disk } #{ info.disk.path }/#{ info.disk.name }"
  end

  domain_file = "#{Chef::Config[:file_cache_path]}/libvirt-domain-for-#{ name }.xml"
  # create domain spec
  template domain_file do
    source "libvirt-domain.xml.erb"
    variables ({ :name => name, :info => info })
    action :create
  end

  # call virsh
  execute "create_domain" do
    command "virsh create --file #{ domain_file }"
    not_if "virsh domid --domain #{ name }"
  end
end
