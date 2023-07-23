# frozen_string_literal: true

RSpec.describe Evm::Tx::Decoder do
  it "has a version number" do
    expect(Evm::Tx::Decoder::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
