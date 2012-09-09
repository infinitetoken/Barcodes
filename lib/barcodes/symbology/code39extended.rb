# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/code39'

module Barcodes
  module Symbology
    
    # This class represents the Code 39 Extended symbology.
    # Code 39 Extended can encode all standard ASCII characters.
    # 
    # More info: http://en.wikipedia.org/wiki/Code_39
    class Code39Extended < Code39
      
      # Start character + prepared data + stop character
      def formatted_data
        @start_character + self._data + @stop_character
      end
      
      # Determines whether or not the barcode data to be encoded
      # is valid.
      def valid?
        valid = self.data.length > 0 ? true : false
      
        self._data.each_byte do |char|
          if self._encode_character(char).nil?
            return false
          end
        end
      
        return valid
      end
      
      #protected
      
      # Returns prepared barcode data by replacing extended characters
      def _data
        prepared_data = ""
        
        self.data.each_byte do |character|
          case character
          when 0
            prepared_data += '%' + 'U'
          when 1..26
            prepared_data += '$' + (character + 64).chr
          when 27..31
            prepared_data += '%' + (character + 38).chr
          when 127
            prepared_data += '%' + 'T'
          when '!'.bytes.to_a[0]
            prepared_data += '/' + 'A'
          when '"'.bytes.to_a[0]
            prepared_data += '/' + 'B'
          when '#'.bytes.to_a[0]
            prepared_data += '/' + 'C'
          when '$'.bytes.to_a[0]
            prepared_data += '/' + 'D'
          when '%'.bytes.to_a[0]
            prepared_data += '/' + 'E'
          when '&'.bytes.to_a[0]
            prepared_data += '/' + 'F'
          when '\''.bytes.to_a[0]
            prepared_data += '/' + 'G'
          when '('.bytes.to_a[0]
            prepared_data += '/' + 'H'
          when ')'.bytes.to_a[0]
            prepared_data += '/' + 'I'
          when '*'.bytes.to_a[0]
            prepared_data += '/' + 'J'
          when '+'.bytes.to_a[0]
            prepared_data += '/' + 'K'
          when ','.bytes.to_a[0]
            prepared_data += '/' + 'L'
          when '/'.bytes.to_a[0]
            prepared_data += '/' + 'O'
          when ':'.bytes.to_a[0]
            prepared_data += '/' + 'Z'
          when ';'.bytes.to_a[0]
            prepared_data += '%' + 'F'
          when '<'.bytes.to_a[0]
            prepared_data += '%' + 'G'
          when '='.bytes.to_a[0]
            prepared_data += '%' + 'H'
          when '>'.bytes.to_a[0]
            prepared_data += '%' + 'I'
          when '?'.bytes.to_a[0]
            prepared_data += '%' + 'J'
          when '@'.bytes.to_a[0]
            prepared_data += '%' + 'V'
          when '['.bytes.to_a[0]
            prepared_data += '%' + 'K'
          when '\\'.bytes.to_a[0]
            prepared_data += '%' + 'L'
          when ']'.bytes.to_a[0]
            prepared_data += '%' + 'M'
          when '^'.bytes.to_a[0]
            prepared_data += '%' + 'N'
          when '_'.bytes.to_a[0]
            prepared_data += '%' + '0'
          when '`'.bytes.to_a[0]
            prepared_data += '%' + 'W'
          when 97..122
            prepared_data += '+' + character.chr.upcase
          when '{'.bytes.to_a[0]
            prepared_data += '%' + 'P'
          when '|'.bytes.to_a[0]
            prepared_data += '%' + 'Q'
          when '}'.bytes.to_a[0]
            prepared_data += '%' + 'R'
          when '~'.bytes.to_a[0]
            prepared_data += '%' + 'S'
          else
            prepared_data += character.chr
          end
        end
        
        return prepared_data
      end
    end
  end
end