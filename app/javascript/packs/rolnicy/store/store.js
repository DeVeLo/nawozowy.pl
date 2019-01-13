import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'

Vue.use(Vuex)

export const store = new Vuex.Store({
	 state: {
		  rolnicy: [],
		  instytucja: {},
		  attr: {},
		  modalForm: null,
	 },
	 getters: {
	 	  rolnicy: state => {
	 			return state.rolnicy
	 	  },
	 	  instytucja: state => {
	 			return state.instytucja
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
		  instytucja: (state, response) => {
				state.instytucja = response
		  },
		  attr: (state, response) => {
				state.attr = response
		  },
		  modalForm: (state, response) => {
				state.modalForm = response
		  }
	 },
	 actions: {
		  pobierz({ commit }) {
				fetch('/instytucje/' + gon.instytucja_id + '/rolnicy.json')
					 .then((result) => {
						  return result.json()
					 })
					 .then((result) => {
						  commit('rolnicy', result)
					 })
		  },
		  pobierz_instytucje({ commit }) {
				fetch('/instytucje/' +gon.instytucja_id + '.json')
					 .then((result) => {
						  return result.json()
					 })
					 .then((result) => {
						  commit('instytucja', result)
					 })
		  }
	 },
})
