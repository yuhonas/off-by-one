<template>
  <div class="flex gap-0.5 h-16 text-center text-xs text-white">
    <!--
      NOTE: Only shown during the initial load before
      the colors have been fetched.
    -->
    <p
      v-if="loading && colors.length == 0"
      class="w-full py-4 text-xl text-center text-slate-800"
    >
      Loading...
    </p>
    <div
      v-for="(color, index) in colors"
      v-else
      :key="index"
      class="w-full hover:cursor-pointer pt-5"
      :style="{ backgroundColor: color.hex }"
    >
      <abbr :title="color.name">{{ color.hex }}</abbr>
    </div>
  </div>
  <button
    class="bg-gray-500 hover:bg-gray-700 text-white my-2 py-2 px-8 rounded block mx-auto"
    :disabled="loading"
    @click="fetchColors"
  >
    Refresh
  </button>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { createColorConverterFactory } from './colorswatch'
const runtimeConfig = useRuntimeConfig()

const colors = ref([])
const loading = ref(true)

// NOTE: We could implement a debounce here to prevent multiple requests from queing up
const fetchColors = async () => {
  loading.value = true
  // TODO: Cater for errors
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  const { data, error } = await useFetch(runtimeConfig.public.apiUrl, {
    transform: (records: any) => {
      return records.map((record: any) => {
        return createColorConverterFactory(record)
      })
    }
  })
  colors.value = data.value
  loading.value = false
}

onMounted(fetchColors)
</script>
