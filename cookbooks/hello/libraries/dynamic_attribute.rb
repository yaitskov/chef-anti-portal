


class DynamicAttribute
  def initialize(&block)
    @block = block
  end
  def to_s
    @block.call
  end
end
