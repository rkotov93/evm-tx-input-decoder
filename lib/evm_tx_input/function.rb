# frozen_string_literal: true

module EvmTxInput
  # Represent decoded smart contract function call
  #
  # @attr_reader id [String] first 8 symbols of transaction input data
  # @attr_reader name [String] name of smart contract function
  # @attr_reader arguments [Array<EvmTxInput::Argument>] a list of function arguments
  class Function
    attr_reader :id, :name, :arguments

    def initialize(id, name, arguments = [])
      @id = id
      @name = name
      @arguments = arguments
    end
  end
end
