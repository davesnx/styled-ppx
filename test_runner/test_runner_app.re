/** Main entry point for our test runner.

    This simply calls the test framework CLI defined by Rely in the test
    library.

    We separate the test runner binary and the test library so that we can link
    all the modules in the library when compiling. This allows us to discover
    all the test automatically, instead of having to manually include them. */
Re_styled_ppx_test.Test_framework.cli();
