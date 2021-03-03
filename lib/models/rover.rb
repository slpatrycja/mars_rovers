# frozen_string_literal: true

require_relative '../dirs'

class Rover
  TURN_LEFT_COMMAND = 'L'
  TURN_RIGHT_COMMAND = 'R'
  MOVE_COMMAND = 'M'

  def initialize(x:, y:, dir:, plateu:)
    @x = x
    @y = y
    @dir = dir
    @plateu = plateu
  end

  def process(command)
    case command
    when TURN_LEFT_COMMAND
      turn_left
    when TURN_RIGHT_COMMAND
      turn_right
    when MOVE_COMMAND
      move
    end
  end

  def current_position
    "#{@x} #{@y} #{@dir}"
  end

  private

  def turn_left
    new_dir_index = (Dirs::ALL_DIRS.index(@dir) - 1) % 4

    @dir = Dirs::ALL_DIRS[new_dir_index]
  end

  def turn_right
    new_dir_index = (Dirs::ALL_DIRS.index(@dir) + 1) % 4

    @dir = Dirs::ALL_DIRS[new_dir_index]
  end

  def move
    return if plateu_limit_reached?

    case @dir
    when Dirs::DIR_NORTH
      @y += 1
    when Dirs::DIR_EAST
      @x += 1
    when Dirs::DIR_SOUTH
      @y -= 1
    when Dirs::DIR_WEST
      @x -= 1
    end
  end

  def plateu_limit_reached?
    case @dir
    when Dirs::DIR_NORTH
      @y == @plateu.y
    when Dirs::DIR_EAST
      @x == @plateu.x
    when Dirs::DIR_SOUTH
      @y == 0
    when Dirs::DIR_WEST
      @x == 0
    end
  end
end
