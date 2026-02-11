const defaultTheme = require("tailwindcss/defaultTheme")

module.exports = {
  content: [
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,html,rb}",
    "./app/assets/stylesheets/**/*.css"
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["'Space Grotesk'", ...defaultTheme.fontFamily.sans]
      },
      boxShadow: {
        glow: "0 25px 55px -25px rgba(56, 189, 248, 0.65)"
      }
    }
  },
  plugins: [
    require("@tailwindcss/forms")
  ]
}
