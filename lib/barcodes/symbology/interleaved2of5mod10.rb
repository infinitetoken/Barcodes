require 'barcodes/symbology/interleaved2of5'

module Barcodes
  module Symbology
    class Interleaved2Of5Mod10 < Interleaved2Of5
      def formatted_data
        checksum = self.checksum
        unless checksum.nil?
          @start_character + @data + checksum + @stop_character
        end
      end
      
      def checksum
        even_sum = 0
        odd_sum = 0
        index = 0
        @data.reverse.each_char do |char|
          if ('0'..'9').include? char
            if index.even?
              even_sum += char.to_i * 3
            else
              odd_sum += char.to_i
            end
          end
          index += 1
        end
        sum = even_sum + odd_sum
        
        value = 10 - (sum % 10)
        if value == 10
          value = 0
        end
        
        if (0..9).include? value
          return value.to_s
        end
      end
    end
  end
end