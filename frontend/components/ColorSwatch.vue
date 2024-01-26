<template>
  <div class="flex h-16 text-center text-xs text-white">
    <div
      v-for="(color, index) in colors"
      :key="index"
      class="w-full hover:cursor-pointer pt-5"
      :style="{ backgroundColor: color.hex }"
    >
      <abbr :title="color.name">{{ color.hex }}</abbr>
    </div>
  </div>
  <button
    class="bg-gray-500 hover:bg-gray-700 text-white font-bold my-2 py-2 px-8 rounded block mx-auto"
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

const fetchColors = async () => {
  // FIXME: Cater for the error and pending states
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  const { data, error, pending, refresh } = await useFetch(
    runtimeConfig.public.apiUrl,
    {
      transform: (records: any) => {
        return records.map((record: any) => {
          return createColorConverterFactory(record)
        })
      }
    }
  )
  colors.value = data.value
}

onMounted(fetchColors)
</script>
