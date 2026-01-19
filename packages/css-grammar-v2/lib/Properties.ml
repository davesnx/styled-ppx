module Margin = [%spec_module "[ <length> | <percentage> | 'auto' ]{1,4}"]
module Padding = [%spec_module "[ <length> | <percentage> ]{1,4}"]

module Position =
  [%spec_module "'static' | 'relative' | 'absolute' | 'fixed' | 'sticky'"]

module Line_height =
  [%spec_module "'normal' | <number> | <length> | <percentage>"]

module Color = [%spec_module "<hex-color> | 'currentColor' | 'transparent'"]
module Background_color = Color
