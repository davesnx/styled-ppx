import "../fonts.css";
import "../tailwind.css";
import "nextra-theme-docs/style.css";
import "../overrides.css";

const id = i => i;

export default function Nextra({ Component, pageProps }) {
  const getLayout = Component.getLayout || id;
  return getLayout(<Component {...pageProps} />);
}
