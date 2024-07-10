<template>
  <div class="banner">
    <h1 >a Picture or a Slider</h1>
  </div>
</template>

<script>

export default {
  data() {
    return {
      max: 4,
      active: 1,
    };
  },
  methods: {
    next() {
      if (this.active === this.max) return;
      this.active++;
    },
    prev() {
      if (this.active === 1) return;
      this.active--;
      },
    
  },
};
</script>

<style scoped>
.banner{
  border: 2px solid black;
  min-height: 70vh;
  min-width: 95%;
  margin-top: 20px;
}
</style>
