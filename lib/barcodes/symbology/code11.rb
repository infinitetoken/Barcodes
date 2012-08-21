require 'barcodes/symbology/standard'

module Barcodes
  module Symbology
    class Code11 < Standard
      def initialize(args={})
        super(args)
        
        @start_character = 'S'
        @stop_character = 'S'
      end
      
      def formatted_data
        checksum = self.checksum
        unless checksum.nil?
          @start_character + @data + checksum + @stop_character
        end
      end
      
      def checksum
        if valid?
          unless @data.length >= 10
            c_value = self._checksum(@data, 10)
            return c_value
          else
            c_value = self._checksum(@data, 10)
            k_value = self._checksum(@data + c_value, 9)
            return c_value + k_value
          end
        end
      end
      
      protected
      
      def _checksum(data, weight_max)
        sum = 0
        weight = 0
        data.reverse.each_char do |char|
          if ('0'..'9').include? char
            sum += weight * char.to_i
          elsif char == '-'
            sum += weight * 10
          end
          if weight < weight_max
            weight += 1
          else
            weight = 0
          end
        end
        
        value = sum % 11
        
        if (0..9).include? value
          return value.to_s
        elsif value == 10
          return '-'
        end
      end
      
      def _encode_character(character)
        case character
        when '0'
          return "1010110"
        when '1'
          return "11010110"
        when '2'
          return "10010110"
        when '3'
          return "11001010"
        when '4'
          return "10110110"
        when '5'
          return "11011010"
        when '6'
          return "10011010"
        when '7'
          return "10100110"
        when '8'
          return "11010010"
        when '9'
          return "1101010"
        when '-'
          return "1011010"
        when 'S'
          return "10110010"
        else
          return nil
        end
      end
    end
  end
end