import "../fonts.css";
import "../styles.css";
import "nextra-theme-docs/style.css";
import "../overrides.css";

export default function Nextra({ Component, pageProps }) {
  return (
    <>
      <Component {...pageProps} />
    </>
  );
}
