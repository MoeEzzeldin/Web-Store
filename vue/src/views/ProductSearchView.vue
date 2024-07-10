<template>
  <div class="container">
    <div class="card" v-if="searchProduct.length">
      <Product
        class="card-content"
        v-for="product in searchProduct"
        :key="product.productId"
        :item="product"
        @click="selectProduct(product.productId)"
      />
    </div>
    <div v-else>Loading Products...</div>
  </div>
</template>

<script>
import Product from '../components/Products/Product.vue';
import ProductService from '../services/ProductService';

export default {
  name: 'HomeView',
  components: {
    Product,
  },
  data() {
    return {
      searchProduct: [],
      productName: this.$route.params.ProductName,
      productId: null,
    };
  },
  methods: {
    //this function makes 3 calls to get products within price ranges
    //and sets the data to the respective arrays
    getProducts() {
      ProductService.search(this.productName)
        .then((response) => {
          this.searchProduct = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },

    selectProduct(productId) {
      this.$router.push({
        name: 'product-view',
        params: { id: productId },
      });
    },
  },
  created() {
    this.getProducts();
    this.productName = '';
  },
  updated() {
    this.getProducts();
    this.productName = '';
  },
};
</script>

<style></style>
