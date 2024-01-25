<template>
  <div class="flex">
    <div
      v-for="(color, index) in colors"
      :key="index"
      class="w-32 h-32 flex items-center justify-center text-white"
      :style="{ backgroundColor: color.hex }"
    >
      <span class="bg-white p-0.5 text-slate-800">{{ color.name }}</span>
    </div>
  </div>
  <button
    class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded"
    @click="randomizeColors"
  >
    Randomize
  </button>
</template>

<script lang="ts">
// import sample from "./public/sample.json";

import { createColorConverterFactory } from "./colorswatch";

export default {
  data() {
    return {
      colors: [],
    };
  },
  async mounted() {
    await this.fetchColors();
  },
  methods: {
    async fetchColors() {
      // FIXME: Cater for the error and pending states
      const { data, error, pending, refresh } = await useFetch(
        "https://mocki.io/v1/b772021a-ffed-4d10-9d33-91de014e71a7",
        {
          transform: (records: any) => {
            return records.map((record: any) => {
              return createColorConverterFactory(record);
            });
          },
        }
      );
      this.colors = data;
    },
    randomizeColors() {
      this.colors = this.colors.sort(() => Math.random() - 0.5);
    },
  },
};
</script>
