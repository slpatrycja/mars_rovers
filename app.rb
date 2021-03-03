Dir["lib/*.rb"].each { |file| require_relative file }
Dir["lib/models/*.rb"].each { |file| require_relative file }
Dir["lib/services/*.rb"].each { |file| require_relative file }
Dir["lib/values/*.rb"].each { |file| require_relative file }

class App
  def run
    puts 'Insert commands and finish with Ctrl+D'

    @lines = STDIN.read.split("\n")

    set_plateu
    check_input_data_length

    @lines.each_slice(2) do |coordinates, commands|
      result = RoverManager.new(
        coordinates_string: coordinates,
        commands_string: commands,
        plateu: @plateu
      ).call

      result.success? ? (puts result.success) : (puts result.failure)
    end
  end

  private

  def set_plateu
    plateu_x, plateu_y = @lines.shift.split(' ')

    @plateu = Plateu.new(x: plateu_x, y: plateu_y)
  rescue Dry::Types::CoercionError, Dry::Types::SchemaError, Dry::Struct::Error, Dry::Types::ConstraintError
    abort 'ERROR: Invalid values for plateu coordinates'
  end

  def check_input_data_length
    abort 'ERROR: Each rover must receive two lines long data set' if @lines.length % 2 != 0
  end
end

App.new.run
