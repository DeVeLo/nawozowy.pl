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
		  <b-nav-item @click="logout">Wyloguj</b-nav-item>
		  
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
			 <b-col class="mt-2">
				<b-card
				  bg-variant="light"
				  title="Nawóz Naturalny"
				  sub-title="produkcja / pozostały">
				  <b>{{ zlecenie.produkcja_nawozu }}</b> t(m<sup>3</sup>)/rok / <b>{{ zlecenie.pozostaly_nawoz }}</b> t(m<sup>3</sup>)
				</b-card>
			 </b-col>

			 <b-col class="mt-2">
				<b-card
				  bg-variant="light"
				  title="Azot"
				  sub-title="produkcja / pozostały">
				  <b>{{ zlecenie.produkcja_azotu }}</b> kg/rok / <b>{{ zlecenie.pozostaly_azot }}</b> kg
				</b-card>
			 </b-col>

			 <b-col class="mt-2">
				<b-card
				  bg-variant="light"
				  title="Fosfor"
				  sub-title="produkcja / pozostały">
				  <b>{{ zlecenie.produkcja_fosforu }}</b> kg/rok / <b>{{ zlecenie.pozostaly_fosfor }}</b> kg
				</b-card>
			 </b-col>

			 <b-col class="mt-2">
				<b-card
				  bg-variant="light"
				  title="Potas"
				  sub-title="produkcja / pozostały">
				  <b>{{ zlecenie.produkcja_potasu }}</b> kg/rok / <b>{{ zlecenie.pozostaly_potas }}</b> kg
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
						  <b-col>
							 <b>Podział na grupy oznacza, iż dany obornik/gnojówka/gnojowica w ramach danej grupy gromadzony jest na jednej pryzmie lub w jednym zbiorniku. (następuje mieszanie nawozu naturalnego od różnych zwierząt)</b>
							 <br />
							 <br />
							 <b>Przykład:</b> rolnik posiada Krowy mleczne i Buhaje, których obornik składowany jest na jednej pryzmie oraz gnojówka w jednym zbiorniku. Należy utworzyć 2 grupy i do każdej dodać zarówno krowy mleczne jak i buhaje, gdzie w przypadku obornika wybieramy system utrzymania "Płytka ściółka obornik", a w przypadku gnojówki wybieramy system utrzymania "Płytka ściółka gnojówka". W ten sposób podczas rozdysponowywania nawozu naturalnego na użytkach ilości zostaną wyliczone proporcjonalnie do liczby zwierząt w ramach grup.
						  </b-col>
						</b-form-row>
						<b-form-row>
						  <b-col class="text-right m-0 p-0">
							 <b-button @click="createAnimalgroup()">dodaj grupę</b-button>
						  </b-col>
						</b-form-row>
						<b-form-row>
						  <b-col>
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
								:href="'/instytucje/' + gon.instytucja_id + '/rolnicy/' + gon.rolnik_id + '/zlecenia/' + gon.id + '/bilans.pdf'"
								variant="warning">wydruk główny</b-button>
							 <b-button
								v-if="uzytki.length > 0"
								target="_blank"
								:href="'/instytucje/' + gon.instytucja_id + '/rolnicy/' + gon.rolnik_id + '/zlecenia/' + gon.id + '/uzytki.pdf'"
								variant="warning">
								<template v-if="zlecenie.typ">
								  pełny
								</template>
								plan
								<template v-if="!zlecenie.typ">
								  azotanowy
								</template>
							 </b-button>
							 <b-button
								v-if="uzytki.length > 0"
								target="_blank"
								:href="'/instytucje/' + gon.instytucja_id + '/rolnicy/' + gon.rolnik_id + '/zlecenia/' + gon.id + '/zapotrzebowanie.pdf'"
								variant="warning">zapotrzebowanie</b-button>
							 <b-button @click="createUprawa()">dodaj użytek</b-button>
							 <b-button
								v-if="zlecenie.nawozynaturalne && zlecenie.nawozynaturalne.length > 0 && ! resetujnawozyconfirm"
								@click="resetujnawozyconfirm = true"
								variant="danger">
								cofnij rozdysponowanie</b-button>
							 <template
								v-if="resetujnawozyconfirm && zlecenie.nawozynaturalne.length > 0">
								Czy na pewno cofnąć rozdysponowanie nawozu naturalnego z użytków?
								<b-button
								  variant="danger"
								  @click="resetujNawozy(); resetujnawozyconfirm = false;">
								  TAK
								</b-button>
								<b-button
								  @click="resetujnawozyconfirm=false">
								  NIE
								</b-button>
							 </template>
							 <uprawaform></uprawaform>
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
				resetujnawozyconfirm: false,
		  }
	 },
	 computed: {
		  ...mapGetters([	'modalForm',
								'animalmodal',
								'uprawamodal',
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
		  zlecenie: {	get() { return this.$store.state.zlecenie },
								set(v) { this.$store.commit('zlecenie', v) }	},
		  uzytki: {	get() { return this.$store.state.uzytki },
								set(v) { this.$store.commit('uzytki', v) }	},
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
		  pobierzUzytki() {
				this.$http.get('/instytucje/'
									+ gon.instytucja_id
									+ '/rolnicy/'
									+ gon.rolnik_id
									+ '/zlecenia/'
									+ gon.id
									+ '/uzytki.json')
					 .then((result) => { this.uzytki = result.body })
					 .catch((error) => { console.log(error) } )
		  },
		  resetujNawozy() {
				this.$http.delete("/instytucje/" +
										this.gon.instytucja_id +
										"/rolnicy/" +
										this.gon.rolnik_id +
										"/zlecenia/" +
										this.gon.id +
										"/destroy_nawozynaturalne.json")
					 .then((r) => {
						  this.zlecenie = r.body
						  this.pobierzUzytki()
					 })
					 .catch((e) => {
						  console.log(e)
					 })
		  },
		  logout() {
				this.$http.delete('/users/sign_out')
					 .then((r) => {
						  window.history.go()
					 })
					 .catch((e) => {
						  console.log(e)
					 })
		  },
	 },
	 created() {
		  this.pobierz()
	 },
}
</script>
