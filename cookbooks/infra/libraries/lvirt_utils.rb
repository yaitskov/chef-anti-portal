

def resize_raw_image(path,new_size_mb)
  tmpimage = Tempfile.new('resizing_' + File.basename(path), File.dirname(path))
  begin
    tmpimage.truncate(new_size_mb * 1024 * 1024)
    %x(virt-resize --expand /dev/sda1 #{path} #{tmpimage.path})
    if !$?.exitstatus
      tmpimage.close
      tmpimage.unlink
      raise "failed resize"
    else
      tmpimage.close
      File.unlink(path)
      File.rename(tmpimage.path, path)
    end
  end
end

def hello
  puts "hello world"
end
