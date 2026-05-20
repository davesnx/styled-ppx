open Types
open Support

module Property_container =
  [%spec_module
  "<'container-name'> [ '/' <'container-type'> ]?", (module Css_types.Container)]

let property_container : property_container Rule.rule = Property_container.rule

module Property_container_name =
  [%spec_module
  "<custom-ident>+ | 'none'", (module Css_types.ContainerName)]

let property_container_name : property_container_name Rule.rule =
  Property_container_name.rule

module Property_container_type =
  [%spec_module
  "'normal' | 'size' | 'inline-size'", (module Css_types.ContainerType)]

let property_container_type : property_container_type Rule.rule =
  Property_container_type.rule

let entries : (kind * packed_rule) list =
  [
    Property "container-type", pack_module (module Property_container_type);
    Property "container", pack_module (module Property_container);
    Property "container-name", pack_module (module Property_container_name);
  ]
