# frozen_string_literal: true

module EvmTx
  class Encoder
    class << self
      def encode_inputs(types, args)
        Eth::Abi.encode(types, args).unpack1('H*')
      end
    end
  end
end
