require 'barcodes/symbology/standard'

module Barcodes
  module Symbology
    class Standard2Of5 < Standard
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
          return "10101110111010"
        when '1'
          return "11101010101110"
        when '2'
          return "10111010101110"
        when '3'
          return "11101110101010"
        when '4'
          return "10101110101110"
        when '5'
          return "11101011101010"
        when '6'
          return "10111011101010"
        when '7'
          return "10101011101110"
        when '8'
          return "11101010111010"
        when '9'
          return "10111010111010"
        when 'S'
          return "11011010"
        when 'E'
          return "1101011"
        else
          return nil
        end
      end
    end
  end
end