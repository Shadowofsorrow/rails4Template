# \===========-*-*-*-=========== [Git Setup] ===========-*-*-*-===========/

def git(commands={})
  if commands.is_a?(Symbol)
    run "git #{commands}"
  else
    commands.each do |cmd, options|
      run "git #{cmd} #{options}"
    end
  end
end

# \===========-*-*-*-=========== [Initial Setup] ===========-*-*-*-===========/

@after_bundler = []
def after_bundler(&block)
  @after_bundler << block
end

# \===========-*-*-*-=========== [Append Gem] ===========-*-*-*-===========/

gem "bootstrap-sass", ">= 3.3.5.1"
gem "pry-rails", ">= 0.3.4"
gem "pry-byebug", ">= 3.2.0"
gem "puma", ">= 2.13.4"
gem "redcarpet", ">= 3.3.2"

# \=========================\ [Testing Gem] /=========================/

gem_group :test do
  gem "minitest-rails"
  gem "jasmine-rails"
end

# \===========-*-*-*-============= [Cucumber] =============-*-*-*-===========/

gem_group :test, :development do
  gem 'cucumber-rails', :require => false
  gem 'capybara', '>= 2.5.0'
end
after_bundler do
  generate "cucumber:install"
end

# \===========-*-*-*-============= [Devise] ==============-*-*-*-===========/

gem 'devise', '>= 3.5.1'

after_bundler do
  generate 'devise:install'
  generate 'devise user'
end

# \===========-*-*-*-============== [Haml] ==============-*-*-*-===========/

gem 'haml', '>= 4.0.7'
gem 'haml-rails', '>= 0.9.0'


# \===========-*-*-*-============ [Mongoid] ============-*-*-*-===========/

gem 'bson_ext'
gem 'mongoid', '>= 5.0.0.rc0'

after_bundler do
  generate 'mongoid:config'
end

# \===========-*-*-*-=========== [Miscelanous] ===========-*-*-*-===========/

environment "config.sass.preferred_syntax = :sass"

# -*===========================\  [Excecution]  /===========================*-

run "ren README.rdoc Readme.md"
remove_file "config/database.yml"
run "html2haml app/views/layouts/application.html.erb >> app/views/layouts/application.html.haml"
remove_file  "app/views/layouts/application.html.erb"
append_file '.gitignore', <<-END
.DS_Store
/config/mongoid.yml
/db/schema.rb
/log
/tmp
END
append_file 'config.ru', <<-PUMA
#\\-s puma
PUMA

# TODO: Adding Git Repository And Commit the changes...

after_bundle do
  git :init
  git add: '.'
  git commit: '-m "Started up the App"'
end