# puts "Setting up database ... ".yellow.bold

if yes?("Prepare database? (yes/no)".yellow.bold) 
  in_root do
    run "rake db:create db:migrate db:test:prepare"
  end
end

puts "Done!".yellow.bold