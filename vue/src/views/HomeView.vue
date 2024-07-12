<template>
  <div class="container">
    <Slider />
    <!-- Under 200 -->
    <section>
      <h3 class="card__title">Under $200</h3>
      <div class="card" v-if="underTwoHundred.length">
        <Product
          v-for="product in randomProductsOne"
          :key="product.productId"
          :item="product"
          @click="selectProduct(product.productId)"
        />
      </div>

      <div class="loading" v-else>
        <div class="loader loader--style7" title="6">
          <svg
            version="1.1"
            id="Layer_1"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            x="0px"
            y="0px"
            width="24px"
            height="30px"
            viewBox="0 0 24 30"
            style="enable-background: new 0 0 50 50"
            xml:space="preserve"
          >
            <rect x="0" y="0" width="4" height="20" fill="#333">
              <animate
                attributeName="opacity"
                attributeType="XML"
                values="1; .2; 1"
                begin="0s"
                dur="0.6s"
                repeatCount="indefinite"
              />
            </rect>
            <rect x="7" y="0" width="4" height="20" fill="#333">
              <animate
                attributeName="opacity"
                attributeType="XML"
                values="1; .2; 1"
                begin="0.2s"
                dur="0.6s"
                repeatCount="indefinite"
              />
            </rect>
            <rect x="14" y="0" width="4" height="20" fill="#333">
              <animate
                attributeName="opacity"
                attributeType="XML"
                values="1; .2; 1"
                begin="0.4s"
                dur="0.6s"
                repeatCount="indefinite"
              />
            </rect>
          </svg>
        </div>
      </div>
    </section>
    <!-- Under 500 -->
    <section>
      <h3 class="card__title">Under $200</h3>
      <div class="card" v-if="underFiveHundred.length">
        <Product
          v-for="product in randomProductsTwo"
          :key="product.productId"
          :item="product"
          @click="selectProduct(product.productId)"
        />
      </div>

      <div class="loading" v-else>
        <div class="loader loader--style7" title="6">
          <svg
            version="1.1"
            id="Layer_1"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            x="0px"
            y="0px"
            width="24px"
            height="30px"
            viewBox="0 0 24 30"
            style="enable-background: new 0 0 50 50"
            xml:space="preserve"
          >
            <rect x="0" y="0" width="4" height="20" fill="#333">
              <animate
                attributeName="opacity"
                attributeType="XML"
                values="1; .2; 1"
                begin="0s"
                dur="0.6s"
                repeatCount="indefinite"
              />
            </rect>
            <rect x="7" y="0" width="4" height="20" fill="#333">
              <animate
                attributeName="opacity"
                attributeType="XML"
                values="1; .2; 1"
                begin="0.2s"
                dur="0.6s"
                repeatCount="indefinite"
              />
            </rect>
            <rect x="14" y="0" width="4" height="20" fill="#333">
              <animate
                attributeName="opacity"
                attributeType="XML"
                values="1; .2; 1"
                begin="0.4s"
                dur="0.6s"
                repeatCount="indefinite"
              />
            </rect>
          </svg>
        </div>
      </div>
    </section>
    <!-- Under 1000 -->
    <section>
      <h3 class="card__title">Over a 500</h3>
      <div class="card" v-if="fiveHundredPlus.length">
        <Product
          v-for="product in randomProductsThree"
          :key="product.productId"
          :item="product"
          @click="selectProduct(product.productId)"
        />
      </div>

      <div class="loading" v-else>
        <div class="loader loader--style7" title="6">
          <svg
            version="1.1"
            id="Layer_1"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            x="0px"
            y="0px"
            width="24px"
            height="30px"
            viewBox="0 0 24 30"
            style="enable-background: new 0 0 50 50"
            xml:space="preserve"
          >
            <rect x="0" y="0" width="4" height="20" fill="#333">
              <animate
                attributeName="opacity"
                attributeType="XML"
                values="1; .2; 1"
                begin="0s"
                dur="0.6s"
                repeatCount="indefinite"
              />
            </rect>
            <rect x="7" y="0" width="4" height="20" fill="#333">
              <animate
                attributeName="opacity"
                attributeType="XML"
                values="1; .2; 1"
                begin="0.2s"
                dur="0.6s"
                repeatCount="indefinite"
              />
            </rect>
            <rect x="14" y="0" width="4" height="20" fill="#333">
              <animate
                attributeName="opacity"
                attributeType="XML"
                values="1; .2; 1"
                begin="0.4s"
                dur="0.6s"
                repeatCount="indefinite"
              />
            </rect>
          </svg>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import Product from '../components/Products/Product.vue';
import ProductService from '../services/ProductService';
import Slider from '../components/Slider.vue';
export default {
  name: 'HomeView',
  components: {
    Product,
    Slider,
  },
  data() {
    return {
      underTwoHundred: [],
      underFiveHundred: [],
      fiveHundredPlus: [],
      productId: null,
    };
  },
  methods: {
    //this function makes 3 calls to get products within price ranges
    //and sets the data to the respective arrays
    getProducts() {
      ProductService.productFilterOne()
        .then((response) => {
          this.underTwoHundred = response.data;
        })
        .catch((error) => {
          console.log(error);
        });

      ProductService.productFilterTwo()
        .then((response) => {
          this.underFiveHundred = response.data;
        })
        .catch((error) => {
          console.log(error);
        });

      ProductService.productFilterThree()
        .then((response) => {
          this.fiveHundredPlus = response.data;
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

  computed: {
    randomProductsOne() {
      // Shuffle the array and slice the first 4 elements
      return this.underTwoHundred
        .map((value) => ({ value, sort: Math.random() }))
        .sort((a, b) => a.sort - b.sort)
        .map(({ value }) => value)
        .slice(0, 6);
    },
    randomProductsTwo() {
      return this.underFiveHundred
        .map((value) => ({ value, sort: Math.random() }))
        .sort((a, b) => a.sort - b.sort)
        .map(({ value }) => value)
        .slice(0, 6);
    },
    randomProductsThree() {
      return this.fiveHundredPlus
        .map((value) => ({ value, sort: Math.random() }))
        .sort((a, b) => a.sort - b.sort)
        .map(({ value }) => value)
        .slice(0, 6);
    },
  },
  created() {
    this.getProducts();
  },
};
</script>

<style scoped>
.container {
  border: 2px solid red;
  min-width: 80vw;
  display: flex;
  flex-wrap: wrap;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 40px;
  background-color: white;
}

section {
  min-width: 95%;
}

.card {
  border: 4px solid darkmagenta;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 20px;
}


/* card header */
.card__title {
  height: 100px;
  min-width: 100%;
  display: block;
  border-bottom: 1px solid black;
  background-color: #61dafb;
  border-radius: 30px 25px;
}



@media (max-width: 760px) {
  .container{
    min-width: 90%;
  }
  .card{
  border: 4px solid darkmagenta;
  display: grid;
  gap: 20px;
  }
}

.video-bg {
  right: 0;
  top: 0;
  width: 100%;
  height: 100%;
  video {
    border-radius: 25px;
    width: 100%;
    height: 100%;
    object-fit: cover;
    opacity: 0.8;
  }
}

svg path,
svg rect {
  fill: #ff6700;
}
</style>
