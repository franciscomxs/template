puts "Removing unnecessary files ... ".yellow.bold

remove_file "README"
remove_file "app/assets/images/rails.png"
remove_file "app/views/layouts/application.html.erb"

inside "public" do
  remove_file "index.html"
  remove_file "favicon.ico"
  remove_file "robots.txt"
end