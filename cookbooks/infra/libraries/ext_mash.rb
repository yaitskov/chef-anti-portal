require 'hashie'

class Chef::Node::ImmutableMash
  def deep_merge(m2)
    m = Hashie::Mash.new(self)
    m.deep_merge!(m2)
    return m
  end
end

