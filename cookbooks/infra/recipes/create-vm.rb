

node.kvm.each do |name,info|
  # copy image
  remote_file "#{ info.disk.path }/#{ info.disk.name }" do
    source "file://#{ info.template_disk }"
    action :create_if_missing
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
