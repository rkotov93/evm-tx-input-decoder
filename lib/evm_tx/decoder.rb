# frozen_string_literal: true

require 'eth'

require_relative './function'
require_relative './argument'

module EvmTx
  class Decoder
    attr_reader :abi, :method_definitions

    def initialize(abi)
      @abi = abi
      @method_definitions = method_definitions_by_id(abi)
    end

    def decode_input(input_data)
      input_data = input_data[2..] if input_data.start_with?('0x')
      method_id = input_data[0...8]
      definition = method_definitions[method_id]
      return unless definition

      Function.new("0x#{method_id}", definition['name'], extreact_arguments(input_data, definition))
    end

    private

    def method_definitions_by_id(abi)
      abi.each_with_object({}) do |method_definition, obj|
        type = method_definition['type']
        next if %w[constructor event].include?(type)

        method_id = calculate_method_id(method_definition)
        obj[method_id] = method_definition
      end
    end

    def calculate_method_id(method_definition)
      function_name = method_definition['name']
      arg_types = method_definition['inputs'].map { |input| input['type'] }.join(',')
      signature = "#{function_name}(#{arg_types})"

      Eth::Util.bin_to_hex(Eth::Util.keccak256(signature)[0...4])
    end

    def extreact_arguments(input_data, definition)
      args_data = input_data[8..]
      arg_types = definition['inputs'].map { |input| input['type'] }
      arg_values = Eth::Abi.decode(arg_types, args_data)

      definition['inputs'].map.with_index do |input, i|
        Argument.new(input['name'], input['type'], arg_values[i])
      end
    end
  end
end
