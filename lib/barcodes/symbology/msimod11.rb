# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/msi'

module Barcodes
  module Symbology
    
    # This class represents the MSI Mod 11 symbology
    # MSI Mod 11 can encode only numbers 0-9
    # 
    # More info: http://en.wikipedia.org/wiki/MSI_Barcode
    class MsiMod11 < Msi
      
      # Returns start character + data + checksum + stop character
      def formatted_data
        checksum = self.checksum
        unless checksum.nil?
          @start_character + @data + checksum + @stop_character
        end
      end
      
      # Calculates the checksum using the provided data
      def checksum
        if self.valid?
          sum = 0
          weight = 2
          data.reverse.each_char do |char|
            if ('0'..'9').include? char
              sum += weight * char.to_i
            end
            if weight < 7
              weight += 1
            else
              weight = 2
            end
          end

          value = sum % 11

          if (0..9).include? value
            return value.to_s
          end
        end
      end
    end
  end
end