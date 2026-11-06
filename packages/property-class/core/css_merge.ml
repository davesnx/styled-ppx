open Css_class_format

let cell_keys cells =
  List.concat_map
    (fun (prop, ctx) ->
      List.map
        (function Id id -> ctx ^ "#" ^ id | Name name -> ctx ^ "#x" ^ name)
        (Css_cover.leaves prop))
    cells

let normalize_decoded s =
  let toks = Array.of_list (tokens s) in
  let n = Array.length toks in
  let kept = Array.make n true in
  let covered = Hashtbl.create 16 in
  let seen = Hashtbl.create 8 in
  let visit i cells =
    let keys = cell_keys cells in
    if List.for_all (Hashtbl.mem covered) keys then kept.(i) <- false
    else List.iter (fun key -> Hashtbl.replace covered key ()) keys
  in
  for i = n - 1 downto 0 do
    match decode toks.(i) with
    | Foreign | Binding_id _ ->
      if Hashtbl.mem seen toks.(i) then kept.(i) <- false
      else Hashtbl.add seen toks.(i) ()
    | Atom { prop; ctx; _ } -> visit i [ prop, ctx ]
    | Bundle { cells; _ } -> visit i cells
  done;
  let buf = Buffer.create (String.length s) in
  for i = 0 to n - 1 do
    if kept.(i) then (
      if Buffer.length buf > 0 then Buffer.add_char buf ' ';
      Buffer.add_string buf toks.(i))
  done;
  Buffer.contents buf

let table_size = 1295
let digit n = if n < 10 then Char.chr (48 + n) else Char.chr (87 + n)

let id_string p =
  String.init 2 (fun k -> digit (if k = 0 then p / 36 else p mod 36))

let base36 c = if c <= '9' then Char.code c - 48 else Char.code c - 87
let is_base36 c = (c >= '0' && c <= '9') || (c >= 'a' && c <= 'z')

let symbol_index =
  String.init 256 (fun i ->
    let c = Char.chr i in
    if c >= 'A' && c <= 'Z' then Char.chr (i - 65)
    else if c >= 'a' && c <= 'z' then Char.chr (i - 97 + 26)
    else if c >= '0' && c <= '9' then Char.chr (i - 48 + 52)
    else if c = '_' then Char.chr 62
    else if c = '-' then Char.chr 63
    else Char.chr 255)

let sym s pos =
  Char.code
    (String.unsafe_get symbol_index (Char.code (String.unsafe_get s pos)))

let part s pos =
  let a = sym s pos
  and b = sym s (pos + 1)
  and c = sym s (pos + 2) in
  if a lor b lor c > 63 then -1 else (a * 4096) + (b * 64) + c

let plain_part = (52 * 4096) + (52 * 64) + 52
let family_cache = Array.make table_size (-2)

let family p =
  let f = Array.unsafe_get family_cache p in
  if f <> -2 then f
  else (
    let f = Css_cover.family (Id (id_string p)) in
    family_cache.(p) <- f;
    f)

let leaf_cache : int array array = Array.make table_size [||]

let leaves p =
  let l = Array.unsafe_get leaf_cache p in
  if Array.length l > 0 then l
  else (
    let l =
      Array.of_list
        (List.map
           (function
             | Id id -> (base36 id.[0] * 36) + base36 id.[1] | Name _ -> -1)
           (Css_cover.leaves (Id (id_string p))))
    in
    leaf_cache.(p) <- l;
    l)

let stride = 5

type scanned = {
  s : string;
  mutable meta : int array;
  mutable n : int;
  mutable generic : bool;
  mutable canonical : bool;
  mutable nleaves : int;
  mutable nothers : int;
  mutable stop : int;
}

let set meta n start width key a b =
  let base = stride * n in
  Array.unsafe_set meta base start;
  Array.unsafe_set meta (base + 1) width;
  Array.unsafe_set meta (base + 2) key;
  Array.unsafe_set meta (base + 3) a;
  Array.unsafe_set meta (base + 4) b

