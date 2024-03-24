/* eslint-disable */

// This file has to be targeted to CJS, to keep `require.resolve` untranspiled.
// Otherwise, the file tracing will not work.

import { readdir } from 'fs'
import { join } from 'path'
import { createRequire } from 'node:module';

// https://github.com/shuding/nextra/pull/1168#issuecomment-1374960179
// Make sure to include all languages in the bundle when tracing dependencies.
const require = createRequire(import.meta.url);
const shikiPath = require.resolve('shiki/package.json')
readdir(join(shikiPath, '..', 'languages'), () => null)
