# frozen_string_literal: true

require_relative '../../lib/values/coordinates.rb'
require_relative '../../lib/values/commands_set.rb'
require_relative '../../lib/values/plateu.rb'
require_relative '../../lib/models/rover.rb'
require_relative '../../lib/services/rover_manager.rb'

RSpec.describe RoverManager do
  let(:coordinates_string) { '1 2 N' }
  let(:commands_string) { 'LMLMLMLMM' }
  let(:plateu) { Plateu.new(x: 5, y: 5) }

  let(:service) { described_class.new(coordinates_string: coordinates_string, commands_string: commands_string, plateu: plateu) }

  describe '#call' do
    subject { service.call }

    it 'converts coordinates_string to Coordinates value object' do
      expect(Coordinates).to receive(:new).with(x: '1', max_x: 5, y: '2', max_y: 5, dir: 'N').and_call_original

      subject
    end

    it 'converts commands_string to CommandsSet value object' do
      expect(CommandsSet).to receive(:new).with(value: commands_string).and_call_original

      subject
    end

    it 'creates new rover object' do
      expect(Rover).to receive(:new).with(x: 1, y: 2, dir: 'N', plateu: plateu).and_call_original

      subject
    end

    describe 'proccessing commands by rover' do
      let(:rover) { Rover.new(x: 1, y: 2, dir: 'N', plateu: plateu) }

      before do
        allow(Rover).to receive(:new).and_return(rover)
      end

      it 'passes each do the commands to rover' do
        commands_string.split('').each do |command|
          expect(rover).to receive(:process).with(command)
        end

        subject
      end

      it 'returns Success monad with rover\'s new position' do
        expect(subject).to be_success
        expect(subject.success).to eq '1 3 N' # rover begins at 1 2 N and moves LMLMLMLMM
      end
    end

    context 'coordinates are of invalid type' do
      let(:coordinates_string) { 'W 2 N' }

      it 'returns Failure monad with message' do
        expect(subject).to be_failure
        expect(subject.failure).to eq "'#{coordinates_string}' is not a valid set of coordinates, skipping rover."
      end
    end

    context 'coordinates values are beyond plateu values' do
      let(:plateu) { Plateu.new(x: 5, y: 5) }
      let(:coordinates_string) { '6 2 N' }

      it 'returns Failure monad with message' do
        expect(subject).to be_failure
        expect(subject.failure).to eq "'#{coordinates_string}' is not a valid set of coordinates, skipping rover."
      end
    end

    context 'commands set contains invalid letters (other than L, P and M)' do
      let(:commands_string) { 'WTSLMLM12' }

      it 'returns Failure monad with message' do
        expect(subject).to be_failure
        expect(subject.failure).to eq "'#{commands_string}' is not a valid set of commands, skipping rover."
      end
    end
  end
end
