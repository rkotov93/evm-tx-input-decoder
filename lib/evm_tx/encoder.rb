# frozen_string_literal: true

module EvmTx
  class Encoder
    class << self
      def encode_input(function_name, types = [], args = [])
        encoded_function_signature = encode_function_signature(function_name, types)
        encoded_params = encode_parameters(types, args)

        "0x#{encoded_function_signature}#{encoded_params}"
      end

      def encode_function_signature(function_name, types = [])
        function_signature = "#{function_name}(#{types.join(",")})"
        Eth::Util.bin_to_hex(Eth::Util.keccak256(function_signature)[0...4])
      end

      def encode_parameters(types = [], args = [])
        Eth::Abi.encode(types, args).unpack1('H*')
      end
    end
  end
end
