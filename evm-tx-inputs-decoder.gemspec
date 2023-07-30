# frozen_string_literal: true

require_relative 'lib/evm_tx/version'

Gem::Specification.new do |spec|
  spec.name = 'evm-tx-inputs-decoder'
  spec.version = EvmTx::VERSION
  spec.authors = ['Ruslan Kotov']
  spec.email = ['rkotov93@gmail.com']

  spec.summary = 'A simple gem that helps decoding and encoding transactions input data'\
                 'for EVM based blockchains likeEthereum and Tron.'
  # spec.description = 'Write a longer description or delete this line.'
  spec.homepage = 'https://github.com/rkotov93/evm-tx-inputs-decoder'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  # spec.metadata['allowed_push_host'] = "Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/rkotov93/evm-tx-inputs-decoder'
  spec.metadata['changelog_uri'] = 'https://github.com/rkotov93/evm-tx-inputs-decoder/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'eth', '~> 0.5'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
