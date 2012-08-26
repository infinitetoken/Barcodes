require 'barcodes/symbology/base'

module Barcodes
  module Symbology
    class Standard < Base
      def draw(pdf)
        if valid?
          pdf.save_graphics_state
        
          pdf.fill_color self.color
        
          pdf.transparent self.alpha do
            quiet_zone_width_pixels = (self.quiet_zone_width * 0.001) * 72.0
            barcode_box_width_pixels = ((self.encoded_data.length * self.bar_width) * 0.001) * 72.0
            bar_height_pixels = (self.bar_height * 0.001) * 72.0
            bar_width_pixels = (self.bar_width * 0.001) * 72.0
            caption_height_pixels = ((self.caption_height * 0.001) * 72.0)
            barcode_height_pixels = ((self.height * 0.001) * 72.0)
            
            pdf.bounding_box([quiet_zone_width_pixels, barcode_height_pixels], :width => barcode_box_width_pixels, :height => bar_height_pixels) do
              index = 0
              bar_count = 0
              origin = []
              self.encoded_data.each_char do |char|
                if char == '1'
                  if bar_count == 0
                    origin = [index * bar_width_pixels, bar_height_pixels]
                  end
                  bar_count += 1
                else
                  pdf.fill_rectangle origin, bar_width_pixels * bar_count, bar_height_pixels
                  bar_count = 0
                end
                index += 1
              end
              
              if bar_count > 0
                pdf.fill_rectangle origin, bar_width_pixels * bar_count, bar_height_pixels
              end
            end
          
            options = {
              :at => [((self.quiet_zone_width * 0.001) * 72.0), caption_height_pixels],
              :width => barcode_box_width_pixels, 
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
      end
    end
  end
end