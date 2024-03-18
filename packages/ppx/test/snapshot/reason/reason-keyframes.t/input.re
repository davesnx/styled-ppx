let animation = [%keyframe {|
  0% { opacity: 0 }
  100% { opacity: 1 }
|}];

module FadeIn = [%styled.section {|
  animation-name: $(animation);
|}];
