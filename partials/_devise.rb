if yes?("want to use devise? (yes/no)".bold)

  generate("devise:install")
  model_name = ask("What would you like the user model to be called? [user]")
  model_name = "user" if model_name.blank?
  generate("devise", model_name)

    in_root do
      inject_into_file 'config/routes.rb', ",
    controllers: {
      omniauth_callbacks: 'auth/omniauth_callbacks',
      sessions: 'auth/sessions',
      registrations: 'auth/registrations'
    },
    path_names: {
      sign_up: 'register'
    }", { after: model_name.pluralize, verbose: false }
    end

  copy_static_directory "app/views/devise"
  copy_static_directory "app/controllers/admin"
  copy_static_directory "app/controllers/auth"
end