require 'rubygems'
require 'rake/gempackagetask'
require 'spec/rake/spectask'
require 'merb-core/version'
require 'merb-core/test/tasks/spectasks'
require 'merb-core/tasks/merb_rake_helper'

NAME = "feather-slice"
AUTHOR = "Michael Murray"
EMAIL = "sudothinker@gmail.com"
HOMEPAGE = "http://featherblog.org/"
SUMMARY = "Merb Slice that provides feather blog in slice form"
GEM_VERSION = "0.9.4"

spec = Gem::Specification.new do |s|
  s.rubyforge_project = 'feather-slice'
  s.name = NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.add_dependency('merb-slices', '>= 0.9.4')
  s.require_path = 'lib'
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,spec,app,public,stubs}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Install FeatherSlice as a gem"
task :install => [:package] do
  sh %{#{sudo} gem install pkg/#{NAME}-#{GEM_VERSION} --no-update-sources}
end

namespace :jruby do

  desc "Run :package and install the resulting .gem with jruby"
  task :install => :package do
    sh %{#{sudo} jruby -S gem install #{install_home} pkg/#{NAME}-#{GEM_VERSION}.gem --no-rdoc --no-ri}
  end
  
end