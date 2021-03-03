# frozen_string_literal: true

require_relative '../../lib/values/coordinates.rb'

RSpec.describe Coordinates do
  describe 'attributes' do
    it { expect(described_class).to have_attribute(:x, Types::Coercible::Integer) }
    it { expect(described_class).to have_attribute(:y, Types::Coercible::Integer) }
    it { expect(described_class).to have_attribute(:max_x, Types::Coercible::Integer) }
    it { expect(described_class).to have_attribute(:max_y, Types::Coercible::Integer) }
    it { expect(described_class).to have_attribute(:dir, Types::String.enum('N', 'E', 'S', 'W')) }
  end

  describe '#valid?' do
    let(:x) { 1 }
    let(:y) { 1 }
    let(:max_x) { 2 }
    let(:max_y) { 2 }

    subject { described_class.new(x: x, max_x: max_x, y: y, max_y: max_y, dir: 'N').valid? }

    context 'when x and y are between 0 and maximum values' do
      it { is_expected.to eq true }
    end

    context 'when either x or y are out of expected range' do
      let(:x) { 3 }

      it { is_expected.to eq false }
    end
  end
end
