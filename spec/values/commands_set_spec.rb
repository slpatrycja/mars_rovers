# frozen_string_literal: true

require_relative '../../lib/values/commands_set.rb'

RSpec.describe CommandsSet do
  describe 'attributes' do
    it { expect(described_class).to have_attribute(:value, Types::String.constrained(format: /\A[LRM]+\z/i)) }
  end

  describe '#in_array' do
    let(:value) { 'LMLMLMLMM' }

    subject { described_class.new(value: value).in_array }

    it 'returns array of single command letters' do
      expect(subject).to eq %w[L M L M L M L M M]
    end
  end
end
