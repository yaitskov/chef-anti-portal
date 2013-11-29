# merging this recipe with infra::k-vms has not sense
# becaues chef-server doesn't exist at that time
# this recipe is intended to run in solo on workstation

require 'chef/knife'

repo_path = (File.dirname(__FILE__) + '/../../..')

chef_nodes = %x(cd #{repo_path} ; knife node list)

node.lvirt.vms.each do |name,info|
  zone = node.net.bind.zones.find { |zone| zone.xentries.key?(name) }
  host_name = zone.xentries[name]
  %x(ping -c 1 #{ host_name })
  #puts "chef nodes: #{ chef_nodes }"
  if $?.exitstatus == 0 and !chef_nodes.include?(name.to_s)
    ruby_block "bootstrap #{ name }" do
      block do
        Dir.chdir repo_path do
          Chef::Knife.run(%W(bootstrap -i .chef/ssh-node-key.pem
                          -N #{name} --sudo -x #{node.root_user.name}
                          #{host_name}.#{zone.domain}))
        end
      end
    end
  end
end

