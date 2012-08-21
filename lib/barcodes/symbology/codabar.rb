require 'barcodes/symbology/standard'

module Barcodes
  module Symbology
    class Codabar < Standard
      def initialize(args={})
        unless args.has_key? :start_character
          args[:start_character] = 'A'
        end
        unless args.has_key? :stop_character
          args[:stop_character] = 'B'
        end
        
        super(args)
      end
      
      def draw(pdf)
        pdf.save_graphics_state
        
        pdf.fill_color self.color
        
        pdf.transparent self.alpha do
          barcode_box_width = ((self.encoded_data.length * self.bar_width) * 0.001) * 72.0
          bar_height_pixels = (self.bar_height * 0.001) * 72.0
          bar_width_pixels = (self.bar_width * 0.001) * 72.0
          caption_height_pixels = ((self.caption_height * 0.001) * 72.0)
          
          pdf.bounding_box([((self.quiet_zone_width * 0.001) * 72.0), ((self.height * 0.001) * 72.0)], :width => barcode_box_width, :height => bar_height_pixels) do
            index = 0
            self.encoded_data.each_char do |char|
              origin = [index * bar_width_pixels,bar_height_pixels]
              if char == '1'
                pdf.fill_rectangle origin, bar_width_pixels, bar_height_pixels
              end
              index += 1
            end
          end
          
          options = {
            :at => [((self.quiet_zone_width * 0.001) * 72.0), caption_height_pixels],
            :width => barcode_box_width, 
            :height => caption_height_pixels,
            :overflow => :truncate,
            :size => self.font_size,
            :valign => :center,
            :align => :center,
            :style => :normal
          }
          pdf.text_box self.caption_data, options
        end
        
        pdf.restore_graphics_state
      end
      
      def formatted_data
        @start_character + @data + @stop_character
      end
      
      protected
      
      def _encode_character(character)
        case character
        when '0'
          return "1010100110"
        when '1'
          return "1010110010"
        when '2'
          return "1010010110"
        when '3'
          return "1100101010"
        when '4'
          return "1011010010"
        when '5'
          return "1101010010"
        when '6'
          return "1001010110"
        when '7'
          return "1001011010"
        when '8'
          return "100110101"
        when '9'
          return "1101001010"
        when '-'
          return "1010011010"
        when '$'
          return "1011001010"
        when ':'
          return "11010110110"
        when '/'
          return "11011010110"
        when '.'
          return "11011011010"
        when '+'
          return "1011001100110"
        when 'A'
          return "10110010010"
        when 'B'
          return "10100100110"
        when 'C'
          return "10010010110"
        when 'D'
          return "10100110010"
        else
          return nil
        end
      end
    end
  end
end