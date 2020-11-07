include Rely.Make({
  let config =
    Rely.TestFrameworkConfig.initialize({
      snapshotDir: "test/native/lib/__snapshots",
      projectDir: "test/native",
    });
});
