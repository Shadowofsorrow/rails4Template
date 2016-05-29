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

# gem "bootstrap-sass"
gem "pry-rails"
gem "pry-byebug"
gem "puma"
gem "redcarpet"

# \=========================\ [Testing Gem] /=========================/

gem_group :test do
  gem "minitest-rails"
  gem "jasmine-rails"
end

# \===========-*-*-*-============= [Cucumber] =============-*-*-*-===========/

gem_group :test, :development do
  gem 'cucumber-rails', :require => false
  gem 'capybara'
end

# \===========-*-*-*-============= [Devise] ==============-*-*-*-===========/

gem 'devise'


# \===========-*-*-*-============== [Haml] ==============-*-*-*-===========/

gem 'haml-rails'


# \===========-*-*-*-============ [Mongoid] ============-*-*-*-===========/

gem 'bson_ext'
gem 'mongoid', '>= 1.5.3'


# \===========-*-*-*-=========== [Miscelanous] ===========-*-*-*-===========/

environment "config.sass.preferred_syntax = :scss"

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

# -*===========================\  [Bundler]  /===========================*-

after_bundle do
  generate 'devise:install'
  generate 'devise user'
  generate "cucumber:install"
  generate 'mongoid:config'
  # Adding Git Repository And Commit the changes...
  git :init
  git add: '.'
  git commit: '-m "First Run"'
end