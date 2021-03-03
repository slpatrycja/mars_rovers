# frozen_string_literal: true

require_relative '../../lib/values/plateu.rb'

RSpec.describe Plateu do
  describe 'attributes' do
    it { expect(described_class).to have_attribute(:x, Types::Coercible::Integer) }
    it { expect(described_class).to have_attribute(:y, Types::Coercible::Integer) }
  end
end
