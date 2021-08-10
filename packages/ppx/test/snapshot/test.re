/* All the combinations of interpolation shoudn't be in the snapshot testing,
should be on the Test_Native, but since there's a issue with Reason's rawliteral, we ensure that the transform works in here, meanwhile. */
module Hr = [%styled.hr "
  border-top: 1px solid $(Color.Border.lineAlpha);
  margin: 0px $(NewSize.px16);
  padding: $(NewSize.px16) 0px;
  padding: $(NewSize.px16) lola 0px;
  padding: $(NewSize.px16) lola $(NewSize.px16);
  color: $(var);
"];
