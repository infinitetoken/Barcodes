# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

# 
module Barcodes
  module Renderer
    
    # This class handles ASCII rendering support.
    class Ascii
      # The barcode instance
      attr_accessor :barcode
      
      # Creates a new Barcodes::Renderer::Ascii instance
      def initialize(barcode=nil)
        @barcode = barcode
      end
      
      # Renders the barcode as ASCII string with optional filename
      def render(filename=nil)
        rendering = ''
        if @barcode.class == Barcodes::Symbology::Ean8
          rendering = self._render_ean8(@barcode)
        elsif @barcode.class == Barcodes::Symbology::Ean13
          rendering = self._render_ean13(@barcode)
        elsif @barcode.class == Barcodes::Symbology::Planet || @barcode.class == Barcodes::Symbology::Postnet
          rendering = self._render_planet_postnet(@barcode)
        elsif @barcode.class == Barcodes::Symbology::UpcA
          rendering = self._render_upca(@barcode)
        else
          rendering = self._render_standard(@barcode)
        end
        
        unless filename.nil?
          File.open(filename, 'w') {|f| f.write(rendering) }
        else
          rendering
        end
      end
      
      protected
      
      # Render standard barcode symbologies
      def _render_standard(barcode)
        ascii = ""
        10.times do |i|
          barcode.encoded_data.each_char do |char|
            if char == '1'
              ascii += "*"
            else
              ascii += " "
            end
          end
          ascii += "\n"
        end
        
        if barcode.captioned
          offset = ((barcode.encoded_data.length - barcode.caption_data.length) / 2).floor
          offset.times do |t|
            ascii += ' '
          end
          ascii += barcode.caption_data + "\n"
        end
        ascii += "\n"
      end
      
      # Render EAN8 barcode symbology
      def _render_ean8(barcode)
        encoded_data = barcode.encoded_data
        
        ascii = ""
        10.times do |i|
          ascii += "  "
          encoded_data.each_char do |char|
            if char == '1'
              ascii += "*"
            else
              ascii += " "
            end
          end
          ascii += "  \n"
        end
        
        ascii += "  "
        encoded_data.length.times.each do |index|
          if encoded_data[index] == '1' && ((index >= 0 && index <= 3) || (index >= 32 && index <= 35) || (index >= 65))
            ascii += "*"
          elsif (index >= 14 && index < 18)
            if barcode.captioned
              ascii += barcode.caption_data[index - 13]
            end
          elsif (index >= 49 && index < 53)
            if barcode.captioned
              ascii += barcode.caption_data[index - 45]
            end
          else
            ascii += " "
          end
        end
        ascii += "  \n"
      end
      
      # Render EAN13 barcode symbology
      def _render_ean13(barcode)
        encoded_data = barcode.encoded_data
        
        ascii = ""
        10.times do |i|
          if i == 9
            if barcode.captioned
              ascii += barcode.caption_data[0] + " "
            end
          else
            ascii += "  "
          end
          encoded_data.each_char do |char|
            if char == '1'
              ascii += "*"
            else
              ascii += " "
            end
          end
          ascii += "  \n"
        end
        
        ascii += "  "
        encoded_data.length.times.each do |index|
          if encoded_data[index] == '1' && ((index >= 0 && index <= 3) || (index >= 46 && index <= 49) || (index >= 93))
            ascii += "*"
          elsif (index >= 21 && index < 27)
            if barcode.captioned
              ascii += barcode.caption_data[index - 21]
            end
          elsif (index >= 69 && index < 75)
            if barcode.captioned
              ascii += barcode.caption_data[index - 63]
            end
          else
            ascii += " "
          end
        end
        ascii += "  \n"
      end
      
      # Render a PLANET or POSTNET barcode symbology
      def _render_planet_postnet(barcode)
        ascii = ""
        6.times do |i|
          barcode.encoded_data.each_char do |char|
            if char == '1'
              ascii += "* "
            else
              if i < 3
                ascii += "  "
              else
                ascii += "* "
              end
            end
          end
          ascii += "\n"
        end
        ascii += "\n"
      end
      
      # Render UPC-A barcode symbology
      def _render_upca(barcode)
        encoded_data = barcode.encoded_data
        
        ascii = ""
        10.times do |i|
          if i == 9
            if barcode.captioned
              ascii += barcode.caption_data[0] + " "
            end
          else
            ascii += "  "
          end
          encoded_data.each_char do |char|
            if char == '1'
              ascii += "*"
            else
              ascii += " "
            end
          end
          if i == 9
            if barcode.captioned
              ascii += " " + barcode.caption_data[barcode.caption_data.length - 1] + "\n"
            end
          else
            ascii += "  \n"
          end
        end
        
        ascii += "  "
        encoded_data.length.times.each do |index|
          if encoded_data[index] == '1' && ((index >= 0 && index <= 3) || (index >= 46 && index <= 49) || (index >= 93))
            ascii += "*"
          elsif (index >= 22 && index < 27)
            if barcode.captioned
              ascii += barcode.caption_data[index - 21]
            end
          elsif (index >= 70 && index < 75)
            if barcode.captioned
              ascii += barcode.caption_data[index - 63]
            end
          else
            ascii += " "
          end
        end
        ascii += "  \n"
      end
    end
  end
end