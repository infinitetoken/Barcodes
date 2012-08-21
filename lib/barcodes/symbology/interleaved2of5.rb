require 'barcodes/symbology/standard'

module Barcodes
  module Symbology
    class Interleaved2Of5 < Standard
      def initialize(args={})
        super(args)
        
        @start_character = 'S'
        @stop_character = 'E'
      end
      
      def formatted_data
        @start_character + @data + @stop_character
      end
      
      protected
      
      def _encode_character(character)
        case character
        when '0'
          return "101011011010"
        when '1'
          return "110101010110"
        when '2'
          return "101101010110"
        when '3'
          return "110110101010"
        when '4'
          return "101011010110"
        when '5'
          return "110101101010"
        when '6'
          return "101101101010"
        when '7'
          return "101010110110"
        when '8'
          return "110101011010"
        when '9'
          return "101101011010"
        when 'S'
          return "1010"
        when 'E'
          return "1101"
        else
          return nil
        end
      end
    end
  end
end