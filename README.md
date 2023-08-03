# EVM Transactions Input Decoder

This is a simple gem that helps decoding and encoding transactions input data for EVM based blockchains like Ethereum and Tron.

## Installation
Run
```bash
gem install evm-tx-input-decoder
```
or add
```ruby
gem 'evm-tx-input-decoder', require: 'evm_tx_input'
```
to your Gemfile.

## Usage

### Decoding
Let's consider decoding process by example [USDT transaction](https://etherscan.io/tx/0x93ae1b191189aa27833b65f3668ae7704f9b7d9badabf4a9a16e53d84e1a3472) in an Ethereum blockchain.

The input data is `0xa9059cbb00000000000000000000000003cb76e200ba785f6008c12933aa3640536d2011000000000000000000000000000000000000000000000000000000a083712e00`, which can be found in `More details` section.

The USDT token ABI can be found by [this url](http://api.etherscan.io/api?module=contract&action=getabi&address=0xdac17f958d2ee523a2206206994597c13d831ec7&format=raw)

```ruby
require 'evm_tx'

json = URI.open('http://api.etherscan.io/api?module=contract&action=getabi&address=0xdac17f958d2ee523a2206206994597c13d831ec7&format=raw') { |file| jsonfile.read }
abi = JSON.parse(json)
input = '0xa9059cbb00000000000000000000000003cb76e200ba785f6008c12933aa3640536d2011000000000000000000000000000000000000000000000000000000a083712e00'

function = EvmTxInput::Decoder.new(abi).decode_input(input)
function.id #=> "a9059cbb"
function.name #=> "transfer"
function.arguments
# [#<EvmTxInput::Argument:0x00000001107ffa60 @name="_to", @type="address", @value="0x03cb76e200ba785f6008c12933aa3640536d2011">,
#  #<EvmTxInput::Argument:0x00000001107ffa10 @name="_value", @type="uint256", @value=689400000000>]
```

### Encoding
Following decoding procedure let's encode the previous result.

```ruby
require 'evm_tx'

function_name = 'transfer'
types = %w[address uint256]
args = ['0x03cb76e200ba785f6008c12933aa3640536d2011', 689400000000]
EvmTxInput::Encoder.encode_input(function_name, types, args)
#=> "0xa9059cbb00000000000000000000000003cb76e200ba785f6008c12933aa3640536d2011000000000000000000000000000000000000000000000000000000a083712e00"
```

For more details read the [documentation](https://rubydoc.info/github/rkotov93/evm-tx-input-decoder/main/EvmTx).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rkotov93/evm-tx-input-decoder.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
