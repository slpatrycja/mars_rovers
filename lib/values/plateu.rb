# frozen_string_literal: true

require_relative '../types'

class Plateu < Dry::Struct
  attribute :x, Types::Coercible::Integer
  attribute :y, Types::Coercible::Integer
end
