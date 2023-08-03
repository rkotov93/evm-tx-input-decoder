# frozen_string_literal: true

require 'eth'

require_relative 'evm_tx/version'
require_relative 'evm_tx/decoder'
require_relative 'evm_tx/encoder'
require_relative 'evm_tx/function'
require_relative 'evm_tx/argument'
require_relative 'evm_tx/error'

module EvmTx
  class Error < StandardError; end
end
