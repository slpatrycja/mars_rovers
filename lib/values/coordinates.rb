# frozen_string_literal: true

require_relative '../types'
require_relative '../dirs'

class Coordinates < Dry::Struct
  attribute :x, Types::Coercible::Integer
  attribute :max_x, Types::Coercible::Integer
  attribute :y, Types::Coercible::Integer
  attribute :max_y, Types::Coercible::Integer
  attribute :dir, Types::String.enum(*Dirs::ALL_DIRS)

  def valid?
    (0..max_x).include?(x) && (0..max_y).include?(y)
  end
end
