
require File.join(File.expand_path(File.dirname(__FILE__)), '../cookbooks/infra/libraries/file_utils.rb') 
# to run with chef-solo use:
# sudo chef-solo -E ae_work_station -c solo.rb -o 'recipe[infra::test]'
name "ae_work_station"
description "The development environment"
#cookbook_versions  "couchdb" => "= 11.0.0"
#default_attributes "infra" => { "dd" => "overriden dd message" }
default_attributes "dd" => " over dd message" 


default_attributes :lvirt => {
  :vmdefault => {
    :disk => {
      :size_mb => gbytes(8),
      :folder => '/home/libvirt/images',
      :template => '/home/libvirt/small-template.img'
    },
    :mem => 512 #megabytes
  },
  :vms => {
    :'chef-server' => {
      :disk => { :size_mb => gbytes(8) }
    },
    :n1 => {
      :disk => { :size_mb => gbytes(8) }
    }
  }
}


#node.default.dd = "DD ????"
