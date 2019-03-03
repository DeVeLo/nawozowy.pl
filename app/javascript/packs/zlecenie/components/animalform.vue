<template>
<b-modal
  :title="title()"
  centered
  id="animalmodal"
  ref="animalmodal"
  size="lg"
  header-bg-variant="dark"
  header-text-variant="light"
  hide-footer
  @shown="focus"
  @hidden="reset"
  class="text-left">
  <b-form @submit="save" @reset="reset">
	 <b-form-row>
		<input type="hidden" id="id" v-model="animal.id"></input>
		<input type="hidden" id="instytucja_id" v-model="animal.instytucja_id"></input>
		<input type="hidden" id="rolnik_id" v-model="animal.rolnik_id"></input>
		<input type="hidden" id="zlecenie_id" v-model="animal.zlecenie_id"></input>
		<input type="hidden" id="systemutrzymania_id" v-model="animal.systemutrzymania_id"></input>
		<input type="hidden" id="animalgroup_id" v-model="animal.animalgroup_id"></input>
		
	 </b-form-row>

	 <b-card
		bg-variant="light">
		<b-form-row>
		  <b-col>
			 <b-form-group
				label="Źródło Nawozu Naturalnego"
				label-class="font-weight-bold">

				<b-form-row>
				  <b-col cols="3">
					 <b-form-group
						label="pochodzenie"
						label-for="zrodlo"
						label-size="sm"
						description="produkcja / zakup">
						<b-form-select
						  required
						  size="sm"
						  id="zrodlo"
						  :options="zrodla"
						  v-model="animal.zrodlo"></b-form-select>
					 </b-form-group>
				  </b-col>

				  <b-col cols="2">
					 <b-form-group
						label="ilość"
						label-for="sztuk"
						label-size="sm"
						description="ilość sztuk">
						<b-form-input
						  required
						  size="sm"
						  ref="animal_sztuk"
						  id="sztuk"
						  :formatter="formatter_decimal"
						  v-model="animal.sztuk"></b-form-input>
					 </b-form-group>
				  </b-col>
		
				  <b-col>
					 <b-form-group
						label="gatunek"
						label-for="gatunek"
						label-size="sm"
						description="gatunek zwierzęcia">
						<b-form-select
						  required
						  size="sm"
						  id="gatunek"
						  @input="pobierz_zwierzeta()"
						  :options="gatunki"
						  v-model="animal.gatunek_id"></b-form-select>
					 </b-form-group>
				  </b-col>
				  
				</b-form-row>
				
				<b-form-row>

				  <b-col v-show="animal.gatunek_id">
					 <b-form-group
						label="zwierzęta"
						label-for="zwierzeta"
						description="wybierz zwierzę"
						label-size="sm">
						<b-form-select
						  required
						  size="sm"
						  id="zwierzeta"
						  @input="pobierz_nazwyutrzymania()"
						  :options="zwierzeta"
						  v-model="animal.zwierze_id"></b-form-select>
					 </b-form-group>
				  </b-col>
				  
				  <b-col v-show="animal.zwierze_id">
					 <b-form-group
						label="system utrzymania"
						label-for="nazwyutrzymania"
						label-size="sm"
						description="wybierz system utrzymania i rodzaj nawozu">
						<b-form-select
						  required
						  size="sm"
						  id="nazwyutrzymania"
						  :options="nazwyutrzymania"
						  @input="pobierz_systemutrzymania(); pobierz_rownowazniki()"
						  v-model="animal.nazwautrzymania_id"></b-form-select>
					 </b-form-group>
				  </b-col>
				  
				  <b-col v-show="rownowazniki.length > 1" cols="2">
					 <b-form-group
						label="wariant"
						label-for="wariant"
						label-size="sm">
						<b-form-select
						  required
						  size="sm"
						  id="wariant"
						  :options="rownowazniki"
						  v-model="animal.rownowaznik_id"></b-form-select>
					 </b-form-group>
				  </b-col>

				</b-form-row>

				<b-form-row>
				  
				  <input v-if="rownowazniki.length == 1" type="hidden" id="rownowaznik_id" v-model="animal.rownowaznik_id"></input>
		
				  <b-col v-if="animal.zwierze_id && zwierze.koncentracja">
					 <b-form-group
						label="specjalne żywienie"
						label-for="specjalnezywienie"
						description="czy zastosowano specjalne żywienie?"
						label-size="sm">
						<b-form-radio-group
						  size="sm"
						  id="specjalnezywienie"
						  :options="specjalnezywienieoptions"
						  v-model="animal.specjalnezywienie"></b-form-radio-group>
					 </b-form-group>
				  </b-col>

				</b-form-row>

			 </b-form-group>

		  </b-col>

		</b-form-row>

	 </b-card>
		
	 <b-card
		v-if="animal.zwierze_id && animal.nazwautrzymania_id"
		bg-variant="light"
		class="mt-2">
		<b-form-row>
		  <b-col>
			 <b-form-group
				label="Wyznaczenie Zawartości Azotu"
				label-class="font-weight-bold">

				  <b-form-row class="mt-3">

					 <b-col>
						<b-form-group
						  label-for="animalbadania"
						  label-size="sm"
						  description="określ zawartość N w nawozie naturalnym na podstawie">
						  <b-form-radio-group
							 id="animalbadania"
							 required
							 size="sm"
							 :options="badaniaoptions"
							 v-model="animal.badania">
						  </b-form-radio-group>
						</b-form-group>
					 </b-col>
					 
				  </b-form-row>

			 </b-form-group>
			 
		  </b-col>
		  
		</b-form-row>

	 </b-card>
	 
	 <b-card
		bg-variant="light"
		class="mt-2"
		v-if="animal.zwierze_id && animal.nazwautrzymania_id && ( zlecenie.typ == true || animal.badania == true )"
		>

		<b-form-row>

		  <b-col>

			 <b-form-group
				label="Zawartości pierwiastków na podstawie przeprowadzonych badań"
				label-class="font-weight-bold">

				<b-form-row>
				  
				  <b-col
					 cols="4"
					 v-if="animal.badania == true">
					 <b-form-group
						:label="zawartosc_jednostka"
						label-for="zawartosc"
						label-size="sm"
						:description="'zawartość ' + zawartosc_jednostka">
						<b-form-input
						  id="zawartosc"
						  required
						  size="sm"
						  v-model="animal.zawartosc"
						  :formatter="formatter_decimal">
						</b-form-input>
					 </b-form-group>
				  </b-col>
				  
				  <b-col
					 cols="4"
					 v-if="zlecenie.typ == true">
					 <b-form-group
						:label="'kg P<sub>2</sub>O<sub>5</sub>' + jednostka"
						label-for="fosfor"
						label-size="sm"
						:description="'zawartość kg P<sub>2</sub>O<sub>5</sub>' + jednostka">
						<b-form-input
						id="fosfor"
						  required
						  size="sm"
						  v-model="animal.fosfor"
						  :formatter="formatter_decimal">
						</b-form-input>
					 </b-form-group>
				  </b-col>
				  
				  <b-col
					 cols="4"
					 v-if="zlecenie.typ == true">
					 <b-form-group
						:label="'kg K<sub>2</sub>O' + jednostka"
						label-for="potas"
						label-size="sm"
						:description="'zawartość kg K<sub>2</sub>O' + jednostka">
						<b-form-input
						  id="potas"
						  required
						  size="sm"
						  v-model="animal.potas"
						  :formatter="formatter_decimal">
						</b-form-input>
					 </b-form-group>
				  </b-col>

				</b-form-row>
				  
			 </b-form-group>

		  </b-col>
			 
		</b-form-row>
		
	 </b-card>
		
	 <div slot="modal-footer" class="w-100 text-center">
		<hr />
		<b-button type="button" @click="animalmodal.hide()">anuluj</b-button>
		<b-button type="reset" variant="dark">resetuj</b-button>
		<b-button type="submit" variant="primary">zapisz</b-button>
	 </div>
 
  </b-form>
