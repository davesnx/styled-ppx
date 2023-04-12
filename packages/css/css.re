/* This library is copied from https://github.com/ml-in-barcelona/server-reason-react/tree/b06ed5c48949fafa7c01e6313410129f3a10a983/lib/bs_css */

include Properties;
include Colors;

/* We might want to expose rule instead of the entire module
   `type rule = Rule.t;` */
module Rule = Rule;

/* Added for legacy pruposes, bs-css have both APIs,
   in the future this goes to the trash */
module CssJs = {
  include Properties;
  include Colors;
};
