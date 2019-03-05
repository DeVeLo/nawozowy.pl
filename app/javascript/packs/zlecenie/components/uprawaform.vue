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
			 
			 <b-form-row>
				<input type="hidden" id="id" v-model="uzytek.id"></input>
				<input type="hidden" id="instytucja_id" v-model="uzytek.instytucja_id"></input>
				<input type="hidden" id="rolnik_id" v-model="uzytek.rolnik_id"></input>
				<input type="hidden" id="zlecenie_id" v-model="uzytek.zlecenie_id"></input>
			 </b-form-row>
			 
			 <!-- <b-col cols="1"> -->
			 <!-- 	 <b-form-group -->
			 <!-- 		label="n.p." -->
			 <!-- 		label-for="lp"> -->
			 <!-- 		<b-form-input -->
			 <!-- 		  type="number" -->
			 <!-- 		  ref="uzytek_lp" -->
			 <!-- 		  id="lp" -->
			 <!-- 		  v-model="uzytek.lp"> -->
			 <!-- 		</b-form-input> -->
			 <!-- 	 </b-form-group> -->
			 <!-- </b-col> -->
			 
			 
			 <b-card
				bg-variant="light">
				
				<b-form-row>
				  
				  <b-col>
					 
					 <b-form-group
						label="Ogólne informacje o użytku"
						label-class="font-weight-bold">
						
						<b-form-row>
						  
						  <b-col>
							 <b-form-group
								label="oznaczenie uprawy"
								label-for="name"
								label-size="sm"
								description="jeśli brak, przyjmie nr porządkowy">
								
								<b-form-input
								  ref="uzytek_name"
								  id="name"
								  size="sm"
								  v-model="uzytek.name">
								</b-form-input>
								
							 </b-form-group>
						  </b-col>
						  
						  <b-col>
							 <b-form-group
								label="kategoria"
								label-for="kategoria"
								label-size="sm"
								description="kategoria agronomiczna gleby">
								
								<b-form-select
								  required
								  id="kategoria"
								  :options="kategorie"
								  size="sm"
								  v-model="uzytek.kategoria_id"></b-form-select>
							 </b-form-group>
						  </b-col>
						  
						  <b-col
							 v-if="(uzytek.kategoria_id < 5) && (zlecenie.typ == true)">
							 <b-form-group
								label="węglanowa"
								label-for="weglanowa"
								label-size="sm"
								description="zaznacz czy gleba węglanowa">
								<b-form-select
								  id="weglanowa"
								  size="sm"
								  :options="weglanowe"
								  v-model="uzytek.weglanowa"></b-form-select>
							 </b-form-group>
						  </b-col>
						  
						</b-form-row>
						
						<b-form-row>
						  
						  <b-col>
							 <b-form-group
								label="rodzaj gruntu"
								label-for="grunt"
								label-size="sm"
								description="grunty orne, uprawy, użytki zielone">
								<b-form-select
								  required
								  size="sm"
								  id="grunt"
								  :options="grunty"
								  v-model="uzytek.grunt_id"></b-form-select>
							 </b-form-group>
						  </b-col>
						  
						  <b-col v-if="zlecenie.typ == true">
							 <b-form-group
								label="Ph"
								label-for="ph"
								label-size="sm"
								description="odczyt Ph gleby">
								<b-form-input
								  required
								  id="ph"
								  size="sm"
								  v-model="uzytek.ph"
								  :formatter="formatter_decimal"></b-form-input>
							 </b-form-group>
						  </b-col>
						  
						  <b-col>
							 <b-form-group
								label="powierzchnia ha"
								label-for="powierzchnia"
								label-size="sm"
								description="powierzchnia użytku w hektarach">
								<b-form-input
								  id="powierzchnia"
								  size="sm"
								  required
								  v-model="uzytek.powierzchnia"
								  :formatter="formatter_decimal"></b-form-input>
							 </b-form-group>
						  </b-col>
						  
						</b-form-row>
						
					 </b-form-group>
					 
				  </b-col>
				  
				</b-form-row>
				
			 </b-card>
			 
			 <b-card
				bg-variant="light"
				class="mt-2">
				
				<b-form-row>
				  
				  <b-col>
					 
					 <b-form-group
						label="Uprawa"
						label-class="font-weight-bold">
						
						<b-form-row>
						  
						  <b-col>
							 <b-form-group
								label="rodzaje uprawy"
								label-for="rodzajeuprawy"
								label-size="sm"
								description="wybierz kategorię roślin">
								<b-form-select
								  size="sm"
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
								label-for="roslina"
								label-size="sm"
								description="wybierz roślinę">
								<b-form-select
								  required
								  size="sm"
								  id="rosliny"
								  :options="rosliny"
								  v-model="uzytek.roslina_id"></b-form-select>
							 </b-form-group>
						  </b-col>

						  <b-col v-if="uzytek.rodzajuprawy_id" cols="3">
							 <b-form-group
								label="plon"
								label-for="plon"
								label-size="sm"
								description="podaj planowany plon w t/ha">
								<b-form-input
								  size="sm"
								  id="plon"
								  required
								  v-model="uzytek.plon"
								  :formatter="formatter_decimal"></b-form-input>
							 </b-form-group>
						  </b-col>

						</b-form-row>

					 </b-form-group>

				  </b-col>

				</b-form-row>

			 </b-card>
			 
			 <b-card
				bg-variant="light"
				class="mt-2">
				
				<b-form-row>
				  
				  <b-col>
					 
					 <b-form-group
						label="Zawartość azotu w glebie"
						label-class="font-weight-bold">
						
						<b-form-row>
						  
						  <b-col>
							 <b-form-group
								label="zasoby azotu na podstawie"
								label-for="badania"
								label-size="sm">
								<b-form-radio-group
								  id="badania"
								  required
								  stacked
								  size="sm"
								  :options="badaniaoptions"
								  v-model="uzytek.badania">
								</b-form-radio-group>
							 </b-form-group>
						  </b-col>
						  
						  <b-col v-if="uzytek.badania == true">
							 <b-form-group
								label="kg N/ha"
								label-for="nmin"
								label-size="sm"
								description="zawartość azotu">
								<b-form-input
								  id="nmin"
								  required
								  size="sm"
								  v-model="uzytek.nmin"
								  :formatter="formatter_decimal"></b-form-input>
							 </b-form-group>
						  </b-col>
						  
						  <b-col v-if="uzytek.badania == true">
							 <b-form-group
								label="badanie przeprowadzone"
								label-for="nminsezon"
								label-size="sm">
								<b-form-radio-group
								  id="nminsezon"
								  required
								  stacked
								  size="sm"
								  :options="nminsezonoptions"
								  v-model="uzytek.nminsezon">
								</b-form-radio-group>
							 </b-form-group>
						  </b-col>
						  
						</b-form-row>
						
					 </b-form-group>
					 
				  </b-col>
				  
				</b-form-row>
				
			 </b-card>
			 
			 <b-card
				v-if="zlecenie.typ == true"
				bg-variant="light"
				class="mt-2">
				
				<b-form-row>
				  
				  <b-col>
					 
					 <b-form-group
						label="Zawartość pozostałych pierwiastów w glebie"
						label-class="font-weight-bold"
						description="Zawartość pierwiastków na podstawie przeprowadzonych badań">
						
						<b-form-row>
						  
						  <b-col>
							 <b-form-group
								label="P<sub>2</sub>O<sub>5</sub>"
								label-for="fosfor"
								label-size="sm"
								description="zawartość fosforu">
								<b-form-input
								  required
								  size="sm"
								  id="fosfor"
								  v-model="uzytek.fosfor"
								  :formatter="formatter_decimal"></b-form-input>
							 </b-form-group>
						  </b-col>
						  
						  <b-col>
							 <b-form-group
								label-size="sm"
								description="zawartość potasu"
								label="K<sub>2</sub>O"
								label-for="potas">
								<b-form-input
								  required
								  size="sm"
								  id="potas"
								  v-model="uzytek.potas"
								  :formatter="formatter_decimal"></b-form-input>
							 </b-form-group>
						  </b-col>
						  
						  <b-col>
							 <b-form-group
								label-size="sm"
								description="zawartość magnezu"
								label="MgO"
								label-for="magnez">
								<b-form-input
								  size="sm"
								  required
								  id="magnez"
								  v-model="uzytek.magnez"
								  :formatter="formatter_decimal"></b-form-input>
							 </b-form-group>
						  </b-col>
						  
						</b-form-row>
						
					 </b-form-group>
					 
				  </b-col>
				  
				</b-form-row>
				
			 </b-card>
			 
			 <b-card
				v-if="zlecenie.typ == true"
				bg-variant="light"
				class="mt-2">
				
				<b-form-row>
				  
				  <b-col>
					 
					 <b-form-group
						label="Nawóz naturalny zastosowany pod przedplon"
						label-class="font-weight-bold">
						
						<b-form-row>
						  
						  <b-col>
							 <b-form-group
								label="rodzaj nawozu"
								label-for="wspwykorzystania"
								label-size="sm"
								description="rodzaj nawozu naturalnego pod przedplon">
								<b-form-select
								  size="sm"
								  required
								  id="wspwykorzystania"
								  :options="wspiwykorzystania"
								  v-model="uzytek.wspwykorzystania_id"></b-form-select>
							 </b-form-group>
						  </b-col>


						  <b-col>
							 <b-form-group
								label="kg N/ha"
								label-for="przedplon"
								label-size="sm"
								description="ilość azotu zawartego w zastosowanym nawozie">
								<b-form-input
								  size="sm"
								  id="przedplon"
								  required
								  v-model="uzytek.przedplon"
								  :formatter="formatter_decimal"></b-form-input>
							 </b-form-group>
						  </b-col>

						</b-form-row>

						<b-form-row v-if="zlecenie.typ == true">
						  
						  <b-col>
							 <b-form-group
								label="kg P<sub>2</sub>O<sub>5</sub>/ha"
								label-for="przedplonfosfor"
								label-size="sm"
								description="ilość fosforu zawartego w zastosowanym nawozie">
								<b-form-input
								  size="sm"
								  required
								  id="przedplonfosfor"
								  v-model="uzytek.przedplonfosfor"
								  :formatter="formatter_decimal"></b-form-input>
							 </b-form-group>
						  </b-col>
						  
						  <b-col>
							 <b-form-group
								label="kg K<sub>2</sub>O/ha"
								label-for="przedplonpotas"
								label-size="sm"
								description="ilość potasu zawartego w zastosowanym nawozie">
								<b-form-input
								  required
								  size="sm"
								  id="przedplonpotas"
								  v-model="uzytek.przedplonpotas"
								  :formatter="formatter_decimal"></b-form-input>
							 </b-form-group>
						  </b-col>
						  
						</b-form-row>

					 </b-form-group>

				  </b-col>

				</b-form-row>

			 </b-card>
						
			 <b-card
				bg-variant="light"
				class="mt-2">
				
				<b-form-row>
				  
				  <b-col>
					 
					 <b-form-group
						label="Roślina na przedplon"
						label-class="font-weight-bold">

						<b-form-row>
						  
						  <b-col v-if="zlecenie.typ == true">
							 <b-form-group
								label="plon"
								label-size="sm"
								description="plon rośliny przedplonowej w t/ha"
								label-for="plonprzedplonowej">
								<b-form-input
								  required
								  size="sm"
								  id="plonprzedplonowej"
								  v-model="uzytek.plonprzedplonowej"
								  :formatter="formatter_decimal"></b-form-input>
							 </b-form-group>
						  </b-col>
						  
						  <b-col>
							 <b-form-group
								label="przedplon"
								label-for="roslinaprzedplony"
								label-size="sm"
								description="roślina zastosowana na przedplon">
								<b-form-select
								  size="sm"
								  required
								  id="roslinaprzedplony"
								  :options="roslinaprzedplony"
								  v-model="uzytek.roslinaprzedplon_id"></b-form-select>
							 </b-form-group>
						  </b-col>

						  <b-col
							 v-if="(uzytek.roslinaprzedplon_id > 1) && (zlecenie.typ == true)">
							 <b-form-group
								label="stan przedplonu"
								label-for="stanprzedplonu"
								label-size="sm"
								description="przedplon zaorany czy zebrany?">
								<b-form-select
								  id="stanprzedplonu"
								  required
								  size="sm"
								  :options="stanyprzedplonu"
								  v-model="uzytek.stanprzedplonu"></b-form-select>
							 </b-form-group>
						  </b-col>
						  
						</b-form-row>

					 </b-form-group>

				  </b-col>

				</b-form-row>

			 </b-card>

			 <b-card
				bg-variant="light"
				class="mt-2">
				
				<b-form-row>
				  
				  <b-col>
					 
					 <b-form-group
						label="Rośliny bobowate"
						label-class="font-weight-bold">
						
						<b-form-row>

						  <b-col>
							 <b-form-group
								label="zastosowana roślina bobowata"
								label-for="bobowate"
								label-size="sm"
								description="na potrzeby wyznaczenia ilości azotu działającego pozostałego po uprawie roślin bobowatych">
								<b-form-select
								  required
								  size="sm"
								  id="bobowate"
								  :options="bobowate"
								  v-model="uzytek.bobowata_id"></b-form-select>
							 </b-form-group>
						  </b-col>

						</b-form-row>

					 </b-form-group>

				  </b-col>

				</b-form-row>

			 </b-card>
			 
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
				wspiwykorzystania: [],
				rosliny: [],
				kategorie: [],
				grunty: [],
				bobowate: [],
				roslinaprzedplony: [],
				gon: gon,
				badaniaoptions: [
					 { text: 'danych z Tabeli 12', value: false },
					 { text: 'przeprowadzonych badań', value: true },
				],
				nminsezonoptions: [
					 { text: 'wiosną', value: false },
					 { text: 'jesienią', value: true },
				],
				weglanowe: [
					 { text: 'nie', value: false },
					 { text: 'tak', value: true },
				],
				stanyprzedplonu: [
					 { text: 'przyorany', value: false },
					 { text: 'zebrany', value: true },
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
		  zlecenie: { get() { return this.$store.state.zlecenie },
					  set(v) { this.$store.commit('zlecenie', v) } },
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
				} else {
					 this.pobierzUzytek()
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
					 grunt_id: 1,
					 stanprzedplonu: false,
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
		  pobierzWspwykorzystania() {
				this.$http.get('/wspiwykorzystania.json')
					 .then((result) => { this.wspiwykorzystania = result.body })
					 .catch((error) => { console.log(error) })
		  },
		  pobierzGrunty() {
				this.$http.get('/grunty.json')
					 .then((result) => { this.grunty = result.body })
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
		  this.pobierzGrunty()
		  this.pobierzBobowate()
		  this.pobierzRoslinaprzedplony()
		  this.pobierzWspwykorzystania()
	 },
	 mounted() {
		  this.uprawamodal = this.$refs.uprawamodal
	 },
}
</script>
