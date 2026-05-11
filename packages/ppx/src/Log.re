let debug = msg =>
  if (Settings.Get.debug()) {
    Printf.printf("[styled-ppx] %s\n", msg);
  };
