let keyword: string => Rule.rule(unit);

let comma: Rule.rule(unit);

let delim: string => Rule.rule(unit);

let function_call: (string, Rule.rule('a)) => Rule.rule('a);

let integer: Rule.rule(int);

let number: Rule.rule(float);

let length:
  Rule.rule(
    [>
      | `Cap(float)
      | `Ch(float)
      | `Em(float)
      | `Ex(float)
      | `Ic(float)
      | `Lh(float)
      | `Rcap(float)
      | `Rch(float)
      | `Rem(float)
      | `Rex(float)
      | `Ric(float)
      | `Rlh(float)
      | `Vh(float)
      | `Vw(float)
      | `Vmax(float)
      | `Vmin(float)
      | `Vb(float)
      | `Vi(float)
      | `Cqw(float)
      | `Cqh(float)
      | `Cqi(float)
      | `Cqb(float)
      | `Cqmin(float)
      | `Cqmax(float)
      | `Px(float)
      | `Cm(float)
      | `Mm(float)
      | `Q(float)
      | `In(float)
      | `Pc(float)
      | `Pt(float)
      | `Zero
    ],
  );

let angle:
  Rule.rule(
    [>
      | `Deg(float)
      | `Grad(float)
      | `Rad(float)
      | `Turn(float)
    ],
  );

let time:
  Rule.rule(
    [>
      | `Ms(float)
      | `S(float)
    ],
  );

let frequency:
  Rule.rule(
    [>
      | `Hz(float)
      | `KHz(float)
    ],
  );

let resolution:
  Rule.rule(
    [>
      | `Dpcm(float)
      | `Dpi(float)
      | `Dppx(float)
    ],
  );

let percentage: Rule.rule(float);

let ident: Rule.rule(string);

let css_wide_keywords:
  Rule.rule(
    [>
      | `Inherit
      | `Initial
      | `Revert
      | `RevertLayer
      | `Unset
    ],
  );

let custom_ident: Rule.rule(string);
let custom_ident_without_span_or_auto: Rule.rule(string);

let dashed_ident: Rule.rule(string);

let string: Rule.rule(string);

let url_no_interp: Rule.rule(string);

/* let var: Rule.rule(string); */

let hex_color: Rule.rule(string);

let interpolation: Rule.rule(list(string));

let media_type: Rule.rule(string);

let container_name: Rule.rule(string);

let flex_value: Rule.rule([> | `Fr(float)]);

let invalid: Rule.rule(unit);

let string_token: Rule.rule(string);

let ident_token: Rule.rule(string);

let declaration_value: Rule.rule(unit);

let positive_integer: Rule.rule(int);

let function_token: Rule.rule(unit);

let any_value: Rule.rule(unit);

let hash_token: Rule.rule(unit);

let zero: Rule.rule(unit);

let custom_property_name: Rule.rule(unit);

let declaration_list: Rule.rule(unit);

let name_repeat: Rule.rule(unit);

let ratio: Rule.rule(unit);

let an_plus_b: Rule.rule(unit);

let declaration: Rule.rule(unit);

let y: Rule.rule(unit);

let x: Rule.rule(unit);

let decibel: Rule.rule(unit);

let urange: Rule.rule(unit);

let semitones: Rule.rule(unit);

let url_token: Rule.rule(unit);
