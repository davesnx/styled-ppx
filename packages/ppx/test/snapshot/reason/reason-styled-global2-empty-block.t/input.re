/* Empty payload edge cases for styled.global2.

   Both the empty string and a comment-only string parse to an empty
   rule list. The PPX must produce a well-formed module shell with
   to_string returning "", to_buffer adding nothing, and make
   producing an empty <style>. */

module EmptyStyles = [%styled.global2 ""];

module CommentOnly = [%styled.global2 {|
  /* nothing here */
|}];
