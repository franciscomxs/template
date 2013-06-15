puts "Setting up usefull gems ... ".yellow.bold

copy_static_file 'Gemfile'

css_framework = ''

if yes?("want to use some css framework? (yes/no)".bold)
  answer = ask("which one do you want to use? (1) Twitter Bootstrap OR (2) Zurb Foundation")
  case answer
  when "1"
    puts "Bootstrap choosen".yellow.bold
    css_framework = 'bootstrap'

    gem 'bootstrap-sass', group: :assets, git: 'git@github.com:thomas-mcdonald/bootstrap-sass.git'

    in_root do
      inject_into_file 'app/assets/javascripts/application.js', "
//= require bootstrap", { after: "//= require jquery_ujs", verbose: false }
      
      inject_into_file 'app/assets/stylesheets/shared/application.css.scss', "
//= require bootstrap", { after: "//= require_tree .", verbose: false }
      
    end
  when "2"
    puts "Foundation choosen".yellow.bold
    css_framework = 'foundation'
    gem 'zurb-foundation', group: :assets, git: 'git@github.com:zurb/foundation.git'
    gem 'compass'
    run 'bundle install --without production'
    generate 'foundation:install'
  else
    puts "Fuck you. I said 1 OR 2!!!".yellow.bold
  end
end

run 'bundle install --without production'

if yes?("want to use simple_form? (yes/no)".bold)
  unless css_framework.empty?
    generate("simple_form:install --#{css_framework}")
  else
    generate("simple_form:install")
  end
end

generate("responders:install")