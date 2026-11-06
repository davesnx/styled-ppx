module type Text = Css_merge_core.Text
module type S = Css_merge_core.S

module Make = Css_merge_core.Make

include Make (struct
  let sub = String.sub
  let concat = String.concat
end)
