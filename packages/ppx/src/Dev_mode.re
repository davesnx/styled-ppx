let marker_prefix = "cx-";

let marker = name =>
  switch (Settings.Get.dev(), name) {
  | (true, Some(n)) when n != "_" => Some(marker_prefix ++ n)
  | _ => None
  };
