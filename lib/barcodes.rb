require 'barcodes/version'
require 'barcodes/symbology'
require 'barcodes/renderer'

module Barcodes
  class << self
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
    end
    
    def render(symbology, filename=nil, options={}, renderer=Barcodes::Renderer::PDF)
      if renderer == Barcodes::Renderer::ASCII
        Barcodes::Renderer::Ascii.new(self.create(symbology, options)).render(filename)
      elsif renderer == Barcodes::Renderer::PDF
        Barcodes::Renderer::Pdf.new(self.create(symbology, options)).render(filename)
      end
    end
  end
end