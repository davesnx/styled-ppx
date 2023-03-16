/**
 * Copyright 2004-present Facebook. All Rights Reserved.
 */;

/**
FileSystem: Basic file system operations using Path.t as inputs. TODO:
Migrate most of this to the Unix module instead of Pervasives so that
handling of interupt signals is more robust.
*/

type fileStat = Unix.stats;

type queryResultOther =
  | /** Character device */
    CharacterDevice
  | /** Block device */
    BlockDevice
  | /** Named pipe */
    NamedPipe
  | /** Socket */
    Socket;

type queryResult =
  | /** Regular file */
    File(Path.t(Path.absolute), fileStat)
  | /** Directory */
    Dir(Path.t(Path.absolute), fileStat)
  | /** Symbolic link */
    Link(
      Path.t(Path.absolute),
      Path.firstClass,
      fileStat,
    )
  | /** Other Operating System devices */
    Other(
      Path.t(Path.absolute),
      fileStat,
      queryResultOther,
    );

let traverseFileSystemFromPath:
  (~onNode: (queryResult, unit => unit) => unit, Path.t(Path.absolute)) =>
  unit;

let query: Path.t(Path.absolute) => option(queryResult);

let queryExn: Path.t(Path.absolute) => queryResult;

/**
Types of line endings for human viewable/editable files. Windows has a
different representation of line endings.
*/
type lineEnds =
  | PlatformDefault
  | Windows
  | Unix;

type actions =
  | No
  | Read
  | ReadExecute
  | ReadWrite
  | ReadWriteExecute;

type perm = {
  owner: actions,
  group: actions,
  other: actions,
};

/**
Default permissions - execute, read, read = 755.
*/
let defaultPerm: perm;

/**
Reads a human-readable text file at the absolute path. Newlines generated in
the file by Windows will be normalized regardless of the current platform.
Returns `Some(lines)` if the file exists and can be read, else returns
`None`.
*/
let readText: Path.t(Path.absolute) => result(string, exn);
/**
Same as `readText` but raises exception if file cannot be found or is not
readable.
*/
let readTextExn: Path.t(Path.absolute) => string;

/**
Writes text lines to a file intended for human consumption at `path`,
creating it if it needs to be created, and clearing existing contents before
writing. Newlines are inserted after each line, where the platform default
newline is used by default, but can be overridden by specifying
`~lineEnds`.
TODO: Specify and implement behavior when file is an existing symlink
(verify it does/does not traverse it).
*/
let writeText:
  (~lineEnds: lineEnds=?, Path.t(Path.absolute), list(string)) =>
  result(unit, exn);
/**
Like `writeText` but raises exception instead of returning `result`.
*/
let writeTextExn:
  (~lineEnds: lineEnds=?, Path.t(Path.absolute), list(string)) => unit;

/**
Reads the file at the path argument into a string, in binary mode, which means
that line endings are not converted or even considered. If you wish to normalize
line endings, use the `readText` function which returns the lines themselves.
*/
let readBinary: Path.t(Path.absolute) => result(string, exn);
/**
Same as `readBinary` but raises exception if file cannot be found or is not
readable.
*/
let readBinaryExn: Path.t(Path.absolute) => string;

/**
Writes a binary string to a file, creating it if necessary or replacing the
existing file with the string contents.
TODO: Specify and implement behavior when file is an existing symlink
(verify it does/does not traverse it).
*/
let writeBinary: (Path.t(Path.absolute), string) => result(unit, exn);

/**
Like `writeBinary` but raises exception instead of returning `result`.
*/
let writeBinaryExn: (Path.t(Path.absolute), string) => unit;

/**
Reads raw bytes from a file from disk. Newlines are not modified from their
exact form on disk.
*/

/**
Forces removal of directory content recursively that does exists - like "rm
-rf". Will not allow you to specify the root directory, and will raise if the
supplied file node is not a directory. Returns Error if any removal in the tree
fails.
Unlike `rm -r`, it will not remove a symlink at the supplied `path`, it will
return an `Error(exn)` if supplied `path` is a symlink.
Returns `Error(exn)` if the directory does not exist.
*/
let rmDirExn: Path.t(Path.absolute) => unit;

