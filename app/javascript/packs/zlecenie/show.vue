<template>
<b-container fluid>
  <b-row class="mb-3">

	 <b-col xl="3">
		<czlecenie></czlecenie>
		<crolnik class="d-none d-xl-block"></crolnik>
		<cinstytucja class="d-none d-xl-block"></cinstytucja>
	 </b-col>

	 <b-col>

		<b-row class="mt-3">
		  <b-col>
			 <h2>szczegóły zlecenia</h2>
		  </b-col>
		  
		  <b-col class="text-right">
				<b-button :href="'/instytucje/' + gon.instytucja_id + '/rolnicy/' + gon.rolnik_id + '/zlecenia/' + gon.id + '.pdf'" variant="warning">Zlecenie PDF</b-button>
				<b-button :href="'/instytucje/' + gon.instytucja_id + '/rolnicy'">lista rolników</b-button>
				<b-button :href="'/instytucje/' + gon.instytucja_id + '/rolnicy/' + gon.rolnik_id + '/zlecenia'">lista zleceń</b-button>
				<b-button @click="modalForm.show()">edytuj</b-button>
				
			 <cform></cform>
		  </b-col>
		</b-row>
		<b-row>
		  <b-col>
			 <b-card no-body>
				<b-tabs card>
				  <b-tab title="zwierzęta" active>
					 <b-form-row>
						<b-col class="text-right m-0 p-0">
						  <b-button @click="createAnimalgroup()">dodaj grupę</b-button>
						  <animalgrouptable :key="animalgroupKey"></animalgrouptable>
						</b-col>
					 </b-form-row>
				  </b-tab>
				  <b-tab title="uprawy">
					 <b-form-row>
						<b-col class="text-right">
						  <b-button
							 v-if="uzytki.length > 0"
							 target="_blank"
							 :href="'/instytucje/' + gon.instytucja_id + '/rolnicy/' + gon.rolnik_id + '/zlecenia/' + gon.id + '/uzytki.pdf'"
							 variant="warning">Plany PDF</b-button>
						  <b-button @click="createUprawa()">dodaj użytek</b-button>
						  <uprawaform></uprawaform>
						  <uprawazrodla></uprawazrodla>
						  <uprawatable></uprawatable>
						</b-col>
					 </b-form-row>
				  </b-tab>
				</b-tabs>
			 </b-card>
		  </b-col>
		</b-row>
		
	 </b-col>
  </b-row>
</b-container>
</template>

<script>
import {mapActions, mapGetters} from 'vuex'
import cinstytucja from '../components/cinstytucja.vue'
import crolnik from '../components/crolnik.vue'
import czlecenie from '../components/czlecenie.vue'
import cform from '../zlecenia/components/cform.vue'
import animalgrouptable from './components/animalgrouptable.vue'
import uprawaform from './components/uprawaform.vue'
import uprawatable from './components/uprawatable.vue'
import uprawazrodla from './components/uprawazrodla.vue'

export default {
	 name: 'show',
	 components: {
		  cinstytucja,
		  crolnik,
		  czlecenie,
		  cform,
		  animalgrouptable,
		  uprawaform,
		  uprawatable,
		  uprawazrodla,
	 },
	 data() {
		  return {
				instytucja: zlecenie.instytucja,
				gon: gon
		  }
	 },
	 computed: {
		  ...mapGetters([ 'zlecenie',
								'modalForm',
								'animalmodal',
								'uprawamodal',
								'uzytki'
							 ]),
		  uzytek: {	get() { return this.$store.state.uzytek },
						set(v) { this.$store.commit('uzytek', v) }	},
		  animalgroupKey: {	get() { return this.$store.state.animalgroupKey },
									set(v) { this.$store.commit('animalgroupKey', v) }	},
		  sezony: {	get() { return this.$store.state.sezony },
						set(v) { this.$store.commit('sezony', v) }	},
		  ilosc: {	get() { return this.$store.state.ilosc },
						set(v) { this.$store.commit('ilosc', v) }	},
		  animalgroups: {	get() { return this.$store.state.animalgroups },
								set(v) { this.$store.commit('animalgroups', v) }	},
	 },
	 methods: {
		  ...mapActions([ 'pobierz' ]),
		  createAnimalgroup() {
				this.$http.post('/instytucje/' +
									 this.gon.instytucja_id +
									 "/rolnicy/" +
									 this.gon.rolnik_id +
									 "/zlecenia/" +
									 this.gon.id +
									 "/animalgroups.json",
									 { animalgroup:
										{
											 name: '',
											 instytucja_id: this.gon.instytucja_id,
											 rolnik_id: this.gon.rolnik_id,
											 zlecenie_id: this.gon.zlecenie_id,
										}
									 },
									 {}
									)
					 .then((result) => {
						  this.animalgroups.push(result.body)
					 })
					 .catch((error) => console.log(error))
		  },
		  createUprawa() {
				this.uzytek = {
					 instytucja_id: gon.instytucja_id,
					 rolnik_id: gon.rolnik_id,
					 zlecenie_id: gon.id,
					 badania: false,
				}
				this.sezony = []
				this.ilosc = []
				this.uprawamodal.show()
		  },
	 },
	 created() {
		  this.pobierz()
	 },
}
</script>
