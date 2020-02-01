lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sens_sms/version'

Gem::Specification.new do |spec|
  spec.name          = 'sens_sms'
  spec.version       = SensSms::VERSION
  spec.authors       = 'Penguin'
  spec.email         = 'say8425@gmail.com'
  spec.summary       = 'Sens SMS by Ncloud Sens'
  spec.description   = 'The gem is a wrapper for Ncloud Sens SMS.'
  spec.homepage      = 'https://github.com/say8425/sens_sms'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = 'https://github.com/say8425/sens_sms'
  spec.metadata['changelog_uri']     = 'https://github.com/say8425/sens_sms/blob/master/CHANGELOG.md'
  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'http', '~> 4.2'
  spec.add_dependency 'railties', '~> 5'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 0.76'
end
