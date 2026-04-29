open Types
open Support
open Functions

let registry : (kind * packed_rule) list =
  List.concat
    [
      Values.entries;
      Functions.entries;
      Media.entries;
      Properties.Moz.entries;
      Properties.Webkit.entries;
      Properties.AccentColor.entries;
      Properties.Align.entries;
      Properties.AlignmentBaseline.entries;
      Properties.All.entries;
      Properties.AnchorName.entries;
      Properties.AnchorScope.entries;
      Properties.Animation.entries;
      Properties.Appearance.entries;
      Properties.AspectRatio.entries;
      Properties.BackdropFilter.entries;
      Properties.BackfaceVisibility.entries;
      Properties.Background.entries;
      Properties.BaselineShift.entries;
      Properties.BaselineSource.entries;
      Properties.BlockSize.entries;
      Properties.BlockOverflow.entries;
      Properties.Border.entries;
      Properties.Bottom.entries;
      Properties.Box.entries;
      Properties.Break.entries;
      Properties.CaptionSide.entries;
      Properties.Caret.entries;
      Properties.Clear.entries;
      Properties.Clip.entries;
      Properties.Color.entries;
      Properties.Column.entries;
      Properties.Columns.entries;
      Properties.Contain.entries;
      Properties.Container.entries;
      Properties.Content.entries;
      Properties.ContentVisibility.entries;
      Properties.Corner.entries;
      Properties.Counter.entries;
      Properties.CustomProperty.entries;
      Properties.Cursor.entries;
      Properties.Cx.entries;
      Properties.Cy.entries;
      Properties.D.entries;
      Properties.Direction.entries;
      Properties.Display.entries;
      Properties.DominantBaseline.entries;
      Properties.DynamicRangeLimit.entries;
      Properties.EmptyCells.entries;
      Properties.FieldSizing.entries;
      Properties.Fill.entries;
      Properties.Filter.entries;
      Properties.Flex.entries;
      Properties.Float.entries;
      Properties.Flow.entries;
      Properties.FloodColor.entries;
      Properties.FloodOpacity.entries;
      Properties.Font.entries;
      Properties.ForcedColorAdjust.entries;
      Properties.Gap.entries;
      Properties.Glyph.entries;
      Properties.Grid.entries;
      Properties.HangingPunctuation.entries;
      Properties.Height.entries;
      Properties.HyphenateCharacter.entries;
      Properties.HyphenateLimitChars.entries;
      Properties.HyphenateLimit.entries;
      Properties.Hyphens.entries;
      Properties.Ime.entries;
      Properties.Image.entries;
      Properties.InitialLetter.entries;
      Properties.InitialLetterAlign.entries;
      Properties.InlineSize.entries;
      Properties.Inset.entries;
      Properties.Interactivity.entries;
      Properties.Interest.entries;
      Properties.InterpolateSize.entries;
      Properties.Isolation.entries;
      Properties.Justify.entries;
      Properties.Left.entries;
      Properties.LetterSpacing.entries;
      Properties.LightingColor.entries;
      Properties.Line.entries;
      Properties.Layout.entries;
      Properties.ListProperties.entries;
      Properties.Margin.entries;
      Properties.Marker.entries;
      Properties.MarkerProperty.entries;
      Properties.Mask.entries;
      Properties.MasonryAutoFlow.entries;
      Properties.Math.entries;
      Properties.Max.entries;
      Properties.Min.entries;
      Properties.MixBlendMode.entries;
      Properties.Nav.entries;
      Properties.Object.entries;
      Properties.Offset.entries;
      Properties.Opacity.entries;
      Properties.Order.entries;
      Properties.Orphans.entries;
      Properties.Outline.entries;
      Properties.Overflow.entries;
      Properties.Overlay.entries;
      Properties.Overscroll.entries;
      Properties.Pause.entries;
      Properties.Padding.entries;
      Properties.Page.entries;
      Properties.PaintOrder.entries;
      Properties.Perspective.entries;
      Properties.PerspectiveOrigin.entries;
      Properties.Place.entries;
      Properties.PointerEvents.entries;
      Properties.Position.entries;
      Properties.PrintColorAdjust.entries;
      Properties.Quotes.entries;
      Properties.R.entries;
      Properties.ReadingFlow.entries;
      Properties.ReadingOrder.entries;
      Properties.Rest.entries;
      Properties.Resize.entries;
      Properties.Right.entries;
      Properties.Rotate.entries;
      Properties.RowGap.entries;
      Properties.Ruby.entries;
      Properties.Rx.entries;
      Properties.Ry.entries;
      Properties.Scale.entries;
      Properties.Scroll.entries;
      Properties.Shape.entries;
      Properties.Size.entries;
      Properties.SpeakAs.entries;
      Properties.StopColor.entries;
      Properties.StopOpacity.entries;
      Properties.Stroke.entries;
      Properties.Syntax.entries;
      Properties.TabSize.entries;
      Properties.TableLayout.entries;
      Properties.Text.entries;
      Properties.TimelineScope.entries;
      Properties.Top.entries;
      Properties.TouchAction.entries;
      Properties.Transform.entries;
      Properties.Transition.entries;
      Properties.Translate.entries;
      Properties.UnicodeBidi.entries;
      Properties.UserSelect.entries;
      Properties.VectorEffect.entries;
      Properties.VerticalAlign.entries;
      Properties.View.entries;
      Properties.Visibility.entries;
      Properties.Voice.entries;
      Properties.Wrap.entries;
      Properties.WhiteSpace.entries;
      Properties.WhiteSpaceCollapse.entries;
      Properties.Widows.entries;
      Properties.Width.entries;
      Properties.WillChange.entries;
      Properties.WordBreak.entries;
      Properties.WordWrap.entries;
      Properties.WordSpacing.entries;
      Properties.WritingMode.entries;
      Properties.XY.entries;
      Properties.ZIndex.entries;
      Properties.Zoom.entries;
      Properties.Media.entries;
      Properties.Descriptors.entries;
      Properties.Legacy.entries;
    ]

