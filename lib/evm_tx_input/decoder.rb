# frozen_string_literal: true

module EvmTxInput
  # A class containing a set of helpers to decode transactions input data
  # into human-readable values by provided contract's ABI
  #
  # @attr_reader abi [Hash] parsed contract ABI
  # @attr_reader method_definition [Hash] parsed contract ABI
  class Decoder
    attr_reader :abi, :method_definitions

    # Constructor of EvmTxInput::Decoder
    #
    # @param abi [Array] parsed contract ABI
    def initialize(abi = [])
      @abi = abi
      @method_definitions = method_definitions_by_id(abi)
    end

    # Decodes transaction input data
    #
    # @param input_data [String] binary encoded input data from transaction
    # @return [EvmTxInput::Function]
    def decode_input(input_data)
      input_data = input_data[2..] if input_data.start_with?('0x')
      method_id = input_data[0...8]
      definition = method_definitions[method_id]
      raise Error, "ABI does not contain method with #{method_id} ID" unless definition

      Function.new(method_id, definition['name'], extract_arguments(input_data, definition))
    end

    private

    def method_definitions_by_id(abi)
      abi.each_with_object({}) do |method_definition, obj|
        type = method_definition['type']
        next if type == 'event'

        method_id = calculate_method_id(method_definition)
        obj[method_id] = method_definition
      end
    end

    def calculate_method_id(method_definition)
      function_name = method_definition['name']
      arg_types = method_definition['inputs'].map { |input| input['type'] }.join(',')
      function_signature = "#{function_name}(#{arg_types})"

      Eth::Util.bin_to_hex(Eth::Util.keccak256(function_signature)[0...4])
    end

    def extract_arguments(input_data, definition)
      args_data = input_data[8..]
      arg_types = definition['inputs'].map { |input| input['type'] }
      arg_values = Eth::Abi.decode(arg_types, args_data)

      definition['inputs'].map.with_index do |input, i|
        Argument.new(input['name'], input['type'], arg_values[i])
      end
    end
  end
end
