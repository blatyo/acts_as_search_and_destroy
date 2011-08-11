# Provide a simple gemspec so you can easily use your
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "acts_as_search_and_destroy"
  s.summary = "Index your models with IndexTank."
  s.description = "Index your models with IndexTank."
  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]
  s.version = "0.0.1"

  s.add_dependency 'indextank'
  s.add_development_dependency 'rspec-rails'
end