let rec hash_to_space t s i len h =
  if i < len && String.unsafe_get s i <> ' ' then
    hash_to_space t s (i + 1) len
      (((h * 31) + Char.code (String.unsafe_get s i)) land 0xFFFFFF)
  else (
    t.stop <- i;
    h)

let scan s =
  let len = String.length s in
  let t =
    {
      s;
      meta = [||];
      n = 0;
      generic = false;
      canonical = true;
      nleaves = 0;
      nothers = 0;
      stop = 0;
    }
  in
  let meta = ref (Array.make (stride * 8) 0) in
  let cap = ref 8 in
  let n = ref 0 in
  let i = ref 0 in
  let prev_end = ref (-1) in
  while !i < len do
    if String.unsafe_get s !i = ' ' then incr i
    else (
      let start = !i in
      if start <> !prev_end + 1 then t.canonical <- false;
      if !n = !cap then (
        let bigger = Array.make (stride * 2 * !cap) 0 in
        Array.blit !meta 0 bigger 0 (stride * !cap);
        meta := bigger;
        cap := 2 * !cap);
      let width_atom =
        if String.unsafe_get s start = '_' && start + 1 < len then (
          match String.unsafe_get s (start + 1) with
          | 'a' -> 10
          | 'c' -> 16
          | _ -> 0)
        else 0
      in
      let is_atom =
        width_atom > 0
        && start + width_atom <= len
        && (start + width_atom = len
           || String.unsafe_get s (start + width_atom) = ' ')
        &&
        let hi = String.unsafe_get s (start + 2)
        and lo = String.unsafe_get s (start + 3) in
        is_base36 hi
        && is_base36 lo
        && (not (hi = 'z' && lo = 'z'))
        &&
        if width_atom = 10 then
          part s (start + 4) >= 0 && part s (start + 7) >= 0
        else
          part s (start + 4) >= 0
          && part s (start + 7) >= 0
          && part s (start + 10) >= 0
          && part s (start + 13) >= 0
      in
      if is_atom then (
        let pid =
          (base36 (String.unsafe_get s (start + 2)) * 36)
          + base36 (String.unsafe_get s (start + 3))
        in
        let fam = family pid in
        if fam < 0 then (
          t.generic <- true;
          i := len)
        else (
          let a, b =
            if width_atom = 10 then plain_part, plain_part
            else part s (start + 4), part s (start + 7)
          in
          set !meta !n start width_atom pid a b;
          t.nleaves <- t.nleaves + Array.length (leaves pid);
          incr n;
          prev_end := start + width_atom;
          i := start + width_atom))
      else (
        let h = hash_to_space t s start len 0 in
        let stop = t.stop in
        let width = stop - start in
        if String.unsafe_get s start = '_' && width >= 18 && start + 1 < len
        then (
          let tag = String.unsafe_get s (start + 1) in
          if tag = 'b' || (tag = 'x' && width = 20) then (
            t.generic <- true;
            i := len));
        set !meta !n start width (-h - 1) 0 0;
        t.nothers <- t.nothers + 1;
        incr n;
        prev_end := stop;
        if not t.generic then i := stop))
  done;
  if !prev_end <> len then t.canonical <- false;
  t.meta <- !meta;
  t.n <- !n;
  t

let pow2 x =
  let rec go p = if p >= x then p else go (p * 2) in
  go 4

let same_token s meta i j =
  let wi = Array.unsafe_get meta ((stride * i) + 1) in
  wi = Array.unsafe_get meta ((stride * j) + 1)
  &&
  let si = Array.unsafe_get meta (stride * i)
  and sj = Array.unsafe_get meta (stride * j) in
  let rec go k =
    k >= wi
    || String.unsafe_get s (si + k) = String.unsafe_get s (sj + k)
       && go (k + 1)
  in
  go 0

let rec seen_slot s meta tbl base mask i slot =
  let v = Array.unsafe_get tbl (base + slot) in
  if v = -1 then slot
  else if same_token s meta v i then -1
  else seen_slot s meta tbl base mask i ((slot + 1) land mask)

let cell_hash a b leaf = ((((a * 31) + b) * 31) + leaf) land 0x3FFFFFFF

