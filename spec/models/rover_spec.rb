# frozen_string_literal: true

require_relative '../../lib/models/rover.rb'
require_relative '../../lib/values/plateu.rb'

RSpec.describe Rover do
  let(:x) { 1 }
  let(:y) { 2 }
  let(:dir) { 'N' }
  let(:plateu) { Plateu.new(x: 5, y: 5) }

  let(:rover) { described_class.new(x: x, y: y, dir: dir, plateu: plateu) }

  describe '#current_position' do
    subject { rover.current_position }

    it { is_expected. to eq '1 2 N' }
  end

  describe '#process' do
    subject { rover.process(command) }

    context 'turning left' do
      let(:command) { 'L' }

      it 'changes direction for -90 degreees' do
        subject

        expect(rover.current_position).to eq '1 2 W'
      end
    end

    context 'turning right' do
      let(:command) { 'R' }

      it 'changes direction for +90 degreees' do
        subject

        expect(rover.current_position).to eq '1 2 E'
      end
    end

    context 'moving' do
      let(:command) { 'M' }

      context 'rover is facing north' do
        let(:dir) { 'N' }

        it 'moves up on the y axis' do
          expect(rover.current_position).to eq '1 2 N'

          subject

          expect(rover.current_position).to eq '1 3 N'
        end
      end

      context 'rover is facing south' do
        let(:dir) { 'S' }

        it 'moves down on the y axis' do
          expect(rover.current_position).to eq '1 2 S'

          subject

          expect(rover.current_position).to eq '1 1 S'
        end
      end

      context 'rover is facing east' do
        let(:dir) { 'E' }

        it 'moves up on the x axis' do
          expect(rover.current_position).to eq '1 2 E'

          subject

          expect(rover.current_position).to eq '2 2 E'
        end
      end

      context 'rover is facing west' do
        let(:dir) { 'W' }

        it 'moves down on the x axis' do
          expect(rover.current_position).to eq '1 2 W'

          subject

          expect(rover.current_position).to eq '0 2 W'
        end
      end

      context 'rover is already on the plateu limit' do
        let(:x) { 1 }
        let(:y) { 5 }
        let(:dir) { 'N' }
        let(:plateu) { Plateu.new(x: 5, y: 5) }

        it 'does not move the rover' do
          expect(rover.current_position).to eq '1 5 N'

          subject

          expect(rover.current_position).to eq '1 5 N'
        end
      end
    end
  end
end
