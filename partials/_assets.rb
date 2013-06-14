puts "Setting up assets ... ".yellow.bold

run 'rm -rf app/assets/stylesheets'

copy_static_directory "app/assets/stylesheets"

run 'rm -rf app/assets/javascripts'

copy_static_directory "app/assets/javascripts"

in_root do
  inject_into_file 'config/environments/production.rb', "
  config.assets.precompile += %w( public/application admin/application devise/application )", { after: "config.assets.precompile += %w( search.js )", verbose: false }
end