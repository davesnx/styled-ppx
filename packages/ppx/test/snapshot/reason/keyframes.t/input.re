let animation = [%keyframe {|
  /* comments */
  /* comments */
  0% { opacity: 0 }
  /* comments */
  /* comments */
  100% { opacity: 1 }
|}];

module FadeIn = [%styled.section {|
  animation-name: $(animation);
|}];
