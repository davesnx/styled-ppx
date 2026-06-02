/* Empty payload edge cases for styled.global.

   Both the empty string and a comment-only string parse to an empty
   rule list. The PPX must produce a well-formed module shell with
   to_string returning "" and make
   producing an empty <style>. */

module EmptyStyles = [%styled.global ""];

module CommentOnly = [%styled.global {|
  /* nothing here */
|}];
