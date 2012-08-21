require 'prawn'

module Barcodes
  module PDF
    class Builder
      attr_accessor :barcode
      
      def initialize(barcode=nil)
        @barcode = barcode
      end
      
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
        
        Prawn::Document.new document_options do |pdf|
          @barcode.draw(pdf)
        end
      end
    end
  end
end