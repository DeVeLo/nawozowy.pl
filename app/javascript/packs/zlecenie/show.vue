<template>
<div>
  <b-navbar toggleable="md" type="dark" variant="dark" sticky>
	 <b-navbar-brand href="https://nawozowy.pl/">nawozowy.pl</b-navbar-brand>
	 <b-navbar-toggle target="nav_collapse" />
	 
	 <b-collapse is-nav id="nav_collapse">
		<b-navbar-nav class="ml-auto">
		  
		  <b-nav-item :href="'/instytucje/' + gon.instytucja_id + '/rolnicy'">{{ instytucja.name }}</b-nav-item>
		  <b-nav-item :href="'/instytucje/' + gon.instytucja_id + '/rolnicy/' + gon.rolnik_id + '/zlecenia'">{{ rolnik.name }} {{ rolnik.lname }}</b-nav-item>
		  <b-nav-item-dropdown :text="zlecenie.rejestr + '/' + typ[zlecenie.typ] + '/' + datawplywu.substr(0,4)" left>
			 <b-dropdown-item @click="modalForm.show()" left>edytuj</b-dropdown-item>
		  </b-nav-item-dropdown>
		  
		</b-navbar-nav>
	 </b-collapse>
  </b-navbar>
  
  <b-container fluid>
	 
	 <b-form-row class="mt-3">
		
		<b-col>
		  
		  <b-form-row>
			 <b-col>
				<h2>szczegóły zlecenia</h2>
			 </b-col>

			 <!--  <b-col class="text-right">
					 <b-button :href="'/instytucje/' + gon.instytucja_id +
								  '/rolnicy/' + gon.rolnik_id + '/zlecenia/' + gon.id +
								  '.pdf'" variant="warning">Zlecenie PDF</b-button>
			 </b-col> -->
			 
		  </b-form-row>

		  <b-form-row>
			 <b-col>
				<b-card
				  bg-variant="light"
				  title="Nawóz Naturalny"
				  sub-title="produkcja / pozostały">
				  <b>{{ zlecenie.produkcja_nawozu }}</b> t(m<sup>3</sup>)/rok / <b>{{ zlecenie.pozostaly_nawoz }}</b> t(m<sup>3</sup>)
				</b-card>
			 </b-col>

			 <b-col>
				<b-card
				  bg-variant="light"
				  title="Azot"
				  sub-title="produkcja / pozostały">
				  <b>{{ zlecenie.produkcja_azotu }}</b> kg/rok / <b>{{ zlecenie.pozostaly_azot }}</b> kg
				</b-card>
			 </b-col>
		  </b-form-row>

		  <b-form-row class="mt-2">
			 <b-col>
				
				<cform></cform>
				
				<b-card no-body>
				  <b-tabs card>
					 <b-tab title="nawozy naturalne" active>
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
		  </b-form-row>
		  
		</b-col>
	 </b-form-row>
	 
  </b-container>
</div>
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
				typ: {false: 'PA', true: 'PP'},
				gon: gon,
		  }
	 },
	 computed: {
		  ...mapGetters([ 'zlecenie',
								'modalForm',
								'animalmodal',
								'uprawamodal',
								'uzytki',
								'rolnik',
								'instytucja',
								'datawplywu',
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
