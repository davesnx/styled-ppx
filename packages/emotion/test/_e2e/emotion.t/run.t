$ cat >index.js <<EOF
> const emotion = require("@emotion/css");
> console.log(emotion.css({ "display": "flex" }));
> EOF

$ node index.js
css-17vxl0k

  $ ls ../../..

$ ./test_hasher_js.js "padding:0;"
7yrjag

  $ test_hasher_ml "padding:0;"
  7yrjag
