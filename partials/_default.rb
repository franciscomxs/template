puts "Default configs ... ".yellow.bold

copy_static_file 'config/unicorn.rb'
copy_static_file 'Procfile'
copy_static_file 'public/favicon.ico'

route "root to: 'pages#index'"

in_root do
  inject_into_file 'config/routes.rb', "
  namespace :admin do
    root to: 'pages#index'
  end", { after: "root to: 'pages#index'", verbose: false }
end

# Layouts
copy_static_file 'app/views/layouts/application.html.slim'
copy_static_file 'app/views/layouts/admin.html.slim'
copy_static_file 'app/views/layouts/devise.html.slim'
copy_static_directory 'app/views/layouts/public/'
copy_static_directory 'app/views/layouts/admin/'
copy_static_file 'app/views/layouts/_mobile.html.erb'
copy_static_file 'app/views/layouts/_analytics.html.erb'

# Root View
copy_static_directory 'app/views/pages'
copy_static_directory 'app/views/admin/pages'
copy_static_directory 'app/controllers/admin/'
copy_static_file 'app/controllers/pages_controller.rb'