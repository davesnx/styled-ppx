/** Initialize the test framework.

    Here we are specifying where snapshots should be stored as well as
    the root directory of your project for the formatting of terminal output. */
include Rely.Make({
  let config =
    Rely.TestFrameworkConfig.initialize({
      snapshotDir: "test/_snapshots",
      projectDir: "",
    });
});