let rec cell_slot meta tbl mask a b leaf slot =
  let ti = Array.unsafe_get tbl (2 * slot) in
  if ti = -1 then -slot - 1
  else if
    Array.unsafe_get tbl ((2 * slot) + 1) = leaf
    && Array.unsafe_get meta ((stride * ti) + 3) = a
    && Array.unsafe_get meta ((stride * ti) + 4) = b
  then slot
  else cell_slot meta tbl mask a b leaf ((slot + 1) land mask)

let rec all_covered meta tbl mask a b ls k =
  k >= Array.length ls
  ||
  let leaf = Array.unsafe_get ls k in
  cell_slot meta tbl mask a b leaf (cell_hash a b leaf land mask) >= 0
  && all_covered meta tbl mask a b ls (k + 1)

let walk ~sub ~concat t =
  let s = t.s
  and meta = t.meta
  and n = t.n in
  let cslots = pow2 (2 * t.nleaves) in
  let cmask = cslots - 1 in
  let sbase = 2 * cslots in
  let sslots = pow2 (2 * t.nothers) in
  let smask = sslots - 1 in
  let fbase = sbase + sslots in
  let fslots = pow2 (2 * (n - t.nothers)) in
  let fmask = fslots - 1 in
  let tbl = Array.make (fbase + (2 * fslots)) (-1) in
  let universal = ref false in
  for i = 0 to n - 1 do
    let key = Array.unsafe_get meta ((stride * i) + 2) in
    if key >= 0 then (
      let f = family key in
      if f = 0 then universal := true
      else (
        let slot = ref (f land fmask) in
        while
          let v = Array.unsafe_get tbl (fbase + (2 * !slot)) in
          v <> -1 && v <> f
        do
          slot := (!slot + 1) land fmask
        done;
        let at = fbase + (2 * !slot) in
        if tbl.(at) = -1 then (
          tbl.(at) <- f;
          tbl.(at + 1) <- 1)
        else tbl.(at + 1) <- tbl.(at + 1) + 1))
  done;
  let alone key =
    (not !universal)
    &&
    let f = family key in
    let slot = ref (f land fmask) in
    while Array.unsafe_get tbl (fbase + (2 * !slot)) <> f do
      slot := (!slot + 1) land fmask
    done;
    Array.unsafe_get tbl (fbase + (2 * !slot) + 1) = 1
  in
  let dropped = ref false in
  for i = n - 1 downto 0 do
    let base = stride * i in
    let key = Array.unsafe_get meta (base + 2) in
    if key >= 0 && alone key then ()
    else if key < 0 then (
      let slot = seen_slot s meta tbl sbase smask i ((-key - 1) land smask) in
      if slot < 0 then (
        meta.(base) <- -1 - meta.(base);
        dropped := true)
      else tbl.(sbase + slot) <- i)
    else (
      let ls = leaves key in
      let a = Array.unsafe_get meta (base + 3)
      and b = Array.unsafe_get meta (base + 4) in
      if all_covered meta tbl cmask a b ls 0 then (
        meta.(base) <- -1 - meta.(base);
        dropped := true)
      else
        for k = 0 to Array.length ls - 1 do
          let leaf = Array.unsafe_get ls k in
          let slot =
            cell_slot meta tbl cmask a b leaf (cell_hash a b leaf land cmask)
          in
          if slot < 0 then (
            tbl.(2 * (-slot - 1)) <- i;
            tbl.((2 * (-slot - 1)) + 1) <- leaf)
        done)
  done;
  if (not !dropped) && t.canonical then s
  else (
    let parts = ref [] in
    for i = n - 1 downto 0 do
      let start = meta.(stride * i) in
      if start >= 0 then parts := sub s start meta.((stride * i) + 1) :: !parts
    done;
    concat " " !parts)

let rec family_slot tbl mask f slot =
  let v = Array.unsafe_get tbl slot in
  if v = -1 then slot
  else if v = f then -1
  else family_slot tbl mask f ((slot + 1) land mask)

