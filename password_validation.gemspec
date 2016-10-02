require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'password_validation', 'version'))

Gem::Specification.new do |s|
  s.name         = 'password_validation'
  s.version      = PasswordValidation::VERSION
  s.date         = Time.now.strftime('%Y-%m-%d')
  s.summary      = 'Password Validation'
  s.description  = 'Provides validates :password for ActiveModel'
  s.authors      = ['Jarrett Colby']
  s.email        = 'jarrett@madebyhq.com'
  s.licenses     = ['MIT']
  s.files        = Dir.glob('lib/**/*')
  s.homepage     = 'https://github.com/jarrett/password_validation'
  
  s.add_runtime_dependency 'activemodel', '>= 4'
  
  # Will be the :development group in Bundler.
  s.add_development_dependency 'rake', '~> 10'
  s.add_development_dependency 'minitest', '>= 5.4.1', '~> 5'
  s.add_development_dependency 'minitest-reporters', '>= 1.0.5', '~> 1'
end