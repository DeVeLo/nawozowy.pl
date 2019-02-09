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
		  uprawazrodla: null,
		  animalgroups: [],
		  animalgroupKey: 0,
		  animal: {
				specjalnezywienie: false,
				badania: false,
		  },
		  animals: [],
		  zwierzeta: [],
		  rownowazniki: [],
		  uzytek: {},
		  uzytki: [],
		  sezony: [],
		  ilosc: [],
	 },
	 getters: {
		  zwierzeta: state => { return state.zwierzeta },
		  sezony: state => { return state.sezony },
		  ilosc: state => { return state.ilosc },
		  rownowazniki: state => { return state.rownowazniki },
		  uzytek: state => { return state.uzytek },
		  uzytki: state => { return state.uzytki },
		  animalgroups: state => { return state.animalgroups },
		  animals: state => { return state.animals },
		  animal: state => { return state.animal },
		  animalgroupKey: state => { return state.animalgroupKey },
	 	  rolnik: state => { return state.rolnik },
	 	  animalmodal: state => { return state.animalmodal },
		  uprawamodal: state => { return state.uprawamodal },
		  uprawazrodla: state => { return state.uprawazrodla },
	 	  instytucja: state => { return state.instytucja },
	 	  zlecenie: state => { return state.zlecenie },
	 	  attr: state => { return state.attr },
		  modalForm: (state) => { return state.modalForm }
	 },
	 mutations: {
		  zwierzeta: (state, response) => { state.zwierzeta = response },
		  sezony: (state, response) => { state.sezony = response },
		  ilosc: (state, response) => { state.ilosc = response },
		  rownowazniki: (state, response) => { state.rownowazniki = response },
		  uzytek: (state, response) => { state.uzytek = response },
		  uzytki: (state, response) => { state.uzytki = response },
		  animalgroups: (state, response) => { state.animalgroups = response },
		  animals: (state, response) => { state.animals = response },
		  animal: (state, response) => { state.animal = response },
		  animalgroupKey: (state, response) => { state.animalgroupKey = response },
		  instytucja: (state, response) => { state.instytucja = response },
		  animalmodal: (state, response) => { state.animalmodal = response },
		  uprawamodal: (state, response) => { state.uprawamodal = response },
		  uprawazrodla: (state, response) => { state.uprawazrodla = response },
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
