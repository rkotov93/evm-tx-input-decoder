# frozen_string_literal: true

module EvmTxInput
  # A class containing a set of helpers to encode human-readable values
  # to binary transactions input data
  class Encoder
    class << self
      # Encodes function, types and arguments into binary input data
      #
      # @param function_name [String] the name of calling smart contract function, e.g. `transfer`
      # @param types [Array<String>] list of argument types, e.g. `['address', 'uint256']`
      # @param types [Array<String>] list of arguments, e.g. `['0x21a31ee1afc51d94c2efccaa2092ad1028285549', 100000]`
      # @return [String] binary representation of input data
      def encode_input(function_name, types = [], args = [])
        encoded_function_signature = encode_function_signature(function_name, types)
        encoded_params = encode_parameters(types, args)

        "0x#{encoded_function_signature}#{encoded_params}"
      end

      # Encodes function into binary representation (first 8 symbols at input data)
      #
      # @param function_name [String] the name of calling smart contract function, e.g. `transfer`
      # @param types [Array<String>] list of argument types, e.g. `['address', 'uint256']`
      # @return [String] binary representation of function
      def encode_function_signature(function_name, types = [])
        function_signature = "#{function_name}(#{types.join(",")})"
        Eth::Util.bin_to_hex(Eth::Util.keccak256(function_signature)[0...4])
      end

      # Encodes arguments into binary input data
      #
      # @param types [Array<String>] list of argument types, e.g. `['address', 'uint256']`
      # @param types [Array<String>] list of arguments, e.g. `['0x21a31ee1afc51d94c2efccaa2092ad1028285549', 100000]`
      # @return [String] binary representation of arguments
      def encode_parameters(types = [], args = [])
        Eth::Abi.encode(types, args).unpack1('H*')
      end
    end
  end
end
