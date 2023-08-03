# frozen_string_literal: true

require 'eth'

require_relative 'evm_tx_input/version'
require_relative 'evm_tx_input/decoder'
require_relative 'evm_tx_input/encoder'
require_relative 'evm_tx_input/function'
require_relative 'evm_tx_input/argument'
require_relative 'evm_tx_input/error'

module EvmTxInput
  class Error < StandardError; end
end
