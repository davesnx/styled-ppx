let kf = [%keyframe {|
  0% { opacity: 0 }
  100% { opacity: 1 }
|}];
let fade = [%css "animation-name: $(kf)"];
