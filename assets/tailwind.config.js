module.exports = {
  purge: [
    '../lib/**/*.ex',
    '../lib/**/*.leex',
    '../lib/**/*.eex',
    './js/**/*.js'
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {},
  variants: {
    extend: {
      backgroundColor: ['even', 'odd'],
      backgroundOpacity: ['even', 'odd']
    }
  },
  plugins: []
};