/**
Same as `rmDirExn` but returns `result` type.
*/
let rmDir: Path.t(Path.absolute) => result(unit, exn);

/**
Same as `rmDirExn` but throws if directory not empty.  Note how there
is not `rmEmptyDirIfExistsExn`. If you don't know if a directory
exists, you probably don't know if it is empty.
return an `Error(exn)` if supplied `path` is a symlink.
Returns `Error(exn)` if the directory does not exist.
Returns `Error(exn)` if the directory is not empty.
*/
let rmEmptyDirExn: Path.t(Path.absolute) => unit;

/**
Same as `rmEmptyDirExn` but returns `Error(exn)` if directory not
empty.
*/
let rmEmptyDir: Path.t(Path.absolute) => result(unit, exn);

/**
Delete the file at the path. Returns `Ok()` if file was able to be deleted.
Throws exception if the path points to a directory. Will remove a symlink.
*/
let rm: Path.t(Path.absolute) => result(unit, exn);

/**
Same as `rm` but raises if the file doesn't exist.
*/
let rmExn: Path.t(Path.absolute) => unit;

/**
Ensures a file is deleted if it exists. Returns `Ok()` if file was able to be
deleted, or if it already did not exist at the supplied path. Throws exception
if the path points to a directory. Will remove a symlink.
*/
let rmIfExists: Path.t(Path.absolute) => result(unit, exn);

/**
Same as `rmIfExists` but raises instead of returning `Error`.
*/
let rmIfExistsExn: Path.t(Path.absolute) => unit;

/**
Makes a directory at the path and returns Ok(). Returns Error(_) if a directory
cannot be made at the location for any reason including if a directory already
exists at the `path`, or if the path is occupied by a symlink. `~perm` should
be supplied in the form `{owner: action, group: action, other: action}` where
`action` is `FileSystem.perm = No|Read|ReadExecute|ReadWrite|ReadWriteExecute`.
*/
let mkDir: (~perm: perm=?, Path.t(Path.absolute)) => result(unit, exn);

/**
Same as `mkDir`, but throws instead of returning `Error`. `~perm` should be
supplied in the form `{owner: action, group: action, other: action}` where
`action` is `FileSystem.perm = No|Read|ReadExecute|ReadWrite|ReadWriteExecute`.
*/
let mkDirExn: (~perm: perm=?, Path.t(Path.absolute)) => unit;

/**
Similar to `mkdirp` unix command. Makes all required directories.  Each path
prefix from the supplied path to the root directory must be either
- Non-existent
- Already a directory
- A symlink that transitively points to an existing directory

Otherwise, will return Error()

`~perm` should be of form `{owner:action, group:action, other:action}` where
`action` is `FileSystem.perm = No|Read|ReadExecute|ReadWrite|ReadWriteExecute`.
*/
let mkDirP: (~perm: perm=?, Path.t(Path.absolute)) => result(unit, exn);

/**
The same as `mkDirP` but throws exception instead of returning `Error`.

`~perm` should be of form `{owner:action, group:action, other:action}` where
`action` is `FileSystem.perm = No|Read|ReadExecute|ReadWrite|ReadWriteExecute`.
*/
let mkDirPExn: (~perm: perm=?, Path.t(Path.absolute)) => unit;

