<template>
<b-container class="m-0 p-0" fluid>
  <animalform></animalform>
  <b-row class="m-0 mt-3 p-0" v-for="(animalgroup, index) in animalgroups">
	 <b-col class="m-0 p-0 text-left">
		<b-card
		  no-body
		  class="m-0 p-0"
		  header-bg-variant="dark"
		  header-text-variant="white">
		  
		  <b-row slot="header">
			 <b-col>
				<b-button @click="createAnimal(animalgroup.id)" variant="primary" size="sm">dodaj zwierzę</b-button>

				<b-button v-if="confirm!=animalgroup.id" type="button" variant="danger" size="sm" @click="confirm=animalgroup.id">usuń grupę</b-button>
				<span v-if="confirm==animalgroup.id">
				  na pewno?
				  <b-button type="button" variant="danger" size="sm" @click="usunGrupe(animalgroup.id, index)">tak</b-button>
				  <b-button type="button" size="sm" @click="confirm=false">nie</b-button>
				</span>
			 </b-col>
		  </b-row>

		  <b-row class="m-0 p-0">
			 <b-col class="m-0 p-0">
				<animaltable :animalgroup="animalgroup"></animaltable>
			 </b-col>
		  </b-row>
		  
		</b-card>
	 </b-col>
  </b-row>
</b-container>
</template>
<script>
import {mapGetters} from 'vuex'
import animalform from './animalform.vue'
import animaltable from './animaltable.vue'

export default {
	 name: "animalgrouptable",
	 data() {
		  return {
				confirm: false,
		  }
	 },
	 components: {
		  animalform,
		  animaltable,
	 },
	 computed: {
		  ...mapGetters([ 'zlecenie',
								'modalForm',
								'animalmodal',
								'uprawamodal',
							 ]),
		  animalgroups: {	get() { return this.$store.state.animalgroups },
								set(v) { this.$store.commit('animalgroups', v) }	},		  
		  animal: {	get() { return this.$store.state.animal },
						set(v) { this.$store.commit('animal', v) }	},
		  animals: {	get() { return this.$store.state.animals },
							set(v) { this.$store.commit('animals', v) }	},
	 },
	 watch: {
		  animals: function() {
				this.pobierzAnimalgroups()
		  }
	 },
	 methods: {
		  createAnimal(animalgroup_id) {
				this.animal = {
					 instytucja_id: gon.instytucja_id,
					 rolnik_id: gon.rolnik_id,
					 zlecenie_id: gon.id,
					 badania: false,
					 specjalnezywienie: false,
					 animalgroup_id: animalgroup_id,
				}
				this.animalmodal.show()
		  },
		  pobierzAnimalgroups() {
				this.$http.get('/instytucje/'
									+ gon.instytucja_id
									+ '/rolnicy/'
									+ gon.rolnik_id
									+ '/zlecenia/'
									+ gon.id
									+ '/animalgroups.json')
					 .then((result) => { this.animalgroups = result.body })
					 .catch((error) => { console.log(error)} )
		  },
		  usunGrupe(id, index) {
				this.$http.delete('/instytucje/'
										+ gon.instytucja_id
										+ '/rolnicy/'
										+ gon.rolnik_id
										+ '/zlecenia/'
										+ gon.id
										+ '/animalgroups/'
										+ id + '.json')
					 .then((result) => {
						  this.animalgroups.splice(index,1)
					 })
					 .catch((error) => { console.log(error) })
		  },
	 },
	 created() {
		  this.pobierzAnimalgroups()
	 },	 
}
</script>
