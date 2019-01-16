import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'

Vue.use(Vuex)

export const store = new Vuex.Store({
	 state: {
		  zlecenie: {},
		  attr: {},
		  instytucja: {},
		  rolnik: {},
		  modalForm: null,
		  animalform: null,
		  animalmodal: null,
		  uprawamodal: null,
		  animal: {
				specjalnezywienie: false,
				badania: false,
		  },
		  animals: [],
		  zwierzeta: [],
		  uzytek: {},
		  uzytki: [],
	 },
	 getters: {
		  zwierzeta: state => { return state.zwierzeta },
		  uzytek: state => { return state.uzytek },
		  uzytki: state => { return state.uzytki },
		  animal: state => { return state.animal },
		  animals: state => { return state.animals },
	 	  rolnik: state => { return state.rolnik },
	 	  animalmodal: state => { return state.animalmodal },
		  uprawamodal: state => { return state.uprawamodal },
	 	  instytucja: state => { return state.instytucja },
	 	  zlecenie: state => { return state.zlecenie },
	 	  attr: state => { return state.attr },
		  modalForm: (state) => { return state.modalForm }
	 },
	 mutations: {
		  zwierzeta: (state, response) => { state.zwierzeta = response },
		  uzytek: (state, response) => { state.uzytek = response },
		  uzytki: (state, response) => { state.uzytki = response },
		  animal: (state, response) => { state.animal = response },
		  animals: (state, response) => { state.animals = response },
		  instytucja: (state, response) => { state.instytucja = response },
		  animalmodal: (state, response) => { state.animalmodal = response },
		  uprawamodal: (state, response) => { state.uprawamodal = response },
		  rolnik: (state, response) => {	state.rolnik = response },
		  zlecenie: (state, response) => { state.zlecenie = response },
		  attr: (state, response) => { state.attr = response },
		  modalForm: (state, response) => { state.modalForm = response }
	 },
	 actions: {
		  pobierz({ commit }) {
				fetch("/instytucje/" + gon.instytucja_id + "/rolnicy/" + gon.rolnik_id + "/zlecenia/" + gon.id + ".json")
					 .then((result) => {
						  return result.json()
					 })
					 .then((result) => {
						  commit('zlecenie', result)
						  commit('attr', result)
						  commit('instytucja', result.instytucja)
						  commit('rolnik', result.rolnik)
					 })

		  },		  
	 }
})
