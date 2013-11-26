

def resize_raw_image(path,new_size_mb)
  tmpimage = Tempfile.new('resizing_' + File.basename(path), File.dirname(path))
  begin
    new_size = new_size_mb * 1024 * 1024
    tmpimage.truncate(new_size)
    #Chef::Log.info("virt-resize --expand /dev/sda1 #{path} #{tmpimage.path}")
    #Chef::Log.info("new size #{new_size} old size  #{ File.size(path) }")    
    msg = %x(virt-resize --expand /dev/sda1 #{path} #{tmpimage.path} 2>&1)
    e_st = $?.exitstatus
    #Chef::Log.info("virt-resize exit status #{e_st}")        
    if e_st != 0
      msg = "failed resize: #{ msg };\nvirt-resize --expand /dev/sda1 #{path} #{tmpimage.path}"
      tmpimage.close
      tmpimage.unlink
      raise msg
    else
      Chef::Log.info("resize is ok")      
      tmpimage.close
      File.unlink(path)
      File.rename(tmpimage.path, path)
    end
  end
end

def hello
  puts "hello world"
end
