puts "Setting up rspec ...".yellow.bold

remove_dir 'test'
copy_static_file 'spec/spec_helper.rb'