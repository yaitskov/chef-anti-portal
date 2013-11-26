

class Fixnum
  def apply(val)
    i = 0
    while i < self
      i += 1
      val = yield(val)
    end
    val
  end
end
