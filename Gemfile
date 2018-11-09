source 'https://rubygems.org' do
  gem 'rake'
  gem 'cocoapods', '1.5.3'
  gem 'xcpretty-travis-formatter'
  gem 'danger'
  gem 'danger-swiftlint'
  gem 'octokit', "~> 4.0"
  gem 'fastlane', "2.103.1"
  gem 'dotenv'
  gem 'rubyzip', "~> 1.2.2"
  gem "byebug"
  gem 'cocoapods-repo-update', :path => "./cocoapods-repo-update"
end

plugins_path = File.join(File.dirname(__FILE__), 'Scripts/fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
