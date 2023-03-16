open Ppxlib;

type alias = option(string);
type eventType =
  | Animation
  | Clipboard
  | Composition
  | Focus
  | Form
  | Keyboard
  | Media
  | Mouse
  | Selection
  | Touch
  | Transition
  | UI
  | Wheel;

type event = {
  name: string,
  type_: eventType,
};

type attributeType =
  | Bool
  | Float
  | Int
  | String
  | Style;

type attr = {
  name: string,
  type_: attributeType,
  alias,
};
type domProp =
  | Event(event)
  | Attribute(attr);

let get: list(string) => list(domProp);
let attributeTypeToIdent: attributeType => longident;
let eventTypeToIdent: eventType => longident;
