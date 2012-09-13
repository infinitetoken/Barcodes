# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/ean'

module Barcodes
  module Symbology
    
    # This class represents the EAN8 symbology
    # EAN8 can encode only numbers 0-9
    # 
    # More info: http://en.wikipedia.org/wiki/International_Article_Number_(EAN)
    class Ean8 < Ean
      
      # Creates a new Ean13 instance
      def initialize(args={})
        unless args.has_key? :data
          args[:data] = '0123456'
        end
        
        super(args)
      end
      
      # Returns start character + data + center character + data + checksum + stop character
      def formatted_data
        @start_character + @data[0..3] + @center_character + @data[4..6] + self.checksum + @stop_character
      end
      
      # Encodes data into 1's and 0's
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
      
      # Determines whether or not the barcode data to be encoded
      # is valid.
      # Data length must be exactly 7 digits
      def valid?
        return self.data.length == 7 ? true : false
      end
    end
  end
end