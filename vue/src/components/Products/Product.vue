<template>
  <div id="product-card">
    <div class="img">
        <img :src="item.pictureUrl" alt="picture" />
    </div>

    <ul>
      <li>
        <h3>{{ item.brand }} | {{ item.name }} {{ item.type }}</h3>
      </li>
      <li>
        <h2>from<br />{{ item.price }}</h2>
      </li>
    </ul>
    <button @submit.prevent="AddToCart" type="button" class="btn btn-success">
      ADD
    </button>
  </div>
</template>

<script>
export default {
  name: 'product',
  props: ['item'],

  data() {
    return {
    };
  },
  methods: {
    
    AddToCart() {
      alert('Added to cart');
    },
  },

  created() {
  },
};
</script>

<style scoped>

#product-card {
  gap: 20px;
  display: grid;
  grid-template-columns: 1fr ;
  height: 80vh;
  
}
ul {
  list-style: none;
}
.btn.btn-success {
  border-radius: 10px;
}
.product-card ul {
  display: flex;
  flex-direction: column;
  flex-wrap: wrap;
  min-height: minmax(400px, 1fr);
}

.img{

}
</style>
