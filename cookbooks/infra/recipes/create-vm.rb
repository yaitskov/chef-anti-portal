

node.kvm.each do |name,info|
  # copy image
  remote_file "#{ info.disk.path }/#{ info.disk.name }" do
    source "file://#{ info.template_disk }"
    action :create_if_missing
  end

  # create domain spec
  template "#{Chef::Config[:file_cache_path]}/libvirt-domain-for-#{ name }.xml" do
    source "libvirt-domain.xml.erb"
    variables ({ :name => name, :info => info })
    action :create
  end

  # call virsh
  execute "create_domain" do
    command "virsh create --file #{Chef::Config[:file_cache_path]}/libvirt-domain-for-#{ name }.xml"
    not_if "virsh domid --domain #{ name }"
  end
end
