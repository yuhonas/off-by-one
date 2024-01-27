<template>
  <div class="flex h-16 text-center text-xs text-white">
    <!--
      NOTE: Poor mans loading indicator, this coule be done a lot more
      elegantly with event/life cycle hooks etc.
    -->
    <p
      v-if="colors.length === 0"
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
  <!--
      NOTE: This is a very basic refresh button, it could be improved with
      a disabled/loading state and error handling, it should also debounce
      to prevent enqueueing multiple requests here and/or at the network layer.
    -->
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
  // TODO: Cater for loading states & errors
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  const { data, error, pending } = await useFetch(runtimeConfig.public.apiUrl, {
    transform: (records: any) => {
      return records.map((record: any) => {
        return createColorConverterFactory(record)
      })
    }
  })
  colors.value = data.value
}

onMounted(fetchColors)
</script>
