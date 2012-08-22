Gem::Specification.new do |s|
  s.name = 'appygram-exception_notification'
  s.version = '0.0.1'
  s.authors = ["GoGoCarl"]
  s.date = %q{2012-08-22}
  s.summary = 'Exception notification by appygram for Rails apps'
  s.email = ['carl.scott@solertium.com']
  s.files = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.add_runtime_dependency 'rails'
  s.add_runtime_dependency 'exception_notification'
end
