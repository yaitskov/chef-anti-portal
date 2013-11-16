

node.kvm.each do |name,info|
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

  # generate zone file
  # restart bind
end
