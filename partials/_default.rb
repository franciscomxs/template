puts "Default configs ... ".yellow.bold

copy_static_file 'config/unicorn.rb'
copy_static_file 'Procfile'
copy_static_file 'public/favicon.ico'

generate('controller pages index')
generate('controller admin::pages index')

route "root to: 'pages#index'"

in_root do
  inject_into_file 'config/routes.rb', "
  namespace :admin do
    root to: 'pages#index'
  end", { after: "root to: 'pages#index'", verbose: false }

  inject_into_file 'app/controllers/admin/pages_controller.rb', "Admin::", { before: "ApplicationController", verbose: false }
end

copy_static_file '.gitignore'

# Layouts
run 'mkdir -p app/views/layouts/public'
run 'mkdir -p app/views/layouts/admin'

### Public
copy_static_file 'app/views/layouts/application.html.slim'
copy_static_file 'app/views/layouts/public/_navbar.html.slim'

### Admin
copy_static_file 'app/views/layouts/admin.html.slim'
copy_static_file 'app/views/layouts/admin/_navbar.html.slim'

### Devise
copy_static_file 'app/views/layouts/devise.html.slim'

### Shared files
copy_static_file 'app/views/layouts/_mobile.html.erb'
copy_static_file 'app/views/layouts/_analytics.html.erb'