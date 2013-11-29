# merging this recipe with infra::k-vms has not sense
# becaues chef-server doesn't exist at that time
# this recipe is intended to run in solo on workstation

require 'chef/knife'

node.lvirt.vms.each do |name,info|
  zone = node.net.bind.zones.find { |zone| zone.xentries.key?(name) }
  host_name = zone.xentries[name]
  %x(ping -c 1 #{ host_name }  )
  if $?.exitstatus == 0
    ruby_block "bootstrap #{ name }" do
      block do
        Dir.chdir (File.dirname(__FILE__) + '/../../..')
        Chef::Knife.run(%W(bootstrap -i .chef/ssh-node-key.pem
                          -N #{name} --sudo -x #{node.root_user.name}
                          #{host_name}.#{zone.domain}))
      end
    end
  end
end

