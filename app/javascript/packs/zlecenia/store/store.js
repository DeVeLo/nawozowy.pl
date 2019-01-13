import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'

Vue.use(Vuex)

export const store = new Vuex.Store({
	 state: {
		  zlecenia: [],
		  instytucja: {},
		  rolnik: {},
		  attr: {},
		  modalForm: null,
	 },
	 getters: {
	 	  zlecenia: state => {
	 			return state.zlecenia
	 	  },
		  instytucja: state => {
	 			return state.instytucja
	 	  },
	 	  rolnik: state => {
	 			return state.rolnik
	 	  },
	 	  attr: state => {
	 			return state.attr
	 	  },
		  modalForm: (state) => {
				return state.modalForm
		  }
	 },
	 mutations: {
		  zlecenia: (state, response) => {
				state.zlecenia = response
		  },
		  instytucja: (state, response) => {
				state.instytucja = response
		  },
		  rolnik: (state, response) => {
				state.rolnik = response
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
				fetch("/instytucje/" + gon.instytucja_id + "/rolnicy/" + gon.rolnik_id + "/zlecenia.json")
					 .then((result) => {
						  return result.json()
					 })
					 .then((result) => {
						  commit('zlecenia', result)
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
		  },
		  pobierz_rolnika({ commit }) {
				fetch('/instytucje/' + gon.instytucja_id + '/rolnicy/' + gon.rolnik_id + '.json')
					 .then((result) => {
						  return result.json()
					 })
					 .then((result) => {
						  commit('rolnik', result)
					 })
		  },
	 }
})