let () =
  List.iter
    (fun (kind, rule) ->
      let css_name =
        match kind with
        | Property name -> name
        | Value name -> name
        | Function name -> name
        | Media_query name -> name
      in
      let key =
        match kind with
        (* Properties use prefixed keys to avoid collisions with values. *)
        | Property _ -> "property_" ^ css_name
        | Value _ | Function _ | Media_query _ -> css_name
      in
      Hashtbl.replace registry_tbl key (kind, rule))
    registry

let is_property_kind = function Property _ -> true | _ -> false
let is_value_kind = function Value _ -> true | _ -> false
let is_function_kind = function Function _ -> true | _ -> false
let is_media_query_kind = function Media_query _ -> true | _ -> false

let is_custom_property_name (name : string) : bool =
  String.length name >= 2 && String.sub name 0 2 = "--"

let find_by_key (key : string) : packed_rule option =
  match Hashtbl.find_opt registry_tbl key with
  | Some (_, rule) -> Some rule
  | None -> None

let find_property_with_fallback (name : string) : packed_rule option =
  let key = "property_" ^ name in
  match Hashtbl.find_opt registry_tbl key with
  | Some (_, rule) -> Some rule
  | None when is_custom_property_name name -> find_by_key "property_--*"
  | None -> None

let find_property (name : string) : packed_rule option =
  match find_by_key ("property_" ^ name) with
  | Some _ as rule -> rule
  | None when is_custom_property_name name -> find_by_key "property_--*"
  | None -> None

let find_value (name : string) : packed_rule option = find_by_key name
let find_function (name : string) : packed_rule option = find_by_key name
let find_media_query (name : string) : packed_rule option = find_by_key name

let value_names () : string list =
  Hashtbl.fold
    (fun _key (kind, _rule) acc ->
      match kind with Value name -> name :: acc | _ -> acc)
    registry_tbl []

let function_names () : string list =
  Hashtbl.fold
    (fun _key (kind, _rule) acc ->
      match kind with Function name -> name :: acc | _ -> acc)
    registry_tbl []

let pack_property (packed : packed_rule) : packed_property =
  match packed with
  | Pack_rule { validate; runtime_module_path; infer_interpolation_types; _ } ->
    { validate; infer_interpolation_types; runtime_module_path }

let property_registry : (string, packed_property) Hashtbl.t = Hashtbl.create 500

let () =
  List.iter
    (fun (kind, rule) ->
      match kind with
      | Property name ->
        Hashtbl.replace property_registry name (pack_property rule)
      | _ -> ())
    registry

let find_property_packed_with_wildcard (name : string) : packed_property option
    =
  match Hashtbl.find_opt property_registry name with
  | Some _ as rule -> rule
  | None when is_custom_property_name name ->
    Hashtbl.find_opt property_registry "--*"
  | None -> None

let property_names () : string list =
  Hashtbl.fold (fun name _ acc -> name :: acc) property_registry []

let suggest_property_name (name : string) : string option =
  property_names () |> Levenshtein.find_closest_match name

let validate_property ~loc ~name
  (value : Styled_ppx_css_parser.Ast.component_value_list) :
  ( unit,
    Styled_ppx_css_parser.Ast.loc
    * [> `Invalid_value of Rule.error_info | `Property_not_found ] )
  result =
  match find_property_packed_with_wildcard name with
  | Some prop ->
    (match prop.validate value with
    | Ok () -> Ok ()
    | Error error_info ->
      let universal_rule =
        Combinators.xor
          [
            Rule.Match.map Css_value_types.interpolation (fun _ -> ());
            Rule.Match.map Css_value_types.css_wide_keywords (fun _ -> ());
            Rule.Match.map function_var (fun _ -> ());
          ]
      in
      (match Rule.run universal_rule value with
      | Ok _ -> Ok ()
      | Error _ -> Error (loc, `Invalid_value error_info)))
  | None -> Error (loc, `Property_not_found)

let infer_interpolation_types ~name
  (value : Styled_ppx_css_parser.Ast.component_value_list) :
  (string * string) list =
  match find_property_packed_with_wildcard name with
  | Some prop -> prop.infer_interpolation_types value
  | None -> []

let type_check (rule_parser : 'a Rule.rule) input = Rule.run rule_parser input

let find_property_packed (name : string) : packed_property option =
  find_property_packed_with_wildcard name
