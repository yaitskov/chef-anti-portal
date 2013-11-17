# generate dhcpd.conf
template "/etc/dhcp/dhcpd.conf" do
  source "dhcpd.conf.erb"
  variables ({ :dhcp => node.net.dhcp, :nodes => node.kvm })
  action :create
end
# restart dhcpd
service "isc-dhcp-server" do
  action :restart
end
# generate zone conf file
template "/etc/bind/kvms.conf" do
  source "kvms.conf.erb"
  owner 'bind'
  group 'bind'
  mode  0644
  variables ({ :dhcp => node.net.dhcp, :bind => node.net.bind })
end
# create zone folder
directory "/var/lib/bind/zones" do
  owner 'bind'
  group 'bind'
  mode  0755
end
# generate zone file
template "/var/lib/bind/zones/#{ node.net.dhcp.domain }.db" do
  source "kvms.zone.erb"
  owner 'bind'
  group 'bind'
  mode  0644
  variables ({ :net => node.net, :kvm => node.kvm })
end
# generate rev zone file
template "/var/lib/bind/zones/rev.#{ node.net.bind.tenbus }.in-addr.arpa" do
  source "kvms.revzone.erb"
  owner 'bind'
  group 'bind'
  mode  0644
  variables ({ :net => node.net, :kvm => node.kvm })
end
# append link to a zone file
template "/etc/bind/named.conf" do
  source "named.conf.erb"
  owner 'bind'
  group 'bind'
  variables ({ :origin => "/etc/bind/named.conf" })
  not_if { File.contains("/etc/bind/named.conf", "/etc/bind/kvms.conf") }
end
# restart bind
service "bind9" do
  action :restart
end

