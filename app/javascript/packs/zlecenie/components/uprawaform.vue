<template>
<b-modal
  :title="title()"
  centered
  id="uprawamodal"
  ref="uprawamodal"
  size="lg"
  header-bg-variant="dark"
  header-text-variant="light"
  hide-footer
  @shown="focus"
  @hidden="reset"
  class="text-left">
  <b-form @submit.prevent="save(reaction)" @reset="reset">
	 
	 <b-card no-body>
		<b-tabs card v-model="tabIndex">
		  <b-tab title="dane podstawowe" active>
			 <b-container>

				<b-form-row>
				  <input type="hidden" id="id" v-model="uzytek.id"></input>
				  <input type="hidden" id="instytucja_id" v-model="uzytek.instytucja_id"></input>
				  <input type="hidden" id="rolnik_id" v-model="uzytek.rolnik_id"></input>
				  <input type="hidden" id="zlecenie_id" v-model="uzytek.zlecenie_id"></input>
				</b-form-row>

				<b-form-row>
				  <b-col>
					 <b-form-group
						label="oznaczenie uprawy"
						label-for="name">
						<b-form-input
						  required
						  ref="uzytek_name"
						  id="name"
						  v-model="uzytek.name">
						</b-form-input>
					 </b-form-group>
				  </b-col>
				  
				  <b-col>
					 <b-form-group
						label="kategoria agronomiczna gleby"
						label-for="kategoria">
						<b-form-select
						  required
						  id="kategoria"
						  :options="kategorie"
						  v-model="uzytek.kategoria_id"></b-form-select>
					 </b-form-group>
				  </b-col>
				  
				  <b-col cols="3">
					 <b-form-group
						label="powierzchnia ha"
						label-for="powierzchnia">
						<b-form-input
						  id="powierzchnia"
						  required
						  v-model="uzytek.powierzchnia"
						  :formatter="formatter_decimal"></b-form-input>
					 </b-form-group>
				  </b-col>
				</b-form-row>
				
				<b-form-row>
				  
				  <b-col>
					 <b-form-group
						label="zasoby azotu mineralnego wiosną na podstawie"
						label-for="badania">
						<b-form-radio-group
						  id="badania"
						  required
						  stacked
						  :options="badaniaoptions"
						  v-model="uzytek.badania">
						</b-form-radio-group>
					 </b-form-group>
				  </b-col>
				  
				  <b-col v-if="uzytek.badania == true" cols="2">
					 <b-form-group
						label="kg N/ha"
						label-for="nmin">
						<b-form-input
						  id="nmin"
						  required
						  v-model="uzytek.nmin"
						  :formatter="formatter_decimal"></b-form-input>
					 </b-form-group>
				  </b-col>
				  
				  <b-col v-if="uzytek.badania == true" cols="4">
					 <b-form-group
						label="badanie przeprowadzone"
						label-for="nminsezon">
						<b-form-radio-group
						  id="nminsezon"
						  required
						  stacked
						  :options="nminsezonoptions"
						  v-model="uzytek.nminsezon">
						</b-form-radio-group>
					 </b-form-group>
				  </b-col>
				  
				</b-form-row>
				
				<b-form-row>
				  <b-col>
					 <b-form-group
						label="obornik pod przedplon kg N/ha"
						label-for="przedplon">
						<b-form-input
						  id="przedplon"
						  required
						  v-model="uzytek.przedplon"
						  :formatter="formatter_decimal"></b-form-input>
					 </b-form-group>
				  </b-col>
				  
				  <b-col>
					 <b-form-group
						label="przedplon"
						label-for="roslinaprzedplony">
						<b-form-select
						  required
						  id="roslinaprzedplony"
						  :options="roslinaprzedplony"
						  v-model="uzytek.roslinaprzedplon_id"></b-form-select>
					 </b-form-group>
				  </b-col>
				</b-form-row>
				
				<b-form-row>
				  <b-col>
					 <b-form-group
						label="ilość azotu działającego pozostałego po uprawie roślin bobowatych"
						label-for="bobowate">
						<b-form-select
						  required
						  id="bobowate"
						  :options="bobowate"
						  v-model="uzytek.bobowata_id"></b-form-select>
					 </b-form-group>
				  </b-col>
				</b-form-row>
				
				<b-form-row>
				  <b-col>
					 <b-form-group
						label="rodzaje uprawy"
						label-for="rodzajeuprawy">
						<b-form-select
						  required
						  id="rodzajeuprawy"
						  @input="pobierzRosliny(uzytek.rodzajuprawy_id)"
						  :options="rodzajeuprawy"
						  v-model="uzytek.rodzajuprawy_id"></b-form-select>
					 </b-form-group>
				  </b-col>
				  <b-col v-show="uzytek.rodzajuprawy_id">
					 <b-form-group
						label="roślina"
						label-for="roslina">
						<b-form-select
						  required
						  id="rosliny"
						  :options="rosliny"
						  v-model="uzytek.roslina_id"></b-form-select>
					 </b-form-group>
				  </b-col>
				  <b-col v-if="uzytek.rodzajuprawy_id" cols="3">
					 <b-form-group
						label="planowany plon t/ha"
						label-for="plon">
						<b-form-input
						  id="plon"
						  required
						  v-model="uzytek.plon"
						  :formatter="formatter_decimal"></b-form-input>
					 </b-form-group>
				  </b-col>
				</b-form-row>
			 </b-container>
		  </b-tab>
		  
		  <b-tab title="nawóz naturalny" :disabled="uzytek.id==null">
			 <uprawanaturalny></uprawanaturalny>
		  </b-tab>
		  
		</b-tabs>
	 </b-card>
	 
	 <div slot="modal-footer" class="w-100 mt-3 text-center">
		<b-button type="button" @click="uprawamodal.hide()">zamknij</b-button>
		<b-button type="reset" variant="dark">resetuj</b-button>
		<b-button type="submit" @click="reaction=false" variant="primary">zapisz</b-button>
		<b-button type="submit" @click="reaction=true" variant="primary">zapisz i zamknij</b-button>
	 </div>
	 
  </b-form>
