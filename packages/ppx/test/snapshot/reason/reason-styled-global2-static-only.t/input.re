/* styled.global2 with no interpolations.

   Pure static block: every rule rides on the [@@@css ...] channel,
   to_string returns "" (no dynamic_rules to render), and make produces
   an empty <style>. The module shape is still emitted - users may
   still call ThemeStyles.to_string () or mount <ThemeStyles.make />,
   they'll just get an empty CSS string back. */

module ResetStyles = [%styled.global2 {|
  html {
    box-sizing: border-box;
  }
  body {
    margin: 0;
    font-family: system-ui, sans-serif;
  }
  *, *::before, *::after {
    box-sizing: inherit;
  }
|}];
