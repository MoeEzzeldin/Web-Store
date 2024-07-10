<template>  
<div class="review-containe">
    <div class="image">
        <img src="" alt="Picture">
        <h2 class="reviewer">{{ item.reviewer }}</h2>
    </div>
    <div class="rating">
        <i>{{ item.rating }}</i>
        <h2>{{ item.reviewDate }}</h2>
    </div>
    <div class="content">
        <p>
            {{ item.reviewText }}
        </p>
    </div>
</div>
</template>

<script>
import ReviewService from '../services/ReviewService';
export default {
  name: 'review',
  props: ['item'],
  data() {
    return {
        reviews: [],
        review: {
            reviewTitle: '',
            reviewText: '',
            rating: '',
            reviewerName: '',
            reviewDate: '',
        },
    };
  },
  methods: {
    
    getReviewByProductId() {
      ReviewService.productReviewList(this.item.id)
        .then((response) => {
          this.review = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },

  created() {
    this.getReviewByProductId();

  },
};
</script>
<style scoped>
.image {
  width: 100%;
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

.image img {
  width: 100%;
  max-width: 150px;
  height: auto;
  border-radius: 10px;
}

.content {
  text-align: center;
}

.content h1,
.content h2 {
  margin: 10px 0;
  color: #333;
}
</style>