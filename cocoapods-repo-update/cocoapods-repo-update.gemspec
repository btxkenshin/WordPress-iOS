# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-repo-update/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = CocoapodsRepoUpdate::NAME
  spec.version       = CocoapodsRepoUpdate::VERSION
  spec.authors       = ['James Treanor']
  spec.email         = ['jtreanor3@gmail.com']
  spec.description   = %q{A CocoaPods plugin that updates your specs repos when needed.}
  spec.summary       = %q{cocoapods-repo-update is a CocoaPods plugin that checks your dependencies when your run `pod install` and updates the local specs repos if needed}
  spec.homepage      = 'https://github.com/wordpress-mobile/cocoapods-repo-update'
  spec.license       = 'GPLv2'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
