(* @keyframes under [%css] used to be atomized per-frame, emitting two
   same-name @keyframes rules where the second silently replaced the
   first. It now errors like the runtime path, steering to [%keyframe]. *)
let kf = [%css "@keyframes spin { from { opacity: 0; } to { opacity: 1; } }"]
