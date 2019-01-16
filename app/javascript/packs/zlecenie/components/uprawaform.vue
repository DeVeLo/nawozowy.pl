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
  @hidden="reset">
  <b-form @submit="save" @reset="reset">
	 <b-form-row>
		<input type="hidden" id="id" v-model="uzytek.id"></input>
		<input type="hidden" id="instytucja_id" v-model="uzytek.instytucja_id"></input>
		<input type="hidden" id="rolnik_id" v-model="uzytek.rolnik_id"></input>
		<input type="hidden" id="zlecenie_id" v-model="uzytek.zlecenie_id"></input>
		
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
		
		<b-col v-if="uzytek.badania == true">
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
		
	 </b-form-row>
	 
	 
	 <div slot="modal-footer" class="w-100 text-center">
		<hr />
		<b-button type="button" @click="uprawamodal.hide()">anuluj</b-button>
		<b-button type="reset" variant="dark">resetuj</b-button>
		<b-button type="submit" variant="primary">zapisz</b-button>
	 </div>
	 
  </b-form>
</b-modal>
</template>

<script>
import {mapActions, mapGetters} from 'vuex'

export default {
	 name: 'uprawaform',
	 data() {
		  return {
				rodzajeuprawy: [],
				kategorie: [],
				gon: gon,
				badaniaoptions: [
					 { text: 'danych z Tabeli 12', value: false },
					 { text: 'przeprowadzonych badań', value: true },
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
				}
		  },
		  save(e) {
				e.preventDefault()

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
								this.uprawamodal.hide()
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
								this.uprawamodal.hide()
						  })
						  .catch((error) => console.log(error))
				}
		  },
		  reset(e) {
				e.preventDefault()

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
		  pobierzKategorie() {
				this.$http.get('/kategorie.json')
					 .then((result) => { this.kategorie = result.body })
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
									+this.uzytek.id
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
	 },
	 mounted() {
		  this.uprawamodal = this.$refs.uprawamodal
	 },
}
</script>
