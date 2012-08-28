require 'barcodes/symbology/base'

module Barcodes
  module Symbology
    class Interleaved2Of5 < Base
      def self.charset
        ['0','1','2','3','4','5','6','7','8','9','S','E'].collect {|c| c.bytes.to_a[0] }
      end
      
      def self.valueset
        [
          '101011011010','110101010110','101101010110','110110101010',
          '101011010110','110101101010','101101101010','101010110110',
          '110101011010','101101011010','1010','1101'
        ]
      end
      
      def initialize(args={})
        super(args)
        
        @start_character = 'S'
        @stop_character = 'E'
      end
      
      def formatted_data
        @start_character + @data + @stop_character
      end
    end
  end
end