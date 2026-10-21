/* Family atoms: two declarations in one context share an atom when their
   COVERED LEAF PROPERTIES overlap, taken transitively - not merely
   because they share a property family. Sharing a family is necessary
   but not sufficient: `padding-left`/`padding-right` are both in the
   "padding" family but cover disjoint leaves, so they stay separate
   atoms (see `packages/ppx/slot_key`'s `leaves_of`/family model). */

/* Shorthand followed by one of its own longhands: margin's full leaf set
   includes margin-top, so they overlap - one atom, author order. */
let shorthandThenLonghand = [%css {|
  margin: 10px;
  margin-top: 0;
|}];

/* Longhand followed by the shorthand: still one atom, order as written -
   overlap grouping never reorders; the shorthand does not "win" a
   position just because it is a shorthand. */
let longhandThenShorthand = [%css {|
  margin-top: 0;
  margin: 10px;
|}];

/* margin overlaps both margin-top and margin-left directly: still one
   atom, all three declarations in order. */
let threeMembers = [%css {|
  margin: 10px;
  margin-top: 0;
  margin-left: 5px;
|}];

/* Unrelated properties never merge: color and margin-top share no leaves
   at all, so they stay two atoms. */
let unrelatedProperties = [%css {|
  color: red;
  margin-top: 0;
|}];

/* Two different families' longhands don't cross-merge either: margin-top
   and padding-top cover disjoint leaves in unrelated families. */
let crossFamilyIndependence = [%css {|
  margin-top: 0;
  padding-top: 0;
|}];

/* Overlap grouping composes with a real selector context, not just the
   base one - the group is still scoped to one block. */
let underSelector = [%css {|
  &:hover {
    margin: 10px;
    margin-top: 0;
  }
|}];

/* Same family, DISJOINT leaves: padding-left and padding-right are both
   in the "padding" family but cover no common leaf (each is its own
   single leaf), so they stay two atoms - grouping them would make a
   future `CSS.merge` too coarse: dropping only the overlapping side
   would no longer be possible if both lived in one atom. */
let sameFamilyDisjointLeaves = [%css {|
  padding-left: 0;
  padding-right: 0;
|}];

/* Same family, still no overlap: border-top's three leaves (its own
   width/style/color) share nothing with border-left-width, a single
   leaf on a different side. Two atoms. */
let sameFamilyNoOverlap = [%css {|
  border-top: 1px solid red;
  border-left-width: 2px;
|}];

/* border's full leaf set includes border-left-width, so this DOES
   overlap: one atom. */
let sameFamilyOverlapViaShorthand = [%css {|
  border: 1px solid blue;
  border-left-width: 2px;
|}];

/* Transitivity: border-top and border-left-width do not overlap each
   other directly (see sameFamilyNoOverlap above), but the bare `border`
   declaration between them overlaps BOTH, so all three still group into
   one atom - a bridging declaration pulls in everything it overlaps,
   not just its own direct neighbors. */
let transitiveBridge = [%css {|
  border-top: 1px solid red;
  border: 2px dashed blue;
  border-left-width: 3px;
|}];
