require "rake/testtask"
 
task :test do
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.test_files = FileList['test/*_test.rb']
    t.verbose = true
  end
end
 
task :default => :test
 
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rack-jsonp-tools"
    gem.summary = "Add JSONP support to your app in less than 3 minutes! Method Override included for free!"
    gem.description = "A collection of rack middlewares helping you add JSONP to your app"
    gem.email = "jacek.becela@gmail.com"
    gem.homepage = "http://github.com/ncr/rack-jsonp-tools"
    gem.authors = ["Jacek Becela"]
    gem.add_dependency "rack"
    gem.add_development_dependency "rack-test"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