</b-modal>
</template>

<script>
import {mapActions, mapGetters} from 'vuex'
import uprawanaturalny from './uprawanaturalny.vue'

export default {
	 name: 'uprawaform',
	 components: {
		  uprawanaturalny
	 },
	 data() {
		  return {
				reaction: false,
				tabIndex: 0,
				rodzajeuprawy: [],
				rosliny: [],
				kategorie: [],
				bobowate: [],
				roslinaprzedplony: [],
				gon: gon,
				badaniaoptions: [
					 { text: 'danych z Tabeli 12', value: false },
					 { text: 'przeprowadzonych badań N<small>min</small>', value: true },
				],
				nminsezonoptions: [
					 { text: 'wiosną', value: false },
					 { text: 'jesienią', value: true },
				],
		  }
	 },
	 computed: {
		  uprawamodal: { get() { return this.$store.state.uprawamodal },
							  set(v) { this.$store.commit('uprawamodal', v) } },
		  uzytek: { get() { return this.$store.state.uzytek },
						set(v) { this.$store.commit('uzytek', v) } },
		  uzytki: { get() { return this.$store.state.uzytki },
						set(v) { this.$store.commit('uzytki', v) } },
		  sezony: { get() { return this.$store.state.sezony },
						set(v) { this.$store.commit('sezony', v) } },
		  ilosc: { get() { return this.$store.state.ilosc },
					  set(v) { this.$store.commit('ilosc', v) } },
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
				if (this.uzytek.id) { return 'edytuj użytki' }
				else { return 'dodaj użytek' }
		  },
		  focus() {
				if (!this.uzytek.id) {
					 this.clear()
				}

				this.$refs.uzytek_name.focus()
		  },
		  clear() {	
				this.uzytek = {
					 instytucja_id: gon.instytucja_id,
					 rolnik_id: gon.rolnik_id,
					 zlecenie_id: gon.id,
					 badania: false,
					 bobowata_id: 1,
					 nminsezon: false,
					 roslinaprzedplon_id: 1,
				}
		  },
		  save(reaction) {

				if (this.uzytek.id) {
					 // update
					 this.$http.patch('/instytucje/'
											+ this.uzytek.instytucja_id
											+ "/rolnicy/"
											+ this.uzytek.rolnik_id
											+ "/zlecenia/"
											+ this.uzytek.zlecenie_id
											+ "/uzytki/"
											+ this.uzytek.id + ".json",
											{ uzytek: this.uzytek }, {})
						  .then((res) => {
								if (reaction) {
									 this.uprawamodal.hide()
								}
						  })
						  .catch((error) => console.log(error))
				} else {
					 // create
					 this.uzytek.id = null
					 this.$http.post('/instytucje/' +
										  this.uzytek.instytucja_id +
										  "/rolnicy/" +
										  this.uzytek.rolnik_id +
										  "/zlecenia/" +
										  this.uzytek.zlecenie_id +
										  "/uzytki.json",
										  { uzytek: this.uzytek },
										  {}
										 )
						  .then((result) => {
								this.uzytki.push(result.body)
								if (reaction) {
									 this.uprawamodal.hide()
								} else {
									 this.uzytek = result.body
								}
						  })
						  .catch((error) => console.log(error))
				}
		  },
		  reset(e) {
				e.preventDefault()

				// ustawiam tab na dane podstawowe
				this.tabIndex = 0
				
				if (this.uzytek.id) {
					 this.pobierzUzytek()
				} else {
					 this.clear()
				}
		  },
		  pobierzRodzajeupraw() {
				this.$http.get('/rodzajeuprawy.json')
					 .then((result) => { this.rodzajeuprawy = result.body })
					 .catch((error) => { console.log(error) })
		  },
		  pobierzRosliny(r = false) {
				if (r) {
					 this.$http.get('/rodzajeuprawy/' + r + '/rosliny.json')
						  .then((result) => { this.rosliny = result.body; })
						  .catch((error) => { console.log(error) })
				}
		  },
		  pobierzKategorie() {
				this.$http.get('/kategorie.json')
					 .then((result) => { this.kategorie = result.body })
					 .catch((error) => { console.log(error) })
		  },
		  pobierzBobowate() {
				this.$http.get('/bobowate.json')
					 .then((result) => { this.bobowate = result.body })
					 .catch((error) => { console.log(error) })
		  },
		  pobierzRoslinaprzedplony() {
				this.$http.get('/roslinaprzedplony.json')
					 .then((result) => { this.roslinaprzedplony = result.body })
					 .catch((error) => { console.log(error) })
		  },
		  pobierzUzytek() {
				this.$http.get('/instytucje/'
									+ gon.instytucja_id
									+ '/rolnicy/'
									+ gon.rolnik_id
									+ '/zlecenia/'
									+ gon.id
									+ '/uzytki/'
									+ this.uzytek.id
									+ '.json')
					 .then((result) => {
						  for (var k in result.body) {
								this.uzytek[k] = result.body[k]
						  }
					 })
					 .catch((error) => { console.log(error) })
		  },
	 },
	 created() {
		  this.pobierzRodzajeupraw()
		  this.pobierzKategorie()
		  this.pobierzBobowate()
		  this.pobierzRoslinaprzedplony()
	 },
	 mounted() {
		  this.uprawamodal = this.$refs.uprawamodal
	 },
}
</script>
