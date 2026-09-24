/* var() with an explicitly empty fallback (valid per css-variables-1:
   the fallback is <declaration-value>?, which may be empty). */
[%css {|color: var(--x)|}];
[%css {|color: var(--x,)|}];
[%css {|color: var(--x, )|}];
[%css {|margin: var(--m, 1px 2px)|}];
[%css {|color: var(--x, var(--y,))|}];
