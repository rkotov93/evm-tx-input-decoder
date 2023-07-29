# frozen_string_literal: true

module EvmTx
  class Decoder
    class << self
      def decode_input(data, abi)
        data = data[2..] if data.start_with?('0x')
        definitions = method_definitions_by_id(abi)

        method_id = data[0...8]
        definition = definitions[method_id]
        return unless definition

        args_data = data[8..]
        arg_types = definition['inputs'].map { |input| input['type'] }
        args = Eth::Abi.decode(arg_types, args_data)

        {
          id: method_id,
          name: definition['name'],
          arguments: args
        }
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
