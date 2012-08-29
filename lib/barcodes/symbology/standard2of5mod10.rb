# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/standard2of5'

module Barcodes
  module Symbology
    
    # This class represents the Standard 2 of 5 Mod 10 symbology
    # Standard 2 of 5 Mod 10 can encode only numbers 0-9
    # 
    # More info: http://en.wikipedia.org/wiki/Two-out-of-five_code
    class Standard2Of5Mod10 < Standard2Of5
      
      # Returns start character + data + checksum + stop character
      def formatted_data
        checksum = self.checksum
        unless checksum.nil?
          @start_character + @data + checksum + @stop_character
        end
      end
      
      # Calculates the checksum using the provided data
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