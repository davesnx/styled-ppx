/* This library is copied from https://github.com/ml-in-barcelona/server-reason-react/tree/b06ed5c48949fafa7c01e6313410129f3a10a983/lib/bs_css */

/* Here we only care about the type-check, so Declarations are kebab-case while
in https://github.com/giraud/bs-css they are camelCase to match the Object API from emotion */

module CssJs = {
  module Rule = Rule;
  include Properties;
  include Colors;
};
