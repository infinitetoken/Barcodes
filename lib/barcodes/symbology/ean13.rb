# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/ean'

module Barcodes
  module Symbology
    
    # This class represents the EAN13 symbology
    # EAN13 can encode only numbers 0-9
    # 
    # More info: http://en.wikipedia.org/wiki/International_Article_Number_(EAN)
    class Ean13 < Ean
      
      # Creates a new Ean13 instance
      def initialize(args={})
        unless args.has_key? :data
          args[:data] = '012345678999'
        end
        
        super(args)
      end
      
      # Returns start character + data + center character + data + checksum + stop character
      def formatted_data
        @start_character + @data[0..6] + @center_character + @data[7..12] + self.checksum + @stop_character
      end
      
      # Determines whether or not the barcode data to be encoded
      # is valid.
      # Data length must be exactly 12 digits
      def valid?
        return self.data.length == 12 ? true : false
      end
    end
  end
end