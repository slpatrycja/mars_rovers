# frozen_string_literal: true

require_relative '../types'

class CommandsSet < Dry::Struct
  attribute :value, Types::String.constrained(format: /\A[LRM\s]+\z/i)

  def in_array
    value.delete(' ').split('')
  end
end
