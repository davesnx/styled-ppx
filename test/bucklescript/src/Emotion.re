let loadSerializer = [%bs.raw "
function () {
  var serializer = require('jest-emotion');
  expect.addSnapshotSerializer(serializer);
}
"];