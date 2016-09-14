require 'open-uri'

module Rovers
	class InputFileHandler
		def initialize(path)
			@io = open(path)
			validate_input
		end

		def run
			seek_to_beginning
			first_line = @io.readline.chomp
			plateau = Plateau.new(*first_line.split(' '))
			@io.each_slice(2).map do |position, instructions|
				position.chomp!
				instructions.chomp!
			  rover = Rover.new(plateau, *position.split(' '))
			  if rover.plateau
			    rover.go(instructions)
			    "#{rover.x} #{rover.y} #{rover.direction}"
			  else
			    "could not land the rover"
			  end
			end.join("\n")
		end

		private

		def validate_input
			seek_to_beginning

			raise Rovers::Error, "file is empty" if @io.size == 0

			@io.each_with_index do |line, idx|
				line.chomp!
				valid_pattern = if idx == 0
				           /^[1-9]\d* [1-9]\d*$/
				         elsif idx.odd?
				           /^[0-9]\d* [0-9]\d* [N,E,W,S]$/
				         else
				           /^[L,R,M]+$/
				         end

				raise Rovers::Error, "on line: #{idx}" unless line =~ valid_pattern
			end
		end

		def seek_to_beginning
			@io.seek(0)
		end
	end
end
