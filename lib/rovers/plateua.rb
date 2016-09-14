module Rovers
  class Plateau
    attr_accessor :max_x, :max_y, :rovers
    
    def initialize(max_x, max_y)  
      begin
        @max_x, @max_y = Integer(max_x), Integer(max_y) 
      rescue 
        raise Rovers::ArgumentError, "invalid size: #{max_x}x#{max_y}"
      end
      validate
      @rovers = []
      init_grid
    end

    def cell_is_available?(x, y)
      !cell_is_blocked?(x, y)
    end

    def cell_is_blocked?(x, y)
      x < 0 || x > max_x || y < 0 || y > max_y || @rovers.any? {|rover| rover.x == x && rover.y == y}
    end

    def print
      init_grid
      @rovers.each do |rover|
        @grid[rover.y][rover.x] = rover.to_arrow_ascii
      end
      system 'clear'
      pp @grid.reverse
    end

    private

    def validate
      raise Rovers::ArgumentError, "invalid size: #{max_x}x#{max_y}" unless max_x.is_a?(Integer) && max_x > 0\
        && max_y.is_a?(Integer) && max_y > 0
    end

    def init_grid
      @grid = Array.new(@max_y+1){ Array.new(@max_x+1, ' ') } 
    end
  end
end
