# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/ean'

module Barcodes
  module Symbology
    class UpcA < Ean
      def initialize(args={})
        unless args.has_key? :data
          args[:data] = '01234567899'
        end
        
        super(args)
      end
      
      def formatted_data
        @start_character + '0' + @data[0..5] + @center_character + @data[6..10] + self.checksum + @stop_character
      end
      
      def valid?
        unless super
          return false
        end
        
        return self.data.length == 11 ? true : false
      end
    end
  end
end