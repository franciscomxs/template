require "colored"

git :init

@template = File.expand_path(File.join(File.dirname(__FILE__)))
@partials = File.join(@template, 'partials')
@files = File.join(@template, 'files')

def copy_static_file(path)
  remove_file path
  file path, File.read(File.join(@files, path))
end

def copy_static_directory(path)
  directory "#{@files}/#{path}", path
end

def apply_partial(partial)
  apply "#{@partials}/_#{partial}.rb"
end

apply_partial :cleanup
apply_partial :default
apply_partial :generators
apply_partial :assets
apply_partial :gems
apply_partial :rspec
apply_partial :seeds
apply_partial :finish

git add: "."
git commit: "-m 'initial commit'"

def run_bundle
end