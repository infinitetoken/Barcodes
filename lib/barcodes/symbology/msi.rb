require 'barcodes/symbology/base'

module Barcodes
  module Symbology
    class Msi < Standard
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
          return "100100100100"
        when '1'
          return "100100100110"
        when '2'
          return "100100110100"
        when '3'
          return "100100110110"
        when '4'
          return "100110100100"
        when '5'
          return "100110100110"
        when '6'
          return "100110110100"
        when '7'
          return "100110110110"
        when '8'
          return "110100100100"
        when '9'
          return "110100100110"
        when 'S'
          return "110"
        when 'E'
          return "1001"
        else
          return nil
        end
      end
    end
  end
end