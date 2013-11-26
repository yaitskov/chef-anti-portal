# generate dhcpd.conf
template "/etc/dhcp/dhcpd.conf" do
  source "dhcpd.conf.erb"
  variables ({ :dhcp => node.net.dhcp, :vms => node.lvirt.vms })
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
  variables ({ :zones => node.net.bind.zones })
end
# create zone folder
directory "/var/lib/bind/zones" do
  owner 'bind'
  group 'bind'
  mode  0755
end
node.zones do |zone|
  if zone.key?(:domain)
    # generate zone file
    template "/var/lib/bind/zones/#{ node.net.dhcp.domain }.db" do
      source "kvms.zone.erb"
      owner 'bind'
      group 'bind'
      mode  0644
      variables ({ :zone => zone, :ip_pool => node.net.dhcp.pool })
    end
  end
  # generate rev zone file
  template "/var/lib/bind/zones/rev.#{ zone.subnet.reverse.join(".") }.in-addr.arpa" do
    source "kvms.revzone.erb"
    owner 'bind'
    group 'bind'
    mode  0644
    variables ({ :zone => zone, :ip_pool => node.net.dhcp.pool })
  end
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

