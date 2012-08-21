require 'barcodes/symbology/standard'

module Barcodes
  module Symbology
    class Code39 < Standard
      def initialize(args={})
        super(args)
        
        @start_character = '*'
        @stop_character = '*'
      end
      
      def caption_data
        self.formatted_data
      end
      
      def formatted_data
        @start_character + @data + @stop_character
      end
      
      protected
      
      def _encode_character(character)
        case character
        when '0'
          return "1010011011010"
        when '1'
          return "1101001010110"
        when '2'
          return "1011001010110"
        when '3'
          return "1101100101010"
        when '4'
          return "1010011010110"
        when '5'
          return "1101001101010"
        when '6'
          return "1011001101010"
        when '7'
          return "1010010110110"
        when '8'
          return "1101001011010"
        when '9'
          return "1011001011010"
        when 'A'
          return "1101010010110"
        when 'B'
          return "1011010010110"
        when 'C'
          return "1101101001010"
        when 'D'
          return "1010110010110"
        when 'E'
          return "1101011001010"
        when 'F'
          return "1011011001010"
        when 'G'
          return "1010100110110"
        when 'H'
          return "1101010011010"
        when 'I'
          return "1011010011010"
        when 'J'
          return "1010110011010"
        when 'K'
          return "1101010100110"
        when 'L'
          return "1011010100110"
        when 'M'
          return "1101101010010"
        when 'N'
          return "1010110100110"
        when 'O'
          return "1101011010010"
        when 'P'
          return "1011011010010"
        when 'Q'
          return "1010101100110"
        when 'R'
          return "1101010110010"
        when 'S'
          return "1011010110010"
        when 'T'
          return "1010110110010"
        when 'U'
          return "1100101010110"
        when 'V'
          return "1001101010110"
        when 'W'
          return "1100110101010"
        when 'X'
          return "1001011010110"
        when 'Y'
          return "1100101101010"
        when 'Z'
          return "1001101101010"
        when ' '
          return "1001101011010"
        when '-'
          return "1001010110110"
        when '.'
          return "1100101011010"
        when '$'
          return "1001001001010"
        when '/'
          return "1001001010010"
        when '+'
          return "1001010010010"
        when '%'
          return "1010010010010"
        when '*'
          return "1001011011010"
        else
          return nil
        end
      end
    end
  end
end