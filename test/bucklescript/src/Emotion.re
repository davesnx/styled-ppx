let loadSerializer = [%bs.raw "
function loadEmotionSerializer () {
  var serializer = require('jest-emotion');
  expect.addSnapshotSerializer(serializer);
}
"];