import Vue from 'vue/dist/vue.esm'
import App from './rolnicy/rolnik.vue'
import TurbolinksAdapter from 'vue-turbolinks';
import Resource from 'vue-resource'
import { store } from './rolnicy/store/store'
import BootstrapVue from 'bootstrap-vue'

Vue.use(BootstrapVue)
Vue.use(Resource)
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
	 Vue.http.headers.common['X-CSRF-Token'] = document.getElementsByName('csrf-token')[0].getAttribute('content')
	 var app = new Vue({
		  el: '#rolnicy',
		  store,
		  render: h => h(App)
	 })
})
