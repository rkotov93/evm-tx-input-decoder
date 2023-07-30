# frozen_string_literal: true

require 'eth'

require_relative './function'
require_relative './argument'

module EvmTx
  class Decoder
    class << self
      def decode_input(input_data, abi)
        input_data = input_data[2..] if input_data.start_with?('0x')
        definitions = method_definitions_by_id(abi)

        method_id = input_data[0...8]
        definition = definitions[method_id]
        return unless definition

        args_data = input_data[8..]
        arg_types = definition['inputs'].map { |input| input['type'] }
        arg_values = Eth::Abi.decode(arg_types, args_data)
        args = definition['inputs'].map.with_index do |input, i|
          Argument.new(input['name'], input['type'], arg_values[i])
        end

        Function.new("0x#{method_id}", definition['name'], args)
      end

      private

      def generate_method_id(definition)
        function_name = definition['name']
        arg_types = definition['inputs'].map { |input| input['type'] }.join(',')
        function = "#{function_name}(#{arg_types})"

        Eth::Util.bin_to_hex(Eth::Util.keccak256(function)[0...4])
      end

      def method_definitions_by_id(abi)
        abi.each_with_object({}) do |definition, obj|
          type = definition['type']
          next if %w[constructor event].include?(type)

          method_id = generate_method_id(definition)
          obj[method_id] = definition
        end
      end
    end
  end
end
