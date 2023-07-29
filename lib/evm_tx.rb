# frozen_string_literal: true

require_relative 'evm_tx/version'
require_relative 'evm_tx/decoder'
require_relative 'evm_tx/encoder'

module EvmTx
  class Error < StandardError; end
end
