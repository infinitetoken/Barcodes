# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'prawn'

module Barcodes
  module Renderer
    
    # This class handles PDF rendering support.
    class Pdf
      # The barcode instance
      attr_accessor :barcode
      
      # Creates a new Barcodes::Renderer::Pdf instance
      def initialize(barcode=nil)
        @barcode = barcode
      end
      
      # Render the barcode as PDF with optional filename
      def render(filename=nil)
        pdf = self.pdf
        
        self.draw(pdf)
        
        unless filename.nil?
          pdf.render_file filename
        else
          pdf.render
        end
      end
      
      # Draws the barcode to the provided Prawn::Document
      def draw(pdf)
        if self.barcode.class == Barcodes::Symbology::Ean8 || self.barcode.class == Barcodes::Symbology::Ean13 || self.barcode.class == Barcodes::Symbology::UpcA
          self._draw_ean_upc(self.barcode, pdf)
        elsif self.barcode.class == Barcodes::Symbology::Planet || self.barcode.class == Barcodes::Symbology::Postnet
          self._draw_planet_postnet(self.barcode, pdf)
        else
          self._draw_standard(self.barcode, pdf)
        end
      end
      
      # Returns the instantiated Prawn::Document object
      def pdf
        width = (@barcode.width * 0.001) * 72.0
        height = (@barcode.height * 0.001) * 72.0
        
        document_options = {
          :page_size => [width, height],
          :left_margin => 0,
          :right_margin => 0,
          :top_margin => 0,
          :bottom_margin => 0
        }
        
        Prawn::Document.new document_options
      end
      
      protected
      
      # Draw standard barcode symbologies
      def _draw_standard(barcode, pdf)
        if barcode.valid?
          pdf.save_graphics_state
        
          pdf.fill_color barcode.color
        
          pdf.transparent barcode.alpha do
            quiet_zone_width_pixels = (barcode.quiet_zone_width * 0.001) * 72.0
            barcode_box_width_pixels = ((barcode.encoded_data.length * barcode.bar_width) * 0.001) * 72.0
            bar_height_pixels = (barcode.bar_height * 0.001) * 72.0
            bar_width_pixels = (barcode.bar_width * 0.001) * 72.0
            caption_size_pixels = ((barcode.caption_size * 0.001) * 72.0)
            caption_height_pixels = ((barcode.caption_height * 0.001) * 72.0)
            
            pdf.bounding_box([pdf.bounds.left + quiet_zone_width_pixels, pdf.bounds.top], :width => barcode_box_width_pixels, :height => bar_height_pixels) do
              index = 0
              bar_count = 0
              origin = []
              barcode.encoded_data.each_char do |char|
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
            
            if barcode.captioned
              options = {
                :at => [quiet_zone_width_pixels, pdf.bounds.top - bar_height_pixels],
                :width => barcode_box_width_pixels, 
                :height => caption_height_pixels,
                :overflow => :truncate,
                :size => caption_size_pixels,
                :fallback_fonts => ['Courier'],
                :valign => :center,
                :align => :center,
                :style => :normal
              }
              pdf.text_box barcode.caption_data, options
            end
          end
        
          pdf.restore_graphics_state
        end
      end
      
      # Draw EAN or UPC symbologies
      def _draw_ean_upc(barcode, pdf)
        if barcode.valid?
          pdf.save_graphics_state

          pdf.fill_color barcode.color

          pdf.transparent barcode.alpha do
            quiet_zone_width_pixels = (barcode.quiet_zone_width * 0.001) * 72.0
            barcode_box_width_pixels = ((barcode.encoded_data.length * barcode.bar_width) * 0.001) * 72.0
            bar_height_pixels = (barcode.bar_height * 0.001) * 72.0
            bar_width_pixels = (barcode.bar_width * 0.001) * 72.0
            caption_size_pixels = ((barcode.caption_size * 0.001) * 72.0)
            caption_height_pixels = ((barcode.caption_height * 0.001) * 72.0)
            encoded_data = barcode.encoded_data
            
            if barcode.data.length == 7 # EAN8
              start_range = (0..3)
              middle_range = (32..35)
              end_range = (65..encoded_data.length)
            elsif barcode.data.length == 11 # UPCA
              start_range = (0..10)
              middle_range = (46..49)
              end_range = (85..encoded_data.length)
            elsif barcode.data.length == 12 # EAN13
              start_range = (0..3)
              middle_range = (46..49)
              end_range = (93..encoded_data.length)
            end
            
            pdf.bounding_box([pdf.bounds.left + quiet_zone_width_pixels, pdf.bounds.top], :width => barcode_box_width_pixels, :height => bar_height_pixels) do
              index = 0
              bar_count = 0
              origin = []
              encoded_data.each_char do |char|
                if char == '1'
                  if bar_count == 0
                    origin = [index * bar_width_pixels, bar_height_pixels]
                  end
                  bar_count += 1
                else
                  if start_range.include?(index) || middle_range.include?(index) || end_range.include?(index)
                    if barcode.captioned
                      pdf.fill_rectangle origin, bar_width_pixels * bar_count, bar_height_pixels + (bar_width_pixels * 5)
                    else
                      pdf.fill_rectangle origin, bar_width_pixels * bar_count, bar_height_pixels
                    end
                  else
                    pdf.fill_rectangle origin, bar_width_pixels * bar_count, bar_height_pixels
                  end
                  bar_count = 0
                end
                index += 1
              end

              if bar_count > 0
                if barcode.captioned
                  pdf.fill_rectangle origin, bar_width_pixels * bar_count, bar_height_pixels + (bar_width_pixels * 5)
                else
                  pdf.fill_rectangle origin, bar_width_pixels * bar_count, bar_height_pixels
                end
              end
            end

            if barcode.captioned
              number_system_options = {
                :at => [pdf.bounds.left, pdf.bounds.top - bar_height_pixels + (caption_height_pixels * 0.5)],
                :width => quiet_zone_width_pixels, 
                :height => caption_height_pixels,
                :overflow => :truncate,
                :size => caption_size_pixels,
                :valign => :center,
                :align => :center,
                :style => :normal
              }
              check_digit_options = {
                :at => [pdf.bounds.left + quiet_zone_width_pixels + barcode_box_width_pixels, pdf.bounds.top - bar_height_pixels + (caption_height_pixels * 0.5)],
                :width => quiet_zone_width_pixels, 
                :height => caption_height_pixels,
                :overflow => :truncate,
                :size => caption_size_pixels,
                :valign => :center,
                :align => :center,
                :style => :normal
              }
              left_hand_options = {
                :at => [pdf.bounds.left + quiet_zone_width_pixels, pdf.bounds.top - bar_height_pixels],
                :width => barcode_box_width_pixels * 0.5, 
                :height => caption_height_pixels,
                :overflow => :truncate,
                :size => caption_size_pixels,
                :valign => :center,
                :align => :center,
                :style => :normal
              }
              right_hand_options = {
                :at => [pdf.bounds.left + quiet_zone_width_pixels + (barcode_box_width_pixels * 0.5), pdf.bounds.top - bar_height_pixels],
                :width => barcode_box_width_pixels * 0.5, 
                :height => caption_height_pixels,
                :overflow => :truncate,
                :size => caption_size_pixels,
                :valign => :center,
                :align => :center,
                :style => :normal
              }
              
              if barcode.data.length == 7 # EAN8
                pdf.text_box barcode.caption_data[0..3], left_hand_options
                pdf.text_box barcode.caption_data[4..7], right_hand_options
              elsif barcode.data.length == 11 # UPCA
                left_hand_options[:at] = [pdf.bounds.left + quiet_zone_width_pixels + (10 * bar_width_pixels), pdf.bounds.top - bar_height_pixels]
                left_hand_options[:width] =  (barcode_box_width_pixels * 0.5) - (10 * bar_width_pixels)
                right_hand_options[:at] = [pdf.bounds.left + quiet_zone_width_pixels + (barcode_box_width_pixels * 0.5), pdf.bounds.top - bar_height_pixels]
                right_hand_options[:width] = barcode_box_width_pixels * 0.5 - (10 * bar_width_pixels)
                
                pdf.text_box barcode.caption_data[0], number_system_options
                pdf.text_box barcode.caption_data[11], check_digit_options
                pdf.text_box barcode.caption_data[1..5], left_hand_options
                pdf.text_box barcode.caption_data[6..10], right_hand_options
              elsif barcode.data.length == 12 # EAN13
                pdf.text_box barcode.caption_data[0], number_system_options
                pdf.text_box barcode.caption_data[1..6], left_hand_options
                pdf.text_box barcode.caption_data[7..12], right_hand_options
              end
            end
          end

          pdf.restore_graphics_state
        end
      end
      
      # Draw PLANET or POSTNET symbologies
      def _draw_planet_postnet(barcode, pdf)
        if barcode.valid?
          pdf.save_graphics_state

          pdf.fill_color barcode.color

          pdf.transparent barcode.alpha do
            barcode_box_width = (barcode.width * 0.001) * 72.0
            full_bar_height_pixels = (125 * 0.001) * 72.0
            half_bar_height_pixels = (50 * 0.001) * 72.0
            bar_width_pixels = (20 * 0.001) * 72.0

            pdf.bounding_box([pdf.bounds.left, pdf.bounds.top], :width => barcode_box_width, :height => full_bar_height_pixels) do
              index = 0
              barcode.encoded_data.each_char do |char|
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
    end
  end
end