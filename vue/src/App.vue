<template>
  <div id="webStore">
      <Header :logoUrl="logoUrl" :menuItems="menuItems" />
      <router-view />
    <Footer />
  </div>
</template>

<script>
import Header from './components/Header.vue';
import Footer from './components/Footer.vue';

const mainColor = '#33333B';
const secColor = '#14213D';
const thirdColor = '#FCA311';
const fourthColor = '#E5E5E5';
const fifthColor = '#FFFFFF';

export default {
  components: {
    Header,
    Footer,
  },
  data() {
    return {
      logoUrl: '../src/assets/1.png',
      width: 0,
      menuItems: [
        { text: 'Home', link: '/home', icon: 'bi bi-house-fill' },
        { text: 'About', link: '#footer', icon: 'bi bi-info-circle-fill' },
        { text: 'Contact', link: '/contact', icon: 'bi bi-person-lines-fill' },
      ],
    };
  },
  methods: {},
  computed: {
  },
};
</script>

<style>
.img{
  display: block;
  max-width: 100%;
}
html {
  scroll-behavior: smooth;
  margin-top: 120px;
  box-sizing: border-box;
  font-size: 1em;
  text-decoration: none;
}




/*Svg-Content*/
.svg--content {
  padding: 10px;
  margin: 50px 100px ;
  height: 400px;
  width: 70%;
  background-color: #33333B;
  border-radius: 25px;
  box-shadow: 4px 4px 15px rgba(0, 0, 0, 0.2);
}

.loading{
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  align-items: center;
  justify-content: center;
  width: 40%;
  margin-top: 50px;
  overflow: auto;
  padding: 10px 0;
  gap: 10px;
  border-radius: 25px;
  box-shadow: 4px 4px 15px rgba(0, 0, 0, 0.2);
}

#webStore{
  background-color: #33333B;
}
/* @media screen and (max-width: 768px) {
}
@media screen and (max-width: 480px) {
} */
</style>
