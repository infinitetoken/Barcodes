# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License
       
require 'barcodes/version'
require 'barcodes/symbology'
require 'barcodes/renderer'

# Barcodes is a RubyGem for creating and rendering common barcode symbologies. Here are some of the current features:
# 
# * Many common symbologies to choose from
# * PDF and ASCII rendering support
# * Command line interface for rendering barcodes to console or file
# 
# Currently supported symbologies:
# 
# * Code 11
# * Code 128
# * Code 39
# * Code 39 Mod 43
# * Code 39 Extended
# * Code 39 Extended Mod 43
# * Code 93
# * Code 93 Extended
# * EAN8
# * EAN13
# * Interleaved 2 of 5
# * Interleaved 2 of 5 Mod 10
# * MSI
# * MSI Mod 10
# * MSI Mod 11
# * PLANET
# * POSTNET
# * Standard 2 of 5
# * Standard 2 of 5 Mod 10
# * UPC-A

module Barcodes
  
  # This class is a helper for quickly instantiating
  # a concrete barcode class and also provides a helper
  # for quick rendering.
  class << self
    
    # Creates a new barcode of type <symbology> with given
    # options and returns an instantiated instance.
    # 
    # See Barcodes::Symbology::Base for options
    def create(symbology, options={})
      if Symbology::CODABAR.include? symbology
        return Symbology::Codabar.new(options)
      elsif Symbology::CODE_11.include? symbology
        return Symbology::Code11.new(options)
      elsif Symbology::CODE_39.include? symbology
        return Symbology::Code39.new(options)
      elsif Symbology::CODE_39_MOD_43.include? symbology
        return Symbology::Code39Mod43.new(options)
      elsif Symbology::CODE_39_EXTENDED.include? symbology
        return Symbology::Code39Extended.new(options)
      elsif Symbology::CODE_39_EXTENDED_MOD_43.include? symbology
        return Symbology::Code39ExtendedMod43.new(options)
      elsif Symbology::CODE_93.include? symbology
        return Symbology::Code93.new(options)
      elsif Symbology::CODE_93_EXTENDED.include? symbology
        return Symbology::Code93Extended.new(options)
      elsif Symbology::CODE_128.include? symbology
        return Symbology::Code128.new(options)
      elsif Symbology::EAN_8.include? symbology
        return Symbology::Ean8.new(options)
      elsif Symbology::EAN_13.include? symbology
        return Symbology::Ean13.new(options)
      elsif Symbology::MSI.include? symbology
        return Symbology::Msi.new(options)
      elsif Symbology::MSI_MOD_10.include? symbology
        return Symbology::MsiMod10.new(options)
      elsif Symbology::MSI_MOD_11.include? symbology
        return Symbology::MsiMod11.new(options)
      elsif Symbology::STANDARD_2_OF_5.include? symbology
        return Symbology::Standard2Of5.new(options)
      elsif Symbology::STANDARD_2_OF_5_MOD_10.include? symbology
        return Symbology::Standard2Of5Mod10.new(options)
      elsif Symbology::INTERLEAVED_2_OF_5.include? symbology
        return Symbology::Interleaved2Of5.new(options)
      elsif Symbology::INTERLEAVED_2_OF_5_MOD_10.include? symbology
        return Symbology::Interleaved2Of5Mod10.new(options)
      elsif Symbology::PLANET.include? symbology
        return Symbology::Planet.new(options)
      elsif Symbology::POSTNET.include? symbology
        return Symbology::Postnet.new(options)
      elsif Symbology::UPC_A.include? symbology
        return Symbology::UpcA.new(options)
      else
        raise ArgumentError, 'Unsupported symbology'
      end
      
      # Creates a new barcode of type <symbology> with given
      # options and renders barcode.
      #
      # Optionally takes <filename>. If no
      # filename is given rendering will be outputted as a
      # string.
      #
      # Uses PDF renderer by default.
      # 
      # See Barcodes::Symbology::Base for options
      def render(symbology, filename=nil, options={})
        Barcodes::Renderer::Pdf.new(self.create(symbology, options)).render(filename)
      end
    end
  end
end