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
  @hidden="reset">
  <b-form @submit="save" @reset="reset">
	 <b-form-row>
		<input type="hidden" id="id" v-model="animal.id"></input>
		<input type="hidden" id="instytucja_id" v-model="animal.instytucja_id"></input>
		<input type="hidden" id="rolnik_id" v-model="animal.rolnik_id"></input>
		<input type="hidden" id="zlecenie_id" v-model="animal.zlecenie_id"></input>
		<input type="hidden" id="systemutrzymania_id" v-model="animal.systemutrzymania_id"></input>
		
	 </b-form-row>

	 <b-form-row>
		<b-col cols="2">
		  <b-form-group
			 label="ilość sztuk"
			 label-for="sztuk">
			 <b-form-input
				required
				ref="animal_sztuk"
				id="sztuk"
				:formatter="formatter_sztuk"
				v-model="animal.sztuk"></b-form-input>
		  </b-form-group>
		</b-col>
		
		<b-col>
		  <b-form-group
			 label="gatunek"
			 label-for="gatunek">
			 <b-form-select
				required
				id="gatunek"
				@input="pobierz_zwierzeta()"
				:options="gatunki"
				v-model="animal.gatunek_id"></b-form-select>
		  </b-form-group>
		</b-col>

		<b-col v-show="animal.gatunek_id">
		  <b-form-group
			 label="zwierzęta"
			 label-for="zwierzeta">
			 <b-form-select
				required
				id="zwierzeta"
				@input="pobierz_nazwyutrzymania()"
				:options="zwierzeta"
				v-model="animal.zwierze_id"></b-form-select>
		  </b-form-group>
		</b-col>
	 </b-form-row>

	 <b-form-row>
		<b-col v-show="animal.zwierze_id">
		  <b-form-group
			 label="system utrzymania"
			 label-for="nazwyutrzymania">
			 <b-form-select
				required
				id="nazwyutrzymania"
				:options="nazwyutrzymania"
				@input="pobierz_systemutrzymania()"
				v-model="animal.nazwautrzymania_id"></b-form-select>
		  </b-form-group>
		</b-col>

		<b-col v-if="animal.zwierze_id && zwierze.koncentracja">
		  <b-form-group
			 label="zastosowano specjalne żywienie?"
			 label-for="specjalnezywienie">
			 <b-form-radio-group
				id="specjalnezywienie"
				:options="specjalnezywienieoptions"
				v-model="animal.specjalnezywienie"></b-form-radio-group>
		  </b-form-group>
		</b-col>
	 </b-form-row>
 
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
import {mapGetters} from 'vuex'

export default {
	 name: 'animalform',
	 data() {
		  return {
				gon: gon,
				gatunki: [],
				nazwyutrzymania: [],
				systemutrzymania: {},
				zwierze: {},
				specjalnezywienieoptions: [
					 { text: 'tak', value: true },
					 { text: 'nie', value: false },
				]
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
		  zwierzeta: {
				get() { return this.$store.state.zwierzeta },
				set(v) { this.$store.commit('zwierzeta', v) }
		  },
		  animalmodal: {
				get() { return this.$store.state.animalmodal },
				set(v) { this.$store.commit('animalmodal', v) }
		  }
	 },
	 methods: {
		  formatter_sztuk(v, e) {
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
											+ "/animals/"
											+ this.animal.id + ".json",
											{ animal: this.animal }, {})
						  .then((res) => {
								this.animalmodal.hide()
						  })
						  .catch((error) => console.log(error))
				} else {
					 // create
					 this.animal.id = null;
					 this.$http.post('/instytucje/' +
										  this.animal.instytucja_id +
										  "/rolnicy/" +
										  this.animal.rolnik_id +
										  "/zlecenia/" +
										  this.animal.zlecenie_id +
										  "/animals.json",
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
					 
				}
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
					 }
				}
		  },
		  pobierz_systemutrzymania() {
				if (this.animal.nazwautrzymania_id) {
					 this.$http.get('/gatunki/' + this.animal.gatunek_id + '/zwierzeta/' + this.animal.zwierze_id + '/nazwyutrzymania/' + this.animal.nazwautrzymania_id + '/systemyutrzymania.json')
						  .then((result) => {
								this.systemutrzymania = result.body;
								if (result.body) {
									 this.animal.systemutrzymania_id = result.body.id
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
