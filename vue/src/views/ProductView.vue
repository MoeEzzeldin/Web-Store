<template>
  <!-- need structured / styled -->
  <div class="container">
    <!-- product component should fitch a thing of product based on id -->
    <Product :key="productId" :item="product" />
    <!-- reviews -->
    <Review :productId="productId" />
  </div>

  <!-- reviews need structured / styled -->
</template>

<script>
import ProductService from '../services/ProductService';
import ReviewService from '../services/ReviewService';
import Product from '../components/Products/Product.vue';
import Review from '../components/Review.vue';
export default {
  name: 'ProductView',
  components: { Product, Review },
  data() {
    return {
      productId: Number(this.$route.params.id),
      product: {},
      review: {
        productId: this.$route.params.id,
        reviewer: this.$store.state.user.username,
        date: new Date(),
        title: '',
        comment: '',
        rating: 0,
      },
      avgRating: 0,
    };
  },
  methods: {
    getProductById() {
      ProductService.getProduct(this.productId)
        .then((response) => {
          this.product = response.data;
          console.log(this.product);
        })
        .catch((error) => {
          console.error(error);
        });
    },
    getAvgRating() {
      ReviewService.avg(this.productId)
        .then((response) => {
          this.avgRating = response.data;
        })
        .catch((error) => {
          console.error(error);
        });
    },
    getProdyctByName() {
      ProductService.getProductByName(this.productName)
        .then((response) => {
          this.product = response.data;
        })
        .catch((error) => {
          console.error(error);
        });
    },
    addReview() {
      ReviewService.addAReview(this.review)
        .then(() => {
          this.productId = this.$route.params.id;
          this.getReviewsById();
          this.getAvgRating();
        })
        .catch((error) => {
          console.error(error);
        });
    },
    scrollToTop() {
      window.scrollTo({
        top: 0,
        behavior: 'smooth',
      });
    },
  },
  created() {
    this.getProductById();
    this.getAvgRating();
    this.scrollToTop();
  },
};
</script>

<style scoped>
.container {
  background-color: white;
}
</style>
