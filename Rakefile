require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "e4u-encode"
    gem.summary = %Q{Emoji Converter using E4U}
    gem.description = %Q{Emoji Converter using E4U}
    gem.email = "fistfvck@gmail.com"
    gem.homepage = "http://github.com/fistfvck/e4u-encode"
    gem.authors = ["fistfvck"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "e4u", ">= 0.0.4"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "e4u-encode #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc "update misc datas"
task :update => %w(update:docomo update:google update:kddi update:softbank)
load 'tasks/tables.rake'
