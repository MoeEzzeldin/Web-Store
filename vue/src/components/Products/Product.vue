<template>
  <div id="product-card">
    <ul>
      <li>
        <img :src="item.pictureUrl" alt="picture" />
      </li>
      <li>
        <h3>{{ item.brand }} | {{ item.name }} {{ item.type }}</h3>
      </li>
      <li>
        <h2>from<br>{{ item.price }}</h2>
      </li>
    </ul>

    <button @click="AddToCart" type="button" class="btn btn-success">
      ADD
    </button>
  </div>
</template>

<script>
export default {
  name: 'product',
  props: ['item'],
  data() {
    return {};
  },
  methods: {
    AddToCart() {
      alert('Added to cart');
    },

  },

  created() {},
};
</script>

<style scoped>
ul {
  list-style: none;
}
.btn.btn-success{
  border-radius: 10px;
}

#product-card {
  display: flex;
  flex-direction: column;
  border: 3px solid darkblue;

  /* justify-content: center; */
  /* min-height: minmax(400px, 1fr); */
}

.product-card ul{
  display: flex;
  flex-direction: column;
  flex-wrap: wrap;
  min-height: minmax(400px, 1fr);
}
</style>