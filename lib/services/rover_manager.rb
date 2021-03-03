# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require_relative '../types'
require_relative '../models/rover'
require_relative '../values/coordinates'
require_relative '../values/commands_set'
require_relative '../values/plateu'

class RoverManager
  extend Dry::Initializer

  include Dry::Monads[:result, :try]
  include Dry::Monads::Do.for(:call)

  option :coordinates_string, Types::String, reader: :private
  option :commands_string, Types::String, reader: :private
  option :plateu, Types.Instance(Plateu), reader: :private

  def call
    coordinates = yield set_coordinates
    yield validate_coordinates(coordinates)
    commands = yield set_commands

    rover = Rover.new(x: coordinates.x, y: coordinates.y, dir: coordinates.dir, plateu: plateu)

    commands.in_array.each do |command|
      rover.process(command)
    end

    Success(rover.current_position)
  end

  private

  def set_coordinates
    x, y, dir = coordinates_string.split(' ')

    Try[Dry::Types::CoercionError, Dry::Types::SchemaError, Dry::Struct::Error] do
      Coordinates.new(x: x, max_x: plateu.x, y: y, max_y: plateu.y, dir: dir)
    end.or do
      Failure("'#{coordinates_string}' is not a valid set of coordinates, skipping rover.")
    end
  end

  def validate_coordinates(coordinates)
    return Failure("'#{coordinates_string}' is not a valid set of coordinates, skipping rover.") unless coordinates.valid?

    Success(coordinates)
  end

  def set_commands
    Try[Dry::Types::SchemaError, Dry::Struct::Error] do
      CommandsSet.new(value: commands_string)
    end.or do
      Failure("'#{commands_string}' is not a valid set of commands, skipping rover.")
    end
  end
end
