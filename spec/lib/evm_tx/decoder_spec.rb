# frozen_string_literal: true

require 'json'

RSpec.describe EvmTx::Decoder do
  describe '.decode_input' do
    subject(:decode_input) { described_class.decode_input(input_data, abi) }

    context 'with Ethereum transaction' do
      context 'with USDT contract' do
        let(:abi) { JSON.parse(File.read('spec/fixtures/abi/ethereum/usdt.json')) }

        context 'with `transfer` method' do
          # https://etherscan.io/tx/0x93ae1b191189aa27833b65f3668ae7704f9b7d9badabf4a9a16e53d84e1a3472
          let(:input_data) do
            '0xa9059cbb00000000000000000000000003cb76e200ba785f6008c12933aa3640536'\
            'd2011000000000000000000000000000000000000000000000000000000a083712e00'
          end
          let(:expected_result) do
            {
              id: '0xa9059cbb',
              name: 'transfer',
              arguments: match_array(
                [
                  have_attributes(name: '_to', type: 'address', value: '0x03cb76e200ba785f6008c12933aa3640536d2011'),
                  have_attributes(name: '_value', type: 'uint256', value: 689_400_000_000)
                ]
              )
            }
          end

          it { is_expected.to have_attributes expected_result }
        end

        context 'with `transferFrom` method' do
          # https://etherscan.io/tx/0x6838763e599df60276a9db24bc1614ff4b8517e7c4796f0a04ae85efbc3e9ca4
          let(:input_data) do
            '0x23b872dd00000000000000000000000089960f47c5bf0126fb4d41755c8bdcb8c9368635000000000000000000000000ec3'\
            '0d02f10353f8efc9601371f56e808751f396f0000000000000000000000000000000000000000000000000000000055648431'
          end
          let(:expected_result) do
            {
              id: '0x23b872dd',
              name: 'transferFrom',
              arguments: [
                have_attributes(name: '_from', type: 'address', value: '0x89960f47c5bf0126fb4d41755c8bdcb8c9368635'),
                have_attributes(name: '_to', type: 'address', value: '0xec30d02f10353f8efc9601371f56e808751f396f'),
                have_attributes(name: '_value', type: 'uint256', value: 1_432_650_801)
              ]
            }
          end

          it { is_expected.to have_attributes expected_result }
        end
      end
    end

    context 'with Tron transaction' do
      context 'with USDT contract' do
        let(:abi) { JSON.parse(File.read('spec/fixtures/abi/tron/usdt.json')) }

        context 'with `transfer` method' do
          # https://tronscan.org/#/transaction/5fbdd0e5e9307c84751a306d4ac6d0753e84d49b31d215c2c5a6577380f6cd58
          let(:input_data) do
            'a9059cbb000000000000000000000041241fa3a3f9fe4c812e7e633ebd238a23975e'\
            'f6160000000000000000000000000000000000000000000000000000000006d348b0'
          end
          let(:expected_result) do
            {
              id: '0xa9059cbb',
              name: 'transfer',
              arguments: match_array(
                [
                  have_attributes(name: '_to', type: 'address', value: '0x241fa3a3f9fe4c812e7e633ebd238a23975ef616'),
                  have_attributes(name: '_value', type: 'uint256', value: 114_510_000)
                ]
              )
            }
          end

          it { is_expected.to have_attributes expected_result }
        end

        context 'with `transferFrom` method' do
          # https://tronscan.org/#/transaction/c4fa42ab4345be8b9c8d12c8d8028824b937b9fe6e2c680916b0471fd748ec9f
          let(:input_data) do
            '23b872dd0000000000000000000000417d3835ed789d2696ba199de7e12b477eee750d2300000000000000000000004168c6'\
            '35cde4e47c93ab742e05eec4ec98ce2cd0d00000000000000000000000000000000000000000000000000000000000000000'
          end
          let(:expected_result) do
            {
              id: '0x23b872dd',
              name: 'transferFrom',
              arguments: [
                have_attributes(name: '_from', type: 'address', value: '0x7d3835ed789d2696ba199de7e12b477eee750d23'),
                have_attributes(name: '_to', type: 'address', value: '0x68c635cde4e47c93ab742e05eec4ec98ce2cd0d0'),
                have_attributes(name: '_value', type: 'uint256', value: 0)
              ]
            }
          end

          it { is_expected.to have_attributes expected_result }
        end
      end
    end
  end
end
