# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/base'

module Barcodes
  module Symbology
    
    # This class represents the MSI symbology
    # MSI can encode only numbers 0-9
    # 
    # More info: http://en.wikipedia.org/wiki/MSI_Barcode
    class Msi < Base
      
      # MSI character set
      def self.charset
        ['0','1','2','3','4','5','6','7','8','9','S','E'].collect {|c| c.bytes.to_a[0] }
      end
      
      # MSI values set
      def self.valueset
        [
          '100100100100','100100100110','100100110100','100100110110',
          '100110100100','100110100110','100110110100','100110110110',
          '110100100100','110100100110','110','1001'
        ]
      end
      
      # Creates a new Msi instance
      def initialize(args={})
        super(args)
        
        @start_character = 'S'
        @stop_character = 'E'
      end
      
      # Returns start character + data + stop character
      def formatted_data
        @start_character + @data + @stop_character
      end
    end
  end
end