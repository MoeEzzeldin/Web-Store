<template>
  <header class="header">
    <!-- logo-search-->
    <div class="left-container">
      <div class="logo">
        <img :src="logoUrl" alt="Logo" />
      </div>
      <!-- Title -->
      <div class="title">
        <h1>Market</h1>
      </div>
    </div>
    <div class="search-bar">
      <input
        type="text"
        v-model="searchQuery"
        placeholder="Search a product ..."
      />
      <button @click="onSearch()">Search</button>
    </div>
    <!-- navigation-bar -->
    <div class="right-container">
      <nav class="nav">
        <ul>
          <li v-show="isLoggedIn" v-for="item in menuItems" :key="item.text">
            <i :class="item.icon"></i>
            <a :href="item.link">{{ item.text }}</a>
          </li>
        </ul>
      </nav>
      <!-- user-title -->
      <div id="user-title">
        <!-- Logout -->
        <router-link :to="{ name: 'logout' }" v-show="isLoggedIn">
          <button
            @click="scrollToTopAndNavigate()"
            type="button"
            class="btn btn-dark"
          >
            Logout
          </button>
        </router-link>
        <!-- Login -->
        <router-link :to="{ name: 'login' }" v-show="!isLoggedIn">
          <button
            @click="scrollToTopAndNavigate()"
            type="button"
            class="btn btn-warning"
          >
            Login
          </button>
        </router-link>
        <!-- Greet User If Logged in -->
        <h1 v-if="$store.state.token" class="title">
          hello,
          {{
            this.$store.state.user.username
              ? this.$store.state.user.username
              : ''
          }}
        </h1>
      </div>
    </div>
  </header>
</template>

<script>
export default {
  name: 'Header',
  props: {
    logoUrl: {
      type: String,
      required: true,
    },
    menuItems: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      searchQuery: '',
      showButton: false,
    };
  },
  computed: {
    isLoggedIn() {
      return !!this.$store.state.token; // Return true if token exists, false otherwise
    },
  },
  methods: {
    onSearch() {
      console.log('Search query:', this.searchQuery);
      this.$router.push({
        // Look for a check before routing to same view
        name: 'product-search-view', 
        params: { ProductName: this.searchQuery },
      });
      this.searchQuery = '';
    },
    handleLogin() {
      this.showButton = false;
      this.scrollToTopAndNavigate();
    },
    handleLogout() {
      this.scrollToTopAndNavigate();
      this.showButton = true;
    },
    scrollToTopAndNavigate() {
      window.scrollTo({
        top: 0,
        behavior: 'smooth',
      });
    },
    displayProduct() {
      this.$router.push({
        name: 'product-search-view',
        params: { productName: this.searchQuery },
      });
    },
  },
};
</script>

<style scoped>
.header {
  display: flex;
  align-items: center;
  justify-content: space-evenly;
  padding: 15px 30px;
  position: fixed;
  width: 100%;
  height: 120px;
  z-index: 1000;
  margin-top: -120px;
  backdrop-filter: blur(5px); /* Adjust the blur radius as needed */
  background-color: #33333b; /*#33333B*/
  box-shadow: 0 0 2cap 2px rgb(0, 0, 0);
  font-family: 'Poetsen One', sans-serif;
  font-weight: 400;
  font-style: normal;
  color: rgb(255, 226, 106);
}

.left-container {
  display: flex;
  flex-direction: row;
  align-items: center;
}
.right-container {
  display: flex;
  align-items: center;
  justify-content: space-between;
  /* flex-grow: 1; */
}
#user-title {
  max-height: 100%;
  margin-right: 20px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
#user-title h1 {
  font-size: 12pt;
  margin: 0;
}
.logo img {
  margin-right: 24px;
  height: 4em;
  border-radius: 50%;
  box-shadow: 0 0 2px 5px rgb(97, 218, 251);
}

.title {
  font-size: 24px;
  margin-right: 25px;
  -webkit-text-stroke: 1px white;
  letter-spacing: 0.3em;
}
.nav ul {
  list-style-type: none;
  display: flex;
  margin: 0;
  padding: 0;
}

.nav li {
  margin: 0 20px;
}

.nav a {
  color: #61dafb;
  text-decoration: none;
  font-size: 18px;
}

.search-bar {
  display: flex;
  align-items: center;
  justify-content: center;
}

.search-bar input {
  width: 200px;
  padding: 8px;
  font-size: 16px;
  border: none;
  border-radius: 25px;
  background-color: rgb(51, 51, 59);
  letter-spacing: 2px;
  transition: 0.5s;
  outline: none;
}

.search-bar input:focus {
  width: 300px;
  padding: 8px;
  font-size: 16px;
  border: 2px solid rgb(255, 226, 106);
  border-radius: 25px;
  margin-right: 10px;
  background-color: rgb(255, 226, 106);
  transition: 0.5s;
  outline: none;
}
.search-bar button {
  padding: 8px 12px;
  font-size: 16px;
  border: 3px solid white;
  border-radius: 20px;
  background-color: #ffffffa4;
  color: #fff;
  cursor: pointer;
  display: block;
  transition: 0.5s;
}

.search-bar button:hover {
  background-color: rgb(255, 226, 106);
  border: 3px solid rgb(255, 226, 106);
  box-shadow: 0px 0px 5px white;
  transition: 0.5s;
}
</style>
