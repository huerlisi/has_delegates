# coding: utf-8
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

begin
  GEM = "has_delegates"
  AUTHOR = "Simon Hürlimann"
  EMAIL = "simon.huerlimann@cyt.ch"
  SUMMARY = "Rails plugin/gem providing enhanced sub-model delegation to models."
  HOMEPAGE = "http://github.com/huerlisi/has_delegates/tree/master"
  
  gem 'jeweler', '>= 1.0.0'
  require 'jeweler'
  
  Jeweler::Tasks.new do |s|
    s.name = GEM
    s.summary = SUMMARY
    s.email = EMAIL
    s.homepage = HOMEPAGE
    s.description = SUMMARY
    s.author = AUTHOR
    
    s.require_path = 'lib'
    s.files = %w(MIT-LICENSE README Rakefile) + Dir.glob("{lib,test,rails}/**/*")
    
    # Runtime dependencies: When installing has_delegates these will be checked if they are installed.
    # Will be offered to install these if they are not already installed.
    s.add_dependency 'activesupport', '>= 2.3.0'
    s.add_dependency 'actionpack', '>= 2.3.0'
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "[has_delegates:] Jeweler - or one of its dependencies - is not available. Install it with: sudo gem install jeweler -s http://gemcutter.org"
end

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the has_delegates plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the has_delegates plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'HasDelegates'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
