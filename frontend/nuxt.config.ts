// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: ['@nuxtjs/tailwindcss', '@nuxtjs/eslint-module'],
  eslint: {
    lintOnStart: false,
    emitWarning: true
  },
  runtimeConfig: {
    // public variables will be available in both server and client
    public: {
      // Where to source our JSON based color swatch from
      // should be a URL or set to a local file for testing without a server
      // to set use the NUXT_PUBLIC_API_URL environment variable eg.
      // NUXT_PUBLIC_API_URL=http://www.example.com
      apiUrl: '/sample.json'
    },
    app: {
      baseURL: '/'
    }
  }
})
