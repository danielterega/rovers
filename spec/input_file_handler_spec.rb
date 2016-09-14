require 'spec_helper'
require 'pry'


describe Rovers::InputFileHandler do
	let(:files_path) { File.dirname(__FILE__) + '/fixtures/files/'}

	let(:incorrect_input_handler) { Rovers::InputFileHandler.new(files_path + 'incorrect_input.txt')}
	let(:correct_input_handler) { Rovers::InputFileHandler.new(files_path + 'input.txt')}

	describe '#new' do
		context 'without path' do
  		it { expect{Rovers::InputFileHandler.new()}.to raise_error(ArgumentError,) }
		end

		context 'with path' do
			context 'that leads to no file' do
	  		it { expect{Rovers::InputFileHandler.new('')}.to raise_error(Errno::ENOENT) }
			end

			context 'that leads to file' do
				context 'with incorrect data' do
		  		it { expect{incorrect_input_handler}.to raise_error(Rovers::Error) }
				end
			end
		end
	end

	describe '.run' do
		context 'with correct input' do
	    it { expect(correct_input_handler.run).to eq("1 3 N\n5 1 E") }
	  end
	end
end
