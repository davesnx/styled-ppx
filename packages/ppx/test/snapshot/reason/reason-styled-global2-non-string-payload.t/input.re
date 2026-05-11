/* Non-string payload to styled.global2.

   The extension only accepts a string literal. Anything else (number,
   identifier, list) hits the catch-all branch and produces a
   Pmod_extension with the "expects a string" message and an example
   of the correct form. */

module BadPayload = [%styled.global2 1];
