require 'spec_helper'

describe Rovers::Rover do
  let(:plateau) { Rovers::Plateau.new(5,5) }

  describe '#new' do
    context 'with invalid arguments' do
      it { expect{Rovers::Rover.new(nil, 1, 2, 'A')}.to raise_error(Rovers::ArgumentError, 'invalid plateau: ') }
      it { expect{Rovers::Rover.new(plateau, -1, 2, 'A')}.to raise_error(Rovers::ArgumentError, 'invalid coordinates: -1, 2') }
      it { expect{Rovers::Rover.new(plateau, 'a', 2, 'A')}.to raise_error(Rovers::ArgumentError, 'invalid coordinates: a, 2') }
      it { expect{Rovers::Rover.new(plateau, 1, 2, 'A')}.to raise_error(Rovers::ArgumentError, 'invalid direction: A') }
    end
  end

  context "when it on a plateau" do
    it "turns right" do
      expect(Rovers::Rover.new(plateau, 0, 0, 'N').turn(:right)).to eq(:'E')
    end

    it "turns left" do
      expect(Rovers::Rover.new(plateau, 0, 0, 'N').turn(:left)).to eq(:'W')
    end
  end
end