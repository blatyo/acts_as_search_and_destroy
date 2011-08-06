# Provide a simple gemspec so you can easily use your
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "acts_as_search_and_destroy"
  s.summary = "Insert ActsAsSearchAndDestroy summary."
  s.description = "Insert ActsAsSearchAndDestroy description."
  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  s.version = "0.0.1"
end