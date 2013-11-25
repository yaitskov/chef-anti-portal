

def vm_fqdn(net, name)
  zone = net.bind.zones.find { |zone|
    zone.key?(:domain) and zone.xentries.key?(name)
  }
  zone.xentries[name] + '.' + zone.domain
end
