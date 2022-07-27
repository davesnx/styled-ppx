import "../fonts.css";
import "../tailwind.css";
import "nextra-theme-docs/style.css";
import "../overrides.css";

export default function Nextra({ Component, pageProps }) {
  return <Component {...pageProps} />;
}
