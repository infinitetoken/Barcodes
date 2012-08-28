require 'barcodes/symbology/base'

module Barcodes
  module Symbology
    class Code11 < Base
      def self.charset
        ['0','1','2','3','4','5','6','7','8','9','-','S'].collect {|c| c.bytes.to_a[0] }
      end
      
      def self.valueset
        [
          '1010110','11010110','10010110',
          '11001010','10110110','11011010',
          '10011010','10100110','11010010',
          '1101010','1011010','10110010'
        ]
      end
      
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
    end
  end
end