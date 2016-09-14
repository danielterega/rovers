module Rovers
  class Rover
    attr_accessor :x, :y, :direction, :plateau
    DIRECTIONS = {N: [0, 1], E: [1, 0], S: [0, -1], W: [-1, 0]}
    SIDE_SIZE = {arround: 2, left: -1, right: 1}

    def go(instructions)
      instructions.each_char do |m|
        send_message(m)
      end
    end

    def turn(side)
      return "Unknown side: #{side}" unless SIDE_SIZE[side]
      spin(SIDE_SIZE[side])
    end

    def initialize(plateau, x, y, direction)
      @plateau, @direction = plateau, direction.to_sym
      begin
        @x, @y = Integer(x), Integer(y) 
      rescue 
        raise Rovers::ArgumentError, "invalid coordinates: #{x}, #{y}"
      end
      validate
        
      if plateau.cell_is_available?(@x, @y)
        plateau.rovers << self
      end
    end

    private

    def validate
      validate_plate
      validate_coordinates
      validate_direction
    end

    def validate_direction
      raise Rovers::ArgumentError, "invalid direction: #{direction}" unless DIRECTIONS.keys.include?(direction)
    end

    def validate_plate
      raise Rovers::ArgumentError, "invalid plateau: #{plateau}" if plateau.nil? || !plateau.is_a?(Rovers::Plateau)
    end

    def validate_coordinates
      raise Rovers::ArgumentError, "invalid coordinates: #{x}, #{y}" unless x.is_a?(Integer) && x >= 0 && y.is_a?(Integer) && y >= 0
    end

    def direction_multiplyer
      DIRECTIONS[@direction]
    end

    def send_message(message)
      case message
      when 'L'
        turn :left
      when 'R'
        turn :right
      when 'M'
        try_step
      else
        return "Unknown message : #{message}"
      end
    end

    def spin(size)
      @direction = DIRECTIONS.keys[(DIRECTIONS.keys.find_index(@direction) + size) % 4]
    end

    def try_step
      k_x, k_y = direction_multiplyer
      new_x, new_y = @x + k_x, @y + k_y
      return "Cell is blocked!" if @plateau.cell_is_blocked?(new_x, new_y)
      @x, @y = new_x, new_y
    end

    def to_arrow_ascii
      arrow = {W: "\u2190", N: "\u2191", E: "\u2192", S: "\u2193"}[@direction].encode('utf-8')
      "\e[1m\e[33m#{arrow}\e[0m"
    end
  end
end