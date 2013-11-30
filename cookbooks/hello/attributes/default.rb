

default[:a] = 777

default[:sub_a] = "sub a = #{node.a}"

default[:dyn_a] = DynamicAttribute.new do  "sub a = #{node.a}" end
