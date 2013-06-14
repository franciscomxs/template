puts "Setting up usefull gems ... ".yellow.bold

css_framework = ''

copy_static_file 'Gemfile'

if yes?("want to use some css framework? (yes/no)".bold)
  answer = ask("which one do you want to use? (1) Twitter Bootstrap OR (2) Zurb Foundation")
  case answer
  when "1"
    puts "Bootstrap choosen".yellow.bold
    css_framework = 'bootstrap'
    gem 'bootstrap-sass', group: :assets
    run 'bundle install --without production'
    in_root do
      inject_into_file 'app/assets/javascripts/application.js', "
//= require bootstrap", { after: "//= require jquery_ujs", verbose: false }
      
      inject_into_file 'app/assets/stylesheets/shared/application.css.scss', "
//= require bootstrap", { after: "//= require_tree .", verbose: false }
    end
  when "2"
    puts "Foundation choosen".yellow.bold
    css_framework = 'foundation'
    gem 'zurb-foundation', group: :assets, :git => 'git@github.com:zurb/foundation.git'
    gem 'compass'
    run 'bundle install --without production'
    generate 'foundation:install'
  else
    puts "Fuck you. I said 1 OR 2!!!".yellow.bold
  end
else
  run 'bundle install --without production'
end


generate("responders:install")


if yes?("want to use simple_form? (yes/no)".bold)
  unless css_framework.empty?
    generate("simple_form:install --#{css_framework}")
  else
    generate("simple_form:install")
  end
end


if yes?("want to use devise? (yes/no)".bold)

  generate("devise:install")
  model_name = ask("What would you like the user model to be called? [user]")
  model_name = "user" if model_name.blank?
  generate("devise", model_name)

    in_root do
      inject_into_file 'config/routes.rb', ", controllers: { sessions: 'admin/sessions' }, path_names: { sign_up: 'register' }", { after: model_name.pluralize, verbose: false }
    end

  copy_static_directory "app/views/devise"
  copy_static_directory "app/controllers/admin"
end