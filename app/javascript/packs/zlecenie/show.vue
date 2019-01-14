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
				  <b-tab title="uprawy" active>
					 <b-form-row>
						<b-col class="text-right">
						  <uprawaform></uprawaform>
						  <uprawatable></uprawatable>
						  <b-button @click="createUprawa()">dodaj użytek</b-button>
						</b-col>
					 </b-form-row>
				  </b-tab>
				  <b-tab title="zwierzęta">
					 <b-form-row>
						<b-col class="text-right">
						  <b-button @click="createAnimal()">dodaj zwierzę</b-button>
						  <animalform></animalform>
						  <animaltable></animaltable>
						</b-col>
					 </b-form-row>
				  </b-tab>
				  <b-tab title="naturalny zakupiony">
					 nabyty nawóz naturalny z innego gospodarstwa rolnego
				  </b-tab>
				  <b-tab title="naturalny sprzedany">
					 nawóz naturalny wytworzony w gospodarstwie i sprzedany
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
import animalform from './components/animalform.vue'
import animaltable from './components/animaltable.vue'
import uprawaform from './components/uprawaform.vue'
import uprawatable from './components/uprawatable.vue'

export default {
	 name: 'show',
	 components: {
		  cinstytucja,
		  crolnik,
		  czlecenie,
		  cform,
		  animalform,
		  animaltable,
		  uprawaform,
		  uprawatable,
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
							 ]),
		  animal: {	get() { return this.$store.state.animal },
						set(v) { this.$store.commit('animal', v) }	}
	 },
	 methods: {
		  ...mapActions([ 'pobierz' ]),
		  createAnimal() {
				this.animal = {
					 instytucja_id: gon.instytucja_id,
					 rolnik_id: gon.rolnik_id,
					 zlecenie_id: gon.id,
				}
				this.animalmodal.show()
		  },
		  createUprawa() {
				this.animal = {
					 instytucja_id: gon.instytucja_id,
					 rolnik_id: gon.rolnik_id,
					 zlecenie_id: gon.id,
				}
				this.uprawamodal.show()
		  },
	 },
	 created() {
		  this.pobierz()
	 },
}
</script>
