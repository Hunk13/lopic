lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lopic/version'

Gem::Specification.new do |spec|
  spec.name          = 'lopic'
  spec.version       = Lopic::VERSION
  spec.authors       = ['Alexandr Kalinka']
  spec.email         = ['alex.kalinoff@gmail.com']

  spec.summary       = 'Lopic - Simple gem for get List Of PICtures on page'
  spec.description   = 'Simple gem for parsing websites. It get list of all images.'
  spec.homepage      = 'https://github.com/Hunk13/lopic'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 12.3'

  spec.add_dependency 'nokogiri', '~> 1.10', '>= 1.10.0'
  spec.add_dependency 'activesupport', '>= 5.1', '< 7.0'
end
