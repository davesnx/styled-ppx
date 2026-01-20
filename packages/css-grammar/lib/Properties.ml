(* Box Model *)
module Margin = [%spec_module "[ <length> | <percentage> | 'auto' ]{1,4}"]
module Margin_top = [%spec_module "<length> | <percentage> | 'auto'"]
module Margin_right = [%spec_module "<length> | <percentage> | 'auto'"]
module Margin_bottom = [%spec_module "<length> | <percentage> | 'auto'"]
module Margin_left = [%spec_module "<length> | <percentage> | 'auto'"]

module Padding = [%spec_module "[ <length> | <percentage> ]{1,4}"]
module Padding_top = [%spec_module "<length> | <percentage>"]
module Padding_right = [%spec_module "<length> | <percentage>"]
module Padding_bottom = [%spec_module "<length> | <percentage>"]
module Padding_left = [%spec_module "<length> | <percentage>"]

module Width = [%spec_module "<length> | <percentage> | 'auto'"]
module Height = [%spec_module "<length> | <percentage> | 'auto'"]
module Min_width = [%spec_module "<length> | <percentage> | 'auto'"]
module Min_height = [%spec_module "<length> | <percentage> | 'auto'"]
module Max_width = [%spec_module "<length> | <percentage> | 'none'"]
module Max_height = [%spec_module "<length> | <percentage> | 'none'"]

(* Positioning *)
module Position = [%spec_module "'static' | 'relative' | 'absolute' | 'fixed' | 'sticky'"]
module Top = [%spec_module "<length> | <percentage> | 'auto'"]
module Right = [%spec_module "<length> | <percentage> | 'auto'"]
module Bottom = [%spec_module "<length> | <percentage> | 'auto'"]
module Left = [%spec_module "<length> | <percentage> | 'auto'"]
module Z_index = [%spec_module "'auto' | <integer>"]

(* Display *)
module Display = [%spec_module "'block' | 'inline' | 'inline-block' | 'flex' | 'inline-flex' | 'grid' | 'none'"]
module Visibility = [%spec_module "'visible' | 'hidden' | 'collapse'"]
module Opacity = [%spec_module "<number>"]
module Overflow = [%spec_module "[ 'visible' | 'hidden' | 'scroll' | 'auto' ]{1,2}"]

(* Flexbox *)
module Flex_direction = [%spec_module "'row' | 'row-reverse' | 'column' | 'column-reverse'"]
module Flex_wrap = [%spec_module "'nowrap' | 'wrap' | 'wrap-reverse'"]
module Justify_content = [%spec_module "'flex-start' | 'flex-end' | 'center' | 'space-between' | 'space-around'"]
module Align_items = [%spec_module "'stretch' | 'flex-start' | 'flex-end' | 'center' | 'baseline'"]
module Align_self = [%spec_module "'auto' | 'stretch' | 'flex-start' | 'flex-end' | 'center' | 'baseline'"]
module Flex_grow = [%spec_module "<number>"]
module Flex_shrink = [%spec_module "<number>"]
module Flex_basis = [%spec_module "<length> | <percentage> | 'auto'"]
module Order = [%spec_module "<integer>"]
module Gap = [%spec_module "[ <length> | <percentage> ]{1,2}"]

(* Typography *)
module Font_size = [%spec_module "<length> | <percentage> | 'small' | 'medium' | 'large'"]
module Font_weight = [%spec_module "<number> | 'normal' | 'bold'"]
module Font_style = [%spec_module "'normal' | 'italic' | 'oblique'"]
module Line_height = [%spec_module "'normal' | <number> | <length> | <percentage>"]
module Letter_spacing = [%spec_module "'normal' | <length>"]
module Text_align = [%spec_module "'left' | 'right' | 'center' | 'justify'"]
module Text_decoration = [%spec_module "'none' | 'underline' | 'overline' | 'line-through'"]
module Text_transform = [%spec_module "'none' | 'capitalize' | 'uppercase' | 'lowercase'"]
module White_space = [%spec_module "'normal' | 'nowrap' | 'pre' | 'pre-wrap' | 'pre-line'"]

(* Colors *)
module Color = [%spec_module "<hex-color> | 'currentColor' | 'transparent'"]
module Background_color = Color

(* Borders *)
module Border_width = [%spec_module "[ <length> | 'thin' | 'medium' | 'thick' ]{1,4}"]
module Border_style = [%spec_module "[ 'none' | 'solid' | 'dashed' | 'dotted' ]{1,4}"]
module Border_color = [%spec_module "[ <hex-color> | 'currentColor' | 'transparent' ]{1,4}"]
module Border_radius = [%spec_module "[ <length> | <percentage> ]{1,4}"]

(* Background *)
module Background_image = [%spec_module "'none' | <url>"]
module Background_size = [%spec_module "[ <length> | <percentage> | 'auto' | 'cover' | 'contain' ]+"]
module Background_repeat = [%spec_module "'repeat' | 'repeat-x' | 'repeat-y' | 'no-repeat'"]

(* Cursor *)
module Cursor = [%spec_module "'auto' | 'default' | 'pointer' | 'text' | 'wait' | 'move'"]
module Pointer_events = [%spec_module "'auto' | 'none'"]
module User_select = [%spec_module "'auto' | 'none' | 'text' | 'all'"]

(* Box Sizing *)
module Box_sizing = [%spec_module "'content-box' | 'border-box'"]
module Object_fit = [%spec_module "'fill' | 'contain' | 'cover' | 'none' | 'scale-down'"]

(* Float and Clear *)
module Float = [%spec_module "'left' | 'right' | 'none'"]
module Clear = [%spec_module "'none' | 'left' | 'right' | 'both'"]

(* Table *)
module Table_layout = [%spec_module "'auto' | 'fixed'"]
module Border_collapse = [%spec_module "'collapse' | 'separate'"]

(* Transitions *)
module Transition_duration = [%spec_module "<time>"]
module Transition_delay = [%spec_module "<time>"]

(* Others *)
module Content = [%spec_module "'none' | 'normal' | <string>"]
module Resize = [%spec_module "'none' | 'both' | 'horizontal' | 'vertical'"]