let independent t la =
  let s = t.s
  and meta = t.meta
  and n = t.n in
  let na = ref 0 in
  while !na < n && Array.unsafe_get meta (stride * !na) < la do
    incr na
  done;
  let na = !na in
  let fslots = pow2 (2 * na) in
  let fmask = fslots - 1 in
  let sslots = pow2 (2 * na) in
  let smask = sslots - 1 in
  let tbl = Array.make (fslots + sslots) (-1) in
  let ok = ref true in
  let i = ref 0 in
  while !ok && !i < n do
    let base = stride * !i in
    let key = Array.unsafe_get meta (base + 2) in
    if key < 0 then (
      let h = -key - 1 in
      if !i < na then (
        let slot = seen_slot s meta tbl fslots smask !i (h land smask) in
        if slot >= 0 then tbl.(fslots + slot) <- !i)
      else if seen_slot s meta tbl fslots smask !i (h land smask) < 0 then
        ok := false)
    else (
      let f = family key in
      if f = 0 then ok := false
      else if !i < na then (
        let slot = family_slot tbl fmask f (f land fmask) in
        if slot >= 0 then tbl.(slot) <- f)
      else if family_slot tbl fmask f (f land fmask) < 0 then ok := false);
    incr i
  done;
  !ok

let is_blank s =
  let rec go i =
    i >= String.length s || (String.unsafe_get s i = ' ' && go (i + 1))
  in
  go 0

let is_canonical s =
  let len = String.length s in
  let rec go i =
    i >= len
    || (not
          (String.unsafe_get s i = ' '
          && (i = 0 || i = len - 1 || String.unsafe_get s (i + 1) = ' ')))
       && go (i + 1)
  in
  go 0

let plain s =
  let len = String.length s in
  let ok = ref true in
  let i = ref 0 in
  let prev = ref ' ' in
  while !ok && !i < len do
    let c = String.unsafe_get s !i in
    if c = ' ' then (
      if !i = 0 || !i = len - 1 || String.unsafe_get s (!i + 1) = ' ' then
        ok := false)
    else if !prev = ' ' || !i = 0 then
      if c = '_' && !i + 1 < len then (
        let t = String.unsafe_get s (!i + 1) in
        if t = 'a' || t = 'b' || t = 'c' || t = 'x' then ok := false);
    prev := c;
    incr i
  done;
  !ok

let shares a b =
  let la = String.length a
  and lb = String.length b in
  let found = ref false in
  let j = ref 0 in
  while (not !found) && !j < lb do
    let jb = !j in
    let e = ref jb in
    while !e < lb && String.unsafe_get b !e <> ' ' do
      incr e
    done;
    let wb = !e - jb in
    let c0 = String.unsafe_get b jb in
    let i = ref 0 in
    while (not !found) && !i < la do
      let ia = !i in
      if
        String.unsafe_get a ia = c0
        && ia + wb <= la
        && (ia + wb = la || String.unsafe_get a (ia + wb) = ' ')
      then (
        let k = ref 1 in
        while
          !k < wb
          && String.unsafe_get a (ia + !k) = String.unsafe_get b (jb + !k)
        do
          incr k
        done;
        if !k >= wb then found := true);
      let n = ref ia in
      while !n < la && String.unsafe_get a !n <> ' ' do
        incr n
      done;
      i := !n + 1
    done;
    j := !e + 1
  done;
  !found

let plain_limit = 128

module type Text = sig
  val sub : string -> int -> int -> string
  val concat : string -> string list -> string
end

module type S = sig
  val merge : string -> string -> string
  val normalize : string -> string
end

module Make (T : Text) : S = struct
  let sub = T.sub
  let concat = T.concat

  let normalize s =
    let t = scan s in
    if t.generic then normalize_decoded s else walk ~sub ~concat t

  let merge a b =
    if is_blank b then if is_canonical a then a else normalize a
    else if is_blank a then if is_canonical b then b else normalize b
    else if
      String.length a + String.length b <= plain_limit && plain a && plain b
    then if shares a b then normalize (a ^ " " ^ b) else a ^ " " ^ b
    else (
      let s = a ^ " " ^ b in
      let t = scan s in
      if t.generic then normalize_decoded s
      else if t.canonical && independent t (String.length a) then s
      else walk ~sub ~concat t)
end

include Make (struct
  let sub = String.sub
  let concat = String.concat
end)
