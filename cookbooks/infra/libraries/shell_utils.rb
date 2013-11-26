


# raise ece
def shex(cmd)
  stdout_r = system(cmd)
  if $?.exitstatus != 0
    raise "failed: #{ cmd }"
  end
  stdout_r
end
