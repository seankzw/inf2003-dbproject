const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*.{erb,html}'
  ],
  theme: {
    extend: {
      colors: {
        'success': '#A3E635',
        'danger': '#EF4444',
        'warning': '#FACC15'
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      keyframes: {
        toast: {
          "0%" : { opacity:1 },
          "50%" : {opacity: 1},
          "100%": {opacity: 0}
        },
      },
      animation: {
        toast : 'toast 3s ease-out',
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
