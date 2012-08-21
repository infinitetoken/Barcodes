require 'barcodes/symbology/base'

module Barcodes
  module Symbology
    class Postnet < Base
      def formatted_data
        checksum = self.checksum
        unless checksum.nil?
          @data + checksum
        end
      end
      
      def encoded_data
        if self.valid?
          encoded_data = ''
          self.formatted_data.each_char do |char|
            encoded_data += self._encode_character char
          end
          return '1' + encoded_data + '1'
        end
      end
      
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
      
      def width
        if self.valid?
          return (((self.encoded_data.length * 2) - 1) * 20)
        end
        return 0
      end
    
      def height
        125
      end
      
      def valid?
        @data.each_char do |char|
          if self._encode_character(char).nil?
            return false
          end
        end
      
        return @data.length == 5 || @data.length == 9 || @data.length == 11
      end
      
      def draw(pdf)
        if self.valid?
          pdf.save_graphics_state

          pdf.fill_color self.color

          pdf.transparent self.alpha do
            barcode_box_width = (self.width * 0.001) * 72.0
            full_bar_height_pixels = (125 * 0.001) * 72.0
            half_bar_height_pixels = (50 * 0.001) * 72.0
            bar_width_pixels = (20 * 0.001) * 72.0

            pdf.bounding_box([0, full_bar_height_pixels], :width => barcode_box_width, :height => full_bar_height_pixels) do
              index = 0
              self.encoded_data.each_char do |char|
                if char == '1'
                  origin = [index * (bar_width_pixels * 2.0), full_bar_height_pixels]
                  pdf.fill_rectangle origin, bar_width_pixels, full_bar_height_pixels
                else
                  origin = [index * (bar_width_pixels * 2.0), half_bar_height_pixels]
                  pdf.fill_rectangle origin, bar_width_pixels, half_bar_height_pixels
                end
                index += 1
              end
            end
          end

          pdf.restore_graphics_state
        end
      end
      
      protected
      
      def _encode_character(character)
        case character
        when '0'
          return "11000"
        when '1'
          return "00011"
        when '2'
          return "00101"
        when '3'
          return "00110"
        when '4'
          return "01001"
        when '5'
          return "01010"
        when '6'
          return "01100"
        when '7'
          return "10001"
        when '8'
          return "10010"
        when '9'
          return "10100"
        else
          return nil
        end
      end
    end
  end
end