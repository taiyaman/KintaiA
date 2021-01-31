# -*- encoding: utf-8 -*-
# stub: rounding 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "rounding".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Brian Hempel".freeze]
  s.date = "2015-04-27"
  s.description = "Floor/nearest/ceiling rounding by arbitrary steps for Integers, Floats, Times, TimeWithZones, and DateTimes.".freeze
  s.email = ["plasticchicken@gmail.com".freeze]
  s.homepage = "https://github.com/brianhempel/rounding".freeze
  s.licenses = ["Public Domain".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Floor/nearest/ceiling rounding by arbitrary steps for Integers, Floats, Times, TimeWithZones, and DateTimes.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.6"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<activesupport>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
  end
end
