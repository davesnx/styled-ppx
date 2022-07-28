import "../fonts.css";
import "../tailwind.css";
import "nextra-theme-docs/style.css";
import "../overrides.css";

/* Remove Prism, and prism-react-render after update Nextra to v2,
in favor of shiki and next.config.js commented code */
import Prism from "prism-react-renderer/prism";
(typeof global !== "undefined" ? global : window).Prism = Prism;
require("prismjs/components/prism-rescript.min");

export default function Nextra({ Component, pageProps }) {
  return <Component {...pageProps} />;
}
