// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: ['@nuxtjs/tailwindcss', '@nuxtjs/eslint-module'],
  eslint: {
    lintOnStart: false,
    emitWarning: true
  },
  runtimeConfig: {
    // Will be available in both server and client
    public: {
      // Can be overriden with
      // NUXT_PUBLIC_API_URL=http://www.example.com
      apiUrl: 'http://localhost:8000'
    }
  }
})
