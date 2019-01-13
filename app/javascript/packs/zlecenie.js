import Vue from 'vue/dist/vue.esm'
import App from './zlecenie/show.vue'
import TurbolinksAdapter from 'vue-turbolinks';
import Resource from 'vue-resource'
import { store } from './zlecenie/store/store'
import BootstrapVue from 'bootstrap-vue'
import VueI18n from 'vue-i18n'

Vue.use(BootstrapVue);
Vue.use(Resource)
Vue.use(TurbolinksAdapter)
Vue.use(VueI18n)

const i18n = new VueI18n({
	 locale: 'pl-PL'
})

document.addEventListener('turbolinks:load', () => {
	 Vue.http.headers.common['X-CSRF-Token'] = document.getElementsByName('csrf-token')[0].getAttribute('content')
	 var app = new Vue({
		  i18n,
		  el: '#zlecenie',
		  store,
		  render: h => h(App)
	 })
})
