


# copy image
remote_file "#{ node.kvm.disk.path }/#{ node.kvm.disk.name }" do
  source "file://#{ node.kvm.template_disk }"
  action :create_if_missing
end

# create domain spec
template "#{Chef::Config[:file_cache_path]}/libvirt-domain-for-#{ node.kvm.name }.xml" do
  source "libvirt-domain.xml.erb"
  action :create
end

# call virsh
execute "create_domain" do
  command "virsh create --file #{Chef::Config[:file_cache_path]}/libvirt-domain-for-#{ node.kvm.name }.xml"
  not_if "virsh domid --domain #{ node.kvm.name }"
end
