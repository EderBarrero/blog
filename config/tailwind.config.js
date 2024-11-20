const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',                        // Archivos HTML estáticos
    './app/helpers/**/*.rb',                   // Helpers de Ruby
    './app/javascript/**/*.js',                // Archivos JavaScript
    './app/views/**/*.{erb,haml,html,slim}'    // Vistas de Rails (esto cubre tus archivos .html.erb)
  ],
  
  theme: {
    extend: {
      // Extender la fuente sans para incluir 'Inter var'
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    // Plugins adicionales para mejorar el trabajo con formularios, tipografía, etc.
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ],
}
