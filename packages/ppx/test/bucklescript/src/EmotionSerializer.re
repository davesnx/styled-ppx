let load = [%bs.raw "
function () {
  var serializer = require('jest-emotion');
  expect.addSnapshotSerializer(serializer);
}
"];
