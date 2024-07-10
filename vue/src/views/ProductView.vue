<template>
  <!-- need structured / styled -->
  <div class="container">
    <div v-if="product" class="col-md-6">
      <!-- product picture -->
      <div class="picture">
        <!-- Avg Rating  -->
        <h5>{{ avgRating }}</h5>
        <img
          v-if="product"
          :src="this.product.pictureUrl"
          alt="product-picture"
        />
      </div>
      <div>
        <h3>{{ product.brand }}</h3>
        <h3>{{ product.name }}</h3>
        <h3>{{ product.type }}</h3>
        <h3>{{ product.price }}</h3>
      </div>
    </div>
    <div v-else>Loading Product...</div>
    <!-- reviews -->
    <div class="reviews">
      <h3>Reviews</h3>
      <div v-for="review in reviews" :key="review.review_id">
        <h5>{{ review.reviewer }} | {{ review.date }}</h5>
        <h5>{{ review.rating }}</h5>
        <h5>{{ review.title }}</h5>
        <p>{{ review.comment }}</p>
      </div>
      <label for="review">Review Title: </label>
      <input
        type="text"
        v-model="this.review.title"
        placeholder="Add a review"
      />

      <label for="review">comment: </label>
      <input
        type="text"
        v-model="this.review.comment"
        placeholder="Add a review"
      />

      <div>Selected: {{ review.rating }}</div>
      <label for="starRating">Star Rating</label>
      <select
        v-model="review.rating"
        id="starRating"
        name="starRating"
        required
      >
        <option disabled value="">Please select one</option>
        <option value="1">1 star</option>
        <option value="2">2 stars</option>
        <option value="3">3 stars</option>
        <option value="4">4 stars</option>
        <option value="5">5 stars</option>
      </select>

      <button @click="addReview" class="btn btn-primary">Post</button>
    </div>
  </div>

  <!-- reviews need structured / styled -->
</template>

<script>
import ProductService from '../services/ProductService';
import ReviewService from '../services/ReviewService';
export default {
  name: 'ProductView',
  components: {},
  data() {
    return {
      productId: this.$route.params.id,
      product: {},
      reviews: [],
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
        })
        .catch((error) => {
          console.error(error);
        });
    },
    getReviewsById() {
      ReviewService.productReviewList(this.productId)
        .then((response) => {
          this.reviews = response.data;
          console.log('Fetched Reviews', this.reviews);
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
    this.getReviewsById();
    this.getAvgRating();
    this.scrollToTop();
  },
};
</script>

<style scoped>
.container{
  background-color: white;
}
</style>