/**
Creates symlink from `~from` to `~toTarget` which must be a file. Will unlink
existing symlink at `~from` if necessary, but won't remove files/directories
and returns `Error(e)` in that case.
*/
let link:
  (~from: Path.t(Path.absolute), ~toTarget: Path.t('any)) =>
  result(unit, exn);

/**
Same as `link` but throws exception instead of returning `Error`.
*/
let linkExn: (~from: Path.t(Path.absolute), ~toTarget: Path.t('any)) => unit;

/**
Creates symlink from `~from` to `~toTarget` which must be a directory. Will
unlink existing symlink at `~from` if necessary, but won't remove
files/directories and returns `Error()` in that case.
*/
let linkDir:
  (~from: Path.t(Path.absolute), ~toTarget: Path.t('any)) =>
  result(unit, exn);

/**
Same as `linkDir` but throws exception instead of returning `Error`.
*/
let linkDirExn:
  (~from: Path.t(Path.absolute), ~toTarget: Path.t('any)) => unit;

/**
Reads a symlink, and returns `Error` if no symlink exists at the path.
*/
let readLink: Path.t(Path.absolute) => result(Path.firstClass, exn);

/**
Same as `readLink` but raises exception instead of returning `Error`.
*/
let readLinkExn: Path.t(Path.absolute) => Path.firstClass;

/**
Reads a symlink "transitively" by following links until it reaches a non link.
Returns the absolute path of the final target, along with the final resource at
that final absolute path(`None` means the final symlink pointed to nothing).

Returns `Error` if supplied path is not a symlink or doesn't exist on disk.

Not exposing this in the interface. Use `resolve`/`followList` instead.

let followLink:
  Path.t(Path.absolute) => result(Path.t(Path.absolute), exn);
*/

/**
Same as `readLink` but raises exception instead of returning `Error`. Not
exposing this in the interface. Use `resolve`/`followList` instead.

let followLinkExn: Path.t(Path.absolute) => Path.t(Path.absolute);
*/

/**
Same as `followLink` but accepts any valid paths and follows the path if it
happens to be a symlink. Returns Error if the path supplied does not exist on
disk.

The path returned is not necessarily the "realpath" of the final destination
because the computed path may be inside of a directory that is a symlink.  A
separate call to `realPath` would be required to determine the `realPath`.

It is not guaranteed that the returned paths are realPaths or not - only that
their symlinks have been totally resolved/followed. In non-breaking versions,
the paths may be returned after being processed by `realPath`.

*/
let resolveLink:
  Path.t(Path.absolute) => result(Path.t(Path.absolute), exn);

/**
Same as `resolveLink` but raises exception instead of returning `Error`.
*/
let resolveLinkExn: Path.t(Path.absolute) => Path.t(Path.absolute);

/**
Same as `resolveLink` but returns the path of file/symlink traversal. It does
 *not* include the initial path in that list. This is so that you may pattern
 match on the returned list without the `[]` being meaningless. In this way,
 `links` can tell you everything you need to know about a path's
 linkiness.

The paths returned is not necessarily the "realpath" of the final destination
because the computed path may be inside of a directory that is a symlink. A
separate call to `realPath` would be required to determine the `realPath`.

It is not guaranteed that the returned paths are realPaths or not - only that
their symlinks have been totally resolved/followed. In non-breaking versions,
the paths may be returned after being processed by `realPath`.

    switch(links(myPath)) {
    | Ok([]) => "not a symlink"
    | Ok([hd, ...tl] as lst) => String.concat("->", lst)
    | Error(_) => "path doesn't even exist on file system"
    }

If you only care about the final destination, use `links` instead
because `links` returns a list with the `hd` being the first link, and the last
item in the list being the final destination.

*/
let links:
  Path.t(Path.absolute) => result(list(Path.t(Path.absolute)), exn);

/**
Same as `links` but raises exception instead of returning `Error`.
*/
let linksExn: Path.t(Path.absolute) => list(Path.t(Path.absolute));

/**
Returns the set of paths inside a directory (excluding .. and .) Returns
`Error` if the directory does not exist or the path is not a directory.
Does not return directories in any guaranteed ordering.
*/
let readDir:
  Path.t(Path.absolute) => result(list(Path.t(Path.absolute)), exn);

/**
Returns the set of paths inside a directory (excluding .. and .) Returns
`Error` if the directory does not exist or the path is not a directory.
Does not return directories in any guaranteed ordering.

Same as `readDir` but raises exception instead of returning `Error`.
*/
let readDirExn: Path.t(Path.absolute) => list(Path.t(Path.absolute));

/**
Returns the `perm` for the file at the `Fp` path.
*/
let mode: Path.t(Path.absolute) => result(perm, exn);

/**
Changes the permission for file at `path`.
*/
let changeMode: (perm, Path.t(Path.absolute)) => result(unit, exn);

/**
Same as `mode` but raises exception upon Error.
*/
let modeExn: Path.t(Path.absolute) => perm;

/**
Same as `changeMode` but raises exception upon Error.
*/
let changeModeExn: (perm, Path.t(Path.absolute)) => unit;