</b-modal>
</template>

<script>
import {mapActions, mapGetters} from 'vuex'

export default {
	 name: 'animalform',
	 data() {
		  return {
				zrodla: [
					 { text: 'produkcja', value: false },
					 { text: 'zakup', value: true }
				],
				gon: gon,
				gatunki: [],
				nazwyutrzymania: [],
				systemutrzymania: {},
				zwierze: {},
				specjalnezywienieoptions: [
					 { text: 'tak', value: true },
					 { text: 'nie', value: false },
				],
				badaniaoptions: [
					 { text: 'danych z tabeli 9', value: false },
					 { text: 'przeprowadzonych badań', value: true },
				],
				zawartosc_jednostka: ''
		  }
	 },
	 computed: {
		  ...mapGetters([
				'animalform',
				'instytucja',
				'rolnik',
				'zlecenie',
		  ]),
		  animal: {
				get() { return this.$store.state.animal },
				set(v) { this.$store.commit('animal', v) }
		  },
		  animals: {
				get() { return this.$store.state.animals },
				set(v) { this.$store.commit('animals', v) }
		  },
		  animalgroups: {
				get() { return this.$store.state.animalgroups },
				set(v) { this.$store.commit('animalgroups', v) }
		  },
		  zwierzeta: {
				get() { return this.$store.state.zwierzeta },
				set(v) { this.$store.commit('zwierzeta', v) }
		  },
		  rownowazniki: {
				get() { return this.$store.state.rownowazniki },
				set(v) { this.$store.commit('rownowazniki', v) }
		  },
		  animalmodal: {
				get() { return this.$store.state.animalmodal },
				set(v) { this.$store.commit('animalmodal', v) }
		  },
		  jednostka: {
				get() { return this.zawartosc_jednostka.substr(4,this.zawartosc_jednostka.strlen) }
		  },
	 },
	 methods: {
		  formatter_decimal(v,e) {
				if (v !== null) {
					 v = v.replace(',','.')
					 var r = /^[0-9]+([.]{0,1}[0-9]*)?$/g
					 if (r.test(v)) { return v } else { return v.substr(0, v.length -1)}
				} else { return '' }
		  },
		  title() {
				if (this.animal.id) { return 'edytuj zwierzęta' }
				else { return 'dodaj zwierzęta' }
		  },
		  focus() {
				// jeśli dodajemy zwierzątko
				// czyścimy i wprowadzamy dane defaultowe z metody this.clear()
				if (!this.animal.id) {
					 this.clear()
				}

				// focus na ilość sztuk zwierząt
				this.$refs.animal_sztuk.focus()
		  },
		  save(e) {
				e.preventDefault()

				if (this.animal.id) {
					 // update
					 this.$http.patch('/instytucje/'
											+ this.animal.instytucja_id
											+ "/rolnicy/"
											+ this.animal.rolnik_id
											+ "/zlecenia/"
											+ this.animal.zlecenie_id
											+ "/animalgroups/"
											+ this.animal.animalgroup_id
											+ "/animals/"
											+ this.animal.id + ".json",
											{ animal: this.animal }, {})
						  .then((res) => {
								this.animalmodal.hide()
						  })
						  .catch((error) => console.log(error))
				} else {
					 // create
					 this.animal.id = null
					 this.$http.post('/instytucje/'
										  + this.animal.instytucja_id
										  + "/rolnicy/"
										  + this.animal.rolnik_id
										  + "/zlecenia/"
										  + this.animal.zlecenie_id
										  + "/animalgroups/"
										  + this.animal.animalgroup_id
										  + "/animals.json",
										  { animal: this.animal },
										  {}
										 )
						  .then((result) => {
								this.animals.push(result.body)
								this.animalmodal.hide()
						  })
						  .catch((error) => console.log(error))
				}
				
		  },
		  clear() {
				this.animal = {
					 instytucja_id: gon.instytucja_id,
					 rolnik_id: gon.rolnik_id,
					 zlecenie_id: gon.id,
					 zrodlo: false,
					 badania: false,
					 specjalnezywienie: false,
					 animalgroup_id: this.animal.animalgroup_id,
					 zawartosc: 0.0,
					 fosfor: 0.0,
					 potas: 0.0,
				}
				this.rownowazniki = []
		  },
		  reset(e) {
				e.preventDefault()

				if (this.animal.id) {
					 this.pobierz_animal()
				} else {
					 this.clear()
				}
		  },
		  pobierz_animal() {
				this.$http.get('/instytucje/'
								   + gon.instytucja_id
									+ '/rolnicy/'
									+ gon.rolnik_id
									+ '/zlecenia/'
									+ gon.id
									+ '/animalgroups/'
									+ this.animal.animalgroup_id
									+ '/animals/'
									+ this.animal.id
									+ '.json')
					 .then((result) => {
						  for (var k in result.body) {
								this.animal[k] = result.body[k]
						  }
					 })
					 .catch((error) => { console.log(error) })
		  },
		  pobierz_gatunki() {
				this.$http.get('/gatunki.json')
					 .then((result) => { this.gatunki = result.body })
					 .catch((error) => { console.log(error) })
		  },
		  pobierz_zwierzeta() {
				if (this.animal.gatunek_id) {
					 this.$http.get('/gatunki/' + this.animal.gatunek_id + '/zwierzeta.json')
						  .then((result) => { this.zwierzeta = result.body })
						  .catch((error) => { console.log(error) })
				}
		  },
		  pobierz_nazwyutrzymania() {
				if (this.animal.zwierze_id) {
					 
					 this.$http.get('/gatunki/' + this.animal.gatunek_id + '/zwierzeta/' + this.animal.zwierze_id + '/nazwyutrzymania.json')
						  .then((result) => { this.nazwyutrzymania = result.body })
						  .catch((error) => { console.log(error) })

					 // pobierz również zwierzę, aby określić współczynnik "w" -> koncentracji

					 this.$http.get('/gatunki/' + this.animal.gatunek_id + '/zwierzeta/' + this.animal.zwierze_id + '.json')
						  .then((result) => { this.zwierze = result.body })
						  .catch((error) => { console.log(error) })
					 
					 if (this.animal.nazwautrzymania_id) {
						  this.pobierz_systemutrzymania()
						  this.pobierz_rownowazniki()
					 }
				}
		  },
		  pobierz_systemutrzymania() {
				if (this.animal.nazwautrzymania_id) {
					 this.$http.get('/gatunki/' + this.animal.gatunek_id + '/zwierzeta/' + this.animal.zwierze_id + '/nazwyutrzymania/' + this.animal.nazwautrzymania_id + '/systemyutrzymania.json')
						  .then((result) => {
								this.systemutrzymania = result.body;
								if (result.body) {
									 this.zawartosc_jednostka = result.body.jednostkautrzymania.zawartosc
									 this.animal.systemutrzymania_id = result.body.id
								}
						  })
						  .catch((error) => { console.log(error) })
				}
		  },
		  pobierz_rownowazniki() {
				if (this.animal.nazwautrzymania_id) {
					 this.$http.get('/gatunki/' + this.animal.gatunek_id + '/zwierzeta/' + this.animal.zwierze_id + '/nazwyutrzymania/' + this.animal.nazwautrzymania_id + '/rownowazniki.json')
						  .then((result) => {
								this.rownowazniki = result.body;
								if (result.body) {
									 this.rownowazniki = result.body
									 if (this.rownowazniki.length == 1) {
										  this.animal.rownowaznik_id = result.body[0].id
										  // console.log(result.body[0].id)
									 }
								}
						  })
						  .catch((error) => { console.log(error) })
				}
		  },
	 },
	 created() {
		  this.pobierz_gatunki()
	 },
	 mounted() {
		  this.animalmodal = this.$refs.animalmodal
	 }
}
</script>
