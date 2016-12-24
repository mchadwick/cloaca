module Cloaca::Operations
  class GenerateRandomIntegers

    def initialize(
      count:,
      delay_in_ms:,
      max:,
      min:,
      output:,
      **
    )
      @count = count.to_i
      @delay_in_seconds = delay_in_ms / 1000.0
      @max = max
      @min = min
      @output = output
      @range = max - min + 1
    end


    def run!
      last = @count - 1
      @count.times do |n|
        @output.puts @min + rand(@range)
        sleep(@delay_in_seconds) unless n == last || @delay_in_seconds <= 0
      end
    end

  end
end
