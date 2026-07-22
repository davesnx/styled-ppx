  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module ShoudNotBreakOtherModulesPpxsWithStringAsPayload = [%ppx ""];
  module ShoudNotBreakOtherModulesPpxsWithMultiStringAsPayload = [%ppx
    {| stuff |}
  ];
