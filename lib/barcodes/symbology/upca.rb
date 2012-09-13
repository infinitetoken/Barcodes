# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/ean'

module Barcodes
  module Symbology
    
    # This class represents the UPC-A symbology
    # UPC-A can encode only numbers 0-9
    # 
    # More info: http://en.wikipedia.org/wiki/Universal_Product_Code
    class UpcA < Ean
      
      # Creates a new UpcA instance
      def initialize(args={})
        unless args.has_key? :data
          args[:data] = '01234567899'
        end
        
        super(args)
      end
      
      # Returns start character + 0 + data + center character + data + checksum + stop character
      def formatted_data
        @start_character + '0' + @data[0..5] + @center_character + @data[6..10] + self.checksum + @stop_character
      end
      
      # Validates barcode using provided data
      # Data length must be 11 digits
      def valid?
        return self.data.length == 11 ? true : false
      end
    end
  end
end