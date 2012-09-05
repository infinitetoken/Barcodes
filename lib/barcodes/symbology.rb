# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/codabar'
require 'barcodes/symbology/code11'
require 'barcodes/symbology/code39'
require 'barcodes/symbology/code39mod43'
require 'barcodes/symbology/code39extended'
require 'barcodes/symbology/code39extendedmod43'
require 'barcodes/symbology/code93'
require 'barcodes/symbology/code93extended'
require 'barcodes/symbology/code128'
require 'barcodes/symbology/ean8'
require 'barcodes/symbology/ean13'
require 'barcodes/symbology/msi'
require 'barcodes/symbology/msimod10'
require 'barcodes/symbology/msimod11'
require 'barcodes/symbology/standard2of5'
require 'barcodes/symbology/standard2of5mod10'
require 'barcodes/symbology/interleaved2of5'
require 'barcodes/symbology/interleaved2of5mod10'
require 'barcodes/symbology/planet'
require 'barcodes/symbology/postnet'
require 'barcodes/symbology/upca'

module Barcodes
  module Symbology
    CODABAR = ['Codabar', 'codabar']
    CODE_11 = ['Code11', 'Code 11', 'code11', 'code_11']
    CODE_39 = ['Code39', 'Code 39', 'code39', 'code_39']
    CODE_39_MOD_43 = ['Code39Mod43', 'Code 39 Mod 43', 'code39mod43', 'code_39_mod_43']
    CODE_39_EXTENDED = ['Code39Extended', 'Code 39 Extended', 'code39extended', 'code_39_extended']
    CODE_39_EXTENDED_MOD_43 = ['Code39ExtendedMod43', 'Code 39 Extended Mod 43', 'code39extendedmod43', 'code_39_extended_mod_43']
    CODE_93 = ['Code93', 'Code 93', 'code93', 'code_93']
    CODE_93_EXTENDED = ['Code93Extended', 'Code 93 Extended', 'code93extended', 'code_93_extended']
    CODE_128 = ['Code128', 'Code 128', 'code128', 'code_128']
    EAN_8 = ['EAN8', 'EAN 8', 'EAN-8', 'ean8', 'ean_8']
    EAN_13 = ['EAN13', 'EAN 13', 'EAN-13', 'ean13', 'ean_13']
    MSI = ['MSI', 'Modified Plessey', 'msi']
    MSI_MOD_10 = ['MSI Mod 10', 'Modified Plessey Mod 10', 'msimod10', 'msi_mod_10']
    MSI_MOD_11 = ['MSI Mod 11', 'Modified Plessey Mod 11', 'msimod11', 'msi_mod_11']
    STANDARD_2_OF_5 = ['Standard2of5', 'Standard 2 of 5', 'standard2of5', 'standard_2_of_5']
    STANDARD_2_OF_5_MOD_10 = ['Standard2of5Mod10', 'Standard 2 of 5 Mod 10', 'standard2of5mod10', 'standard_2_of_5_mod_10']
    INTERLEAVED_2_OF_5 = ['Interleaved2of5', 'Interleaved 2 of 5', 'interleaved2of5', 'interleaved_2_of_5']
    INTERLEAVED_2_OF_5_MOD_10 = ['Interleaved2of5Mod10', 'Interleaved 2 of 5 Mod 10', 'interleaved2of5mod10', 'interleaved_2_of_5_mod_10']
    PLANET = ['Planet', 'PLANET', 'planet']
    POSTNET = ['Postnet', 'POSTNET', 'postnet']
    UPC_A = ['UPCA', 'UPC-A', 'upca', 'upc_a']
  end
end