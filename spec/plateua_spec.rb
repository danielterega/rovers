require 'spec_helper'

describe Rovers::Plateau do
  let(:plateau) { Rovers::Plateau.new(5,5) }

  describe '#new' do
    context 'with invalid arguments' do
      it { expect{Rovers::Plateau.new(0, 1)}.to raise_error(Rovers::ArgumentError, 'invalid size: 0x1') }
      it { expect{Rovers::Plateau.new(1, 'a')}.to raise_error(Rovers::ArgumentError, 'invalid size: 1xa') }
    end
  end

  describe '.cell_is_blocked?' do
    context 'on unavailable cell' do
      it { expect(plateau.cell_is_blocked?(-1,-1)).to be true }
    end
  end
end