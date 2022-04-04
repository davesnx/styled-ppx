let load = %raw("
function () {
  var serializer = require('jest-emotion');
  expect.addSnapshotSerializer(serializer);
}
")
