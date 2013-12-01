


# raise ece
def shex(cmd)
  stdout_r = system(cmd)
  if $?.exitstatus != 0
    raise "failed: #{ cmd }"
  end
  stdout_r
end


def shif(cmd)
  stdout_r = system(cmd)
  $?.exitstatus == 0
end


def sh_notif(cmd)
  stdout_r = system(cmd)
  $?.exitstatus != 0
end
