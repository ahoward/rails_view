## rails_view.gemspec
#

Gem::Specification::new do |spec|
  spec.name = "rails_view"
  spec.version = "2.0.0"
  spec.platform = Gem::Platform::RUBY
  spec.summary = "rails_view"
  spec.description = "render views from anywhere. even without a controller context"
  spec.license = "same as ruby's"

  spec.files =
["README.md",
 "Rakefile",
 "lib",
 "lib/rails_view.rb",
 "rails_view.gemspec",
 "test",
 "test/rails_view_test.rb",
 "test/testing.rb"]

  spec.executables = []
  
  spec.require_path = "lib"

  spec.test_files = nil

### spec.add_dependency 'lib', '>= version'
#### spec.add_dependency 'map'

  spec.extensions.push(*[])

  spec.rubyforge_project = "codeforpeople"
  spec.author = "Ara T. Howard"
  spec.email = "ara.t.howard@gmail.com"
  spec.homepage = "https://github.com/ahoward/rails_view"
end
