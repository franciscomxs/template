puts "Setting up generators ... ".yellow.bold

run 'mkdir -p lib/templates/rails/scaffold_controller/'
copy_static_file 'lib/templates/rails/scaffold_controller/controller.rb'

generators = <<GENERATORS


    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, views: false, helper: false, dir: 'spec/factories'
      g.helper false
      g.helper_specs false
      g.view_specs false
      g.assets false
      g.stylesheets false
      g.integration_tool false
      g.template_engine :slim
    end

    config.assets.initialize_on_precompile = false

GENERATORS

letter_opener_config = <<LETTER_OPENER


  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
LETTER_OPENER

in_root do
  inject_into_file 'config/application.rb', generators, { after: "Rails::Application", verbose: false }
  inject_into_file 'config/environments/development.rb', letter_opener_config, { after: "config.assets.debug = true", verbose: false }
end