require 'barcodes/symbology/ean'

module Barcodes
  module Symbology
    class Ean8 < Ean
      def initialize(args={})
        unless args.has_key? :data
          args[:data] = '0123456'
        end
        
        super(args)
      end
      
      def formatted_data
        @start_character + @data[0..3] + @center_character + @data[4..6] + self.checksum + @stop_character
      end
      
      def encoded_data
        if self.valid?
          formatted_data = self.formatted_data
          encoded_data = ""
          index = 0
          formatted_data.each_byte do |char|
            if char.chr == 'S'
              encoded_data += "101"
            elsif char.chr == 'C'
              encoded_data += "01010"
            else
              if index < 6
                encoded_data += self._encode_character_with_parity(char, '1')
              else
                encoded_data += self._encode_character_with_right_hand(char)
              end
            end
            index += 1
          end
          encoded_data
        end
      end
      
      def valid?
        unless super
          return false
        end
        
        return self.data.length == 7 ? true : false
      end
    end
  end
end