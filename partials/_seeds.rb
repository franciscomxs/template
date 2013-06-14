puts "Setting special seeds for each environment".yellow.bold
copy_static_file 'db/seeds.rb'
copy_static_directory 'db/seeds'