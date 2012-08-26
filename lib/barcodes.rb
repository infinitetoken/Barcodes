require 'barcodes/version'
require 'barcodes/symbology'

module Barcodes
  class << self
    def create(symbology, options={})
      case symbology
      when 'Codabar', Barcodes::Symbology::CODABAR
        return Symbology::Codabar.new(options)
      when 'Code11', 'Code 11', 'code11', Barcodes::Symbology::CODE_11
        return Symbology::Code11.new(options)
      when 'Code39', 'Code 39', 'code39', Barcodes::Symbology::CODE_39
        return Symbology::Code39.new(options)
      when 'Code39Mod43', 'Code 39 Mod 43', 'code39mod43', Barcodes::Symbology::CODE_39_MOD_43
        return Symbology::Code39Mod43.new(options)
      when 'Code39Extended', 'Code 39 Extended', 'code39extended', Barcodes::Symbology::CODE_39_EXTENDED
        return Symbology::Code39Extended.new(options)
      when 'Code39ExtendedMod43', 'Code 39 Extended Mod 43', 'code39extendedmod43', Barcodes::Symbology::CODE_39_EXTENDED_MOD_43
        return Symbology::Code39ExtendedMod43.new(options)
      when 'Code93', 'Code 93', 'code93', Barcodes::Symbology::CODE_93
        return Symbology::Code93.new(options)
      when 'Code93Extended', 'Code 93 Extended', 'code93extended', Barcodes::Symbology::CODE_93_EXTENDED
        return Symbology::Code93Extended.new(options)
      when 'Code128', 'Code 128', 'code128', Barcodes::Symbology::CODE_128
        return Symbology::Code128.new(options)
      when 'MSI', 'Modified Plessey', 'msi', Barcodes::Symbology::MSI
        return Symbology::Msi.new(options)
      when 'MSI Mod 10', 'Modified Plessey Mod 10', 'msi_mod_10', Barcodes::Symbology::MSI_MOD_10
        return Symbology::MsiMod10.new(options)
      when 'MSI Mod 11', 'Modified Plessey Mod 11', 'msi_mod_11', Barcodes::Symbology::MSI_MOD_11
        return Symbology::MsiMod11.new(options)
      when 'Standard 2 of 5', 'Industrial 2 of 5', 'standard_2_of_5', 'industrial_2_of_5', Barcodes::Symbology::STANDARD_2_OF_5
        return Symbology::Standard2Of5.new(options)
      when 'Standard 2 of 5 Mod 10', 'Industrial 2 of 5 Mod 10', 'standard_2_of_5_mod_10', 'industrial_2_of_5_mod_10', Barcodes::Symbology::STANDARD_2_OF_5_MOD_10
        return Symbology::Standard2Of5Mod10.new(options)
      when 'Interleaved 2 of 5', 'interleaved_2_of_5', Barcodes::Symbology::INTERLEAVED_2_OF_5
        return Symbology::Interleaved2Of5.new(options)
      when 'Interleaved 2 of 5 Mod 10', 'interleaved_2_of_5 Mod 10', Barcodes::Symbology::INTERLEAVED_2_OF_5_MOD_10
        return Symbology::Interleaved2Of5Mod10.new(options)
      when 'Planet', 'planet', Barcodes::Symbology::PLANET
        return Symbology::Planet.new(options)
      when 'Postnet', 'PostNet', 'postnet', Barcodes::Symbology::POSTNET
        return Symbology::Postnet.new(options)
      else
        raise ArgumentError, 'Unsupported symbology'
      end
    end
  end
end