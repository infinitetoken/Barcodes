# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/base'

module Barcodes
  module Symbology
    
    # This class represents the PLANET symbology
    # PLANET can encode only numbers 0-9
    # 
    # More info: http://en.wikipedia.org/wiki/Postal_Alpha_Numeric_Encoding_Technique
    class Planet < Base
      
      # PLANET character set
      def self.charset
        ['0','1','2','3','4','5','6','7','8','9'].collect {|c| c.bytes.to_a[0] }
      end
      
      # PLANET values set
      def self.valueset
        [
          '00111','11100','11010','11001',
          '10110','10101','10011','01110',
          '01101','01011'
        ]
      end
      
      # Creates a new Planet instance
      def initialize(args={})
        unless args.has_key? :data
          args[:data] = '012345678999'
        end
        
        super(args)
      end
      
      # Returns data + checksum
      def formatted_data
        checksum = self.checksum
        unless checksum.nil?
          @data + checksum
        end
      end
      
      # Returns the barcode data encoded as 1's and 0's.
      def encoded_data
        if self.valid?
          encoded_data = ''
          self.formatted_data.each_byte do |char|
            encoded_data += self._encode_character char
          end
          return '1' + encoded_data + '1'
        end
      end
      
      # Calculates the checksum using the provided data
      def checksum
        if self.valid?
          sum = 0
          @data.each_char do |char|
            sum += char.to_i
          end
          
          value = 10 - (sum % 10)
          if value == 10
            value = 0
          end

          if (0..9).include? value
            return value.to_s
          end
        end
      end
      
      # Returns the overall width of the barcode in mils.
      def width
        if self.valid?
          return (((self.encoded_data.length * 2) - 1) * 20)
        end
        return 0
      end
      
      # Returns the overall height of the barcode in mils.
      def height
        125
      end
      
      # Determines whether or not the barcode data to be encoded
      # is valid.
      # Data length must be 12 or 14 digits
      def valid?
        @data.each_byte do |char|
          if self._encode_character(char).nil?
            return false
          end
        end
      
        return @data.length == 12 || @data.length == 14
      end
    end
  end
end