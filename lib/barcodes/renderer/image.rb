# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'rmagick'

module Barcodes
  module Renderer
    
    # This class handles PNG rendering support.
    class Image < Pdf
      # Render the barcode as PNG with optional filename
      def render(filename=nil)
        pdf = self.pdf
        self.draw(pdf)
        
        ilist = Magick::ImageList.new
        ilist.from_blob(pdf.render)
        ilist.format="PNG"
        
        unless filename.nil?
          ilist.each_with_index do |image, index|
            image.write(filename)
          end
        else
          ilist.to_blob
        end
      end
    end
  end
end
