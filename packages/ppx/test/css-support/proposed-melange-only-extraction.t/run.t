This test demonstrates a proposed solution where CSS extraction happens only for melange.emit stanzas.
The PPX would need to detect the build context and behave differently.

Proposed Implementation Strategy:
=================================

Option 1: Use a flag to indicate melange.emit context
------------------------------------------------------
  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > (using melange 0.1)
  > EOF

Library build (without CSS extraction):
  $ cat > lib.re << 'EOF'
  > let buttonStyle = [%cx2 {|
  >   background: blue;
  >   color: white;
  >   padding: 10px;
  > |}];
  > EOF

  $ refmt --parse re --print ml lib.re > lib.ml

Simulate library build WITHOUT --output flag (proposed behavior):
  $ standalone --impl lib.ml -o lib_processed.ml 2>&1 | grep -i "css" || echo "No CSS generation for library"
  No CSS generation for library

Melange.emit build (WITH CSS extraction):
  $ cat > app.re << 'EOF'
  > let appStyle = [%cx2 {|
  >   font-family: sans-serif;
  >   max-width: 1200px;
  > |}];
  > 
  > /* Using styles from lib */
  > let button = <button className=Lib.buttonStyle />;
  > EOF

  $ refmt --parse re --print ml app.re > app.ml

Simulate melange.emit build WITH --output flag (or special flag):
  $ standalone --impl app.ml -o app_processed.ml --output=./melange-app-css 2>&1 | grep -i css || echo "CSS generated for melange.emit"
  No CSS messages

Expected behavior:
  $ ls melange-app-css/styles.css 2>/dev/null || echo "CSS file should be generated here for melange.emit"
  CSS file should be generated here for melange.emit

Option 2: Environment variable approach
----------------------------------------

Set environment for library builds:
  $ STYLED_PPX_CONTEXT=library standalone --impl lib.ml -o lib_env.ml 2>&1 | grep -i css || echo "No CSS for library context"
  No CSS for library context

Set environment for melange.emit builds:
  $ STYLED_PPX_CONTEXT=melange_emit standalone --impl app.ml -o app_env.ml --output=./emit-css 2>&1 | grep -i css || echo "CSS generated for melange.emit context"
  No CSS messages

Option 3: Dune integration (ideal solution)
--------------------------------------------

The ideal solution would be for dune to automatically pass different flags/options
to the PPX based on the stanza type:

For (library ...) stanzas:
- PPX runs in "library mode" - transforms cx2 to runtime code but doesn't generate CSS files
- Styles are collected/registered in memory or a temporary manifest

For (melange.emit ...) stanzas:
- PPX runs in "emit mode" - transforms cx2 AND generates CSS files
- Collects styles from the current module AND all dependencies
- Writes a single CSS file with all extracted styles

Benefits of this approach:
1. No duplicate CSS generation
2. Single CSS bundle per application
3. Libraries remain side-effect free
4. Tree-shaking potential (only include used styles)
5. Better caching (library styles cached until changed)

Implementation considerations:
1. Need to distinguish build context (library vs melange.emit)
2. Need to collect styles from dependencies
3. Need to handle style deduplication
4. Need to maintain insertion order for cascade

Clean up:
  $ rm -rf *.re *.ml *-css dune-project
