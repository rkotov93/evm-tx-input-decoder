# frozen_string_literal: true

RSpec.describe EvmTx::Encoder do
  describe '.encode_parameters' do
    subject(:encode_parameters) { described_class.encode_parameters(types, args) }

    cases = [
      [
        %w[address uint256],
        ['0x03cb76e200ba785f6008c12933aa3640536d2011', 689_400_000_000],
        '00000000000000000000000003cb76e200ba785f6008c12933aa3640536d2011'\
        '000000000000000000000000000000000000000000000000000000a083712e00'
      ],
      [
        %w[address address uint256],
        ['0x89960f47c5bf0126fb4d41755c8bdcb8c9368635', '0xec30d02f10353f8efc9601371f56e808751f396f', 1_432_650_801],
        '00000000000000000000000089960f47c5bf0126fb4d41755c8bdcb8c9368635000000000000000000000000ec30d02f'\
        '10353f8efc9601371f56e808751f396f0000000000000000000000000000000000000000000000000000000055648431'
      ]
    ]

    cases.each do |types, args, expected_result|
      context 'with provided types and args' do
        let(:types) { types }
        let(:args) { args }
        let(:expected_result) { expected_result }

        it { is_expected.to eq expected_result }
      end
    end
  end
end
