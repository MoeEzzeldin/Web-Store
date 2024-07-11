<template>
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
      v-model="newReview.title"
      placeholder="Add a review"
    />

    <label for="review">Comment: </label>
    <input
      type="text"
      v-model="newReview.comment"
      placeholder="Add a review"
    />

    <div>Selected: {{ newReview.rating }}</div>
    <label for="starRating">Star Rating</label>
    <select
      v-model="newReview.rating"
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
</template>

<script>
import ReviewService from '../services/ReviewService';

export default {
  name: 'Reviews',
  props: {
    productId: {
      type: Number,
      required: true
    }
  },
  data() {
    return {
      reviews: [],
      newReview: {
        productId: this.productId,
        reviewer: this.$store.state.user.username,
        date: new Date(),
        title: '',
        comment: '',
        rating: 0,
      }
    };
  },
  methods: {
    fetchReviews() {
      ReviewService.productReviewList(this.productId)
        .then((response) => {
          this.reviews = response.data;
          console.log('Fetched Reviews', this.reviews);
        })
        .catch((error) => {
          console.error(error);
        });
    },
    addReview() {
      ReviewService.addAReview(this.newReview)
        .then(() => {
          this.fetchReviews();
        })
        .catch((error) => {
          console.error(error);
        });
    }
  },
  created() {
    this.fetchReviews();
  }
};
</script>

<style scoped>
.reviews {
  background-color: white;
}
</style>
