# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mitten}
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tomohiro, TAIRA"]
  s.date = %q{2010-04-26}
  s.description = %q{Mitten is A Ruby IRC Bot Pluggable Framework}
  s.email = %q{tomohiro.t@gmail.com}
  s.executables = ["mittend", "mitten"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/mitten",
     "bin/mittend",
     "configs/example_environment.yaml",
     "configs/time_call.yaml",
     "configs/twitter_bot.yaml",
     "example/sample.rb",
     "lib/mitten.rb",
     "lib/plugin.rb",
     "lib/utils.rb",
     "mitten.gemspec",
     "plugins/amazon_search.rb",
     "plugins/bmi.rb",
     "plugins/codepad.rb",
     "plugins/fortune.rb",
     "plugins/gasoline.rb",
     "plugins/gmail.rb",
     "plugins/google_profile.rb",
     "plugins/google_transit.rb",
     "plugins/google_weather.rb",
     "plugins/holoscope.rb",
     "plugins/loo_holoscope.rb",
     "plugins/mixi_voice.rb",
     "plugins/nanapi.rb",
     "plugins/newspaper_headlines.rb",
     "plugins/openpne_new_diary_check.rb",
     "plugins/ramen.rb",
     "plugins/rate.rb",
     "plugins/screen_time_search.rb",
     "plugins/time_call.rb",
     "plugins/tweet.rb",
     "plugins/twitter_bot.rb",
     "plugins/typhoon.rb",
     "plugins/uri_shorten.rb",
     "spec/mitten_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://rubygems.org/gems/mitten}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{IRC Bot Framework}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/mitten_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<net-irc>, [">= 0.0.9"])
      s.add_runtime_dependency(%q<daemons>, [">= 1.0.10"])
      s.add_runtime_dependency(%q<json_pure>, [">= 1.2.0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<rake>, [">= 0.8.7"])
    else
      s.add_dependency(%q<net-irc>, [">= 0.0.9"])
      s.add_dependency(%q<daemons>, [">= 1.0.10"])
      s.add_dependency(%q<json_pure>, [">= 1.2.0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<rake>, [">= 0.8.7"])
    end
  else
    s.add_dependency(%q<net-irc>, [">= 0.0.9"])
    s.add_dependency(%q<daemons>, [">= 1.0.10"])
    s.add_dependency(%q<json_pure>, [">= 1.2.0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<rake>, [">= 0.8.7"])
  end
end

