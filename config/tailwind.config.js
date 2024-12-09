const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',                        // Archivos HTML estáticos
    './app/helpers/**/*.rb',                   // Helpers de Ruby
    './app/javascript/**/*.js',                // Archivos JavaScript
    './app/views/**/*.{erb,haml,html,slim}',   // Vistas de Rails (esto cubre tus archivos .html.erb)
    './node_modules/flowbite/**/*.js'
  ],
  
  theme: {
    extend: {
      // Extender la fuente sans para incluir 'Montserrat'
      fontFamily: {
        sans: ['Montserrat', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    // Plugins adicionales para mejorar el trabajo con formularios, tipografía, etc.
    require('flowbite/plugin'),
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require('autoprefixer')
  ],
}
