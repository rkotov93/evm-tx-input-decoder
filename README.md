# EVM Transactions Imput Decoder

This is a simple gem that helps decoding and encoding transactions input data for EVM based blockchains like Ethereum and Tron.

## Installation

gem 'emv-tx-inputs-decoder'

## Usage

### Decoding
```ruby
input = '0xa9059cbb00000000000000000000000003cb76e200ba785f6008c12933aa3640536d2011000000000000000000000000000000000000000000000000000000a083712e00'
EmvTx::Decoder.new(abi).decode_input(input)
```

### Encoding
```ruby
types = %w[address uint256]
args = ['0x03cb76e200ba785f6008c12933aa3640536d2011', 10000]
EvmTx::Encoder.encode_parameters(types, args)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rkotov93/evm-tx-inputs-decoder.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
