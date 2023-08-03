# frozen_string_literal: true

module EvmTx
  # Represents decoded smart contract function arguments
  #
  # @attr_reader name [String] name of function argument
  # @attr_reader type [String] type of function argument
  # @attr_reader value [String, Integer] value of function argument
  class Argument
    attr_reader :name, :type, :value

    def initialize(name, type, value)
      @name = name
      @type = type
      @value = value
    end
  end
end
