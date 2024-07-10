<template>
  <footer id="footer" class="footer">
    <div class="container">
      <div class="column">
        <h3>About Us</h3>
        <a href="#">About Us Page</a>
        <a href="#">Our Story</a>
        <a href="#">Careers</a>
        <a href="#">Press</a>
      </div>
      <div class="column">
        <h3>Customer Service</h3>
        <a href="#">Contact Us</a>
        <a href="#">FAQs</a>
        <a href="#">Shipping Information</a>
        <a href="#">Return Policy</a>
      </div>
      <div class="column">
        <h3>Shop</h3>
        <a href="#">New Arrivals</a>
        <a href="#">Best Sellers</a>
        <a href="#">Sale</a>
        <a href="#">Gift Cards</a>
      </div>
      <div class="column">
        <h3>Follow Us</h3>
        <div class="social">
          <a href="#"
            ><img
              src="https://img.icons8.com/?size=100&id=LtK9OaHTp1cv&format=png&color=000000"
              alt="Facebook"
          /></a>
          <a href="#"
            ><img
              src="https://img.icons8.com/?size=100&id=M486asakOqWV&format=png&color=000000"
              alt="Instagram"
          /></a>
          <a href="#"
            ><img
              src="https://img.icons8.com/?size=100&id=7ZqBjBwWjYmU&format=png&color=000000"
              alt="Twitter"
          /></a>
          <a href="#"
            ><img
              src="https://img.icons8.com/?size=100&id=PFd2jwD9CU2h&format=png&color=000000"
              alt="Pinterest"
          /></a>
        </div>
      </div>
      <div class="column newsletter">
        <h3>Newsletter</h3>
        <p>
          Subscribe to our newsletter for the latest updates and exclusive
          offers.
        </p>
        <input type="email" v-model="email" placeholder="Enter your email" />
        <button @click="subscribe">Subscribe</button>
      </div>
    </div>
    <div class="legal">
      <p>© 2024 [Store Name]. All Rights Reserved.</p>
      <a href="#">Privacy Policy</a> | <a href="#">Terms of Service</a> |
      <a href="#">Accessibility</a>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'FooterComponent',
  data() {
    return {
      email: '',
    };
  },
  methods: {
    subscribe() {
      // Handle subscription logic here
      alert(`Subscribed with ${this.email}`);
      this.email = '';
    },
  },
};
</script>


<style scoped>
.footer {
  background-color: #55555d;
  padding: 40px 0;
  color: white;
  text-align: center;
}
.footer .container {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
.footer .column {
  flex: 1;
  min-width: 200px;
  margin: 20px;
}
.footer h3 {
  margin-bottom: 20px;
  font-size: 18px;
  color: white;
}
.footer a {
  color: white;
  text-decoration: none;
  display: block;
  margin-bottom: 10px;
  font-size: 14px;
}
.footer a:hover {
  color: #007bff;
}
.footer .newsletter input[type='email'] {
  padding: 10px;
  margin-top: 10px;
  width: 80%;
  max-width: 300px;
}
.footer .newsletter button {
  padding: 10px 20px;
  margin-top: 10px;
  background-color: #007bff;
  color: white;
  border: none;
  cursor: pointer;
}
.footer .newsletter button:hover {
  background-color: #0056b3;
}
.footer .social a {
  margin: 0 10px;
  display: inline-block;
}
.footer .social a img {
  width: 24px;
  height: 24px;
}
.footer .legal {
  margin-top: 20px;
  font-size: 12px;
}
</style>
