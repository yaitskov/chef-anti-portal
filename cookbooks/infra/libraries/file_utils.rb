
class File
  def self.contains(path, substr)
    file = File.open(path)
    result = file.read().index(substr)
    file.close()
    return result
  end
end


# megabytes to gbytes
def gbytes(n)
  n * 1024
end


