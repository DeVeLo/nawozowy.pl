import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'

Vue.use(Vuex)

export const store = new Vuex.Store({
	 state: {
		  rolnicy: [],
		  attr: {},
		  modalForm: null,
	 },
	 getters: {
	 	  rolnicy: state => {
	 			return state.rolnicy
	 	  },
	 	  attr: state => {
	 			return state.attr
	 	  },
		  modalForm: state => {
				return state.modalForm
		  }
	 },
	 mutations: {
		  rolnicy: (state, response) => {
				state.rolnicy = response
		  },
		  attr: (state, response) => {
				state.attr = response
		  },
		  modalForm: (state, response) => {
				state.modalForm = response
		  }
	 },
})
