# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack-jsonp-tools}
  s.version = "0.3.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jacek Becela"]
  s.date = %q{2010-06-29}
  s.description = %q{A collection of rack middlewares helping you add JSONP to your app}
  s.email = %q{jacek.becela@gmail.com}
  s.files = [
    ".gitignore",
     "Rakefile",
     "Readme",
     "VERSION",
     "lib/rack/jsonp/callback.rb",
     "lib/rack/jsonp/method_override.rb",
     "lib/rack/jsonp/status_wrapper.rb",
     "rack-jsonp-tools.gemspec",
     "test/callback_test.rb",
     "test/method_override_test.rb",
     "test/status_wrapper_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/ncr/rack-jsonp-tools}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Add JSONP support to your app in less than 3 minutes! Method Override included for free!}
  s.test_files = [
    "test/callback_test.rb",
     "test/method_override_test.rb",
     "test/status_wrapper_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 0"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 2.0"])
    else
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<rack-test>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 2.0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<rack-test>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 2.0"])
  end
end

