<template>
  <div class="card">
    <div class="title">
      <h3>Product Reviews</h3>
    </div>
    <div v-for="review in reviews" :key="review.review_id">

      <div class="user">
        <h5>{{ review.reviewer }}</h5>
        <h5>{{ review.rating }}</h5>
        <h5>{{ review.title }}</h5>
      </div>

      <div class="date">
        <h5>{{ review.date }}</h5>
      </div>
      <div class="comment">
        <p>{{ review.comment }}</p>
      </div>
    </div>
    <label for="review">Review Title: </label>
    <input type="text" v-model="newReview.title" placeholder="Title ..." />

    <label for="review">Comment: </label>
    <input type="text" v-model="newReview.comment" placeholder="comment..." />

    <label for="starRating">Star Rating</label>
    <select
      v-model="newReview.rating"
      id="starRating"
      name="starRating"
      placeholder="Select rating"
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
      required: true,
    },
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
      },
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
          this.title = '';
          this.comment = '';
          this.rating = 0;
        })
        .catch((error) => {
          console.error(error);
        });
    },
  },
  created() {
    this.fetchReviews();
  },
};
</script>

<style scoped>
  
  .card{
    border: 1px solid black;
    box-shadow: 0 5px 10px black;
  }
</style>
