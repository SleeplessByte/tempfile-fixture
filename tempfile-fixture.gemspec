
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tempfile/fixture/version'

Gem::Specification.new do |spec|
  spec.name          = 'tempfile-fixture'
  spec.version       = Tempfile::Fixture::VERSION
  spec.authors       = ['Derk-Jan Karrenbeld']
  spec.email         = ['derk-jan+github@karrenbeld.info']

  spec.license       = 'MIT'
  spec.summary       = 'Temporarily copy a file to a Tempfile, for testing'

  spec.metadata = {
    'bug_tracker_uri'   => 'https://github.com/SleeplessByte/tempfile-fixture/issues',
    'changelog_uri'     => 'https://github.com/SleeplessByte/tempfile-fixture/CHANGELOG.md',
    'homepage_uri'      => 'https://github.com/SleeplessByte/tempfile-fixture',
    'source_code_uri'   => 'https://github.com/SleeplessByte/tempfile-fixture'
  }

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata['allowed_push_host'] = 'https://gems.sleeplessbyte.technology'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
end
