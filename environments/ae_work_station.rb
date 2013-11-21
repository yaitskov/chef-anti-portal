

# to run with chef-solo use:
# sudo chef-solo -E ae_work_station -c solo.rb -o 'recipe[infra::test]'
name "ae_work_station"
description "The development environment"
#cookbook_versions  "couchdb" => "= 11.0.0"
#default_attributes "infra" => { "dd" => "overriden dd message" }
default_attributes "dd" => " over dd message" 


#node.default.dd = "DD ????"
