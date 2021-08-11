module.exports = {
  purge: [
    './components/**/*.js',
    './pages/**/*.md',
    './pages/**/*.mdx',
    './theme.config.js',
  ],
  theme: {
    screens: {
      sm: '640px',
      md: '768px',
      lg: '1024px',
      xl: '1280px',
    },
    fontFamily: {
      sans: ['Archivo', "-apple-system", "BlinkMacSystemFont", "Segoe UI", "Roboto", "Helvetica", "Arial", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol"],
      mono: ['SF Mono', ''],
    },
  },
};
