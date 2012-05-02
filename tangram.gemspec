$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tangram/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tangram"
  s.version     = Tangram::VERSION
  s.authors     = ["Dominik Guzei"]
  s.email       = ["dominik.guzei@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "A modular content editor written in CoffeeScript."
  s.description = "A modular content editor for CMS-Systems as replacement for traditional (horrible) rich text editors."

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").select{|f| f =~ /^bin/}
  s.require_path = 'lib'

  s.add_dependency "rails", "~> 3.2.3"
  s.add_runtime_dependency "embient"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "coffee-rails"
  s.add_development_dependency "jasminerice"
end
