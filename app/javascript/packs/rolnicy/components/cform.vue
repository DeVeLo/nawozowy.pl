<template>
<b-modal
  :title="title(attr.id)"
  centered
  id="formModal"
  ref="formModal"
  size="lg"
  header-bg-variant="dark"
  header-text-variant="light"
  hide-footer
  @shown="focus_rolnik_name"
  @hidden="reset">
  
  <b-form @submit="save" @reset="reset">
	 
	 <b-container>
		
		<b-form-row>

		  <input type="hidden" id="id" v-model="attr.id"></input>
		  <input type="hidden" id="instytucja_id" v-model="attr.instytucja_id"></input>
			 
			 <b-col>
				<b-form-group
				  label="imię"
				  label-for="name">
				  <b-form-input
					 required
					 id="name"
					 ref="rolnik_name"
					 v-model="attr.name">
				  </b-form-input>
				</b-form-group>
			 </b-col>
			 
			 <b-col>
				<b-form-group
				  label="nazwisko"
				  label-for="lname">
				  <b-form-input
					 required
					 id="lname"
					 v-model="attr.lname">
				  </b-form-input>
				</b-form-group>
			 </b-col>
		</b-form-row>
		
		<b-form-row>
		  <b-col>
			 <b-form-group
				label="nazwa przedsiębiorstwa"
				label-for="gname">
				<b-form-input
				  id="gname"
				  v-model="attr.gname">
				</b-form-input>
			 </b-form-group>
		  </b-col>
		</b-form-row>
		
		<b-form-row>
		  <b-col>
			 <b-form-group
				label="NIP"
				label-for="nip">
				<b-form-input
				  id="nip"
				  v-model="attr.nip">
				</b-form-input>
			 </b-form-group>
		  </b-col>
		  <b-col>
			 <b-form-group
				label="NIG"
				label-for="nig">
				<b-form-input
				  id="nig"
				  v-model="attr.nig">
				</b-form-input>
			 </b-form-group>
		  </b-col>
		</b-form-row>
		
		<b-form-row>
		  <b-col>
			 <b-form-group
				label="województwo"
				label-for="wojewodztwo_id">
				<b-form-select
				  required
				  @input="pobierz_powiaty(attr.wojewodztwo_id)"
				  id="wojewodztwo_id"
				  :options="wojewodztwa"
				  v-model="attr.wojewodztwo_id">
				</b-form-select>
			 </b-form-group>
		  </b-col>
		  
		  <b-col v-show="attr.wojewodztwo_id">
			 <b-form-group
				label="powiat"
				label-for="powiat_id">
				<b-form-select
				  @input="pobierz_gminy(attr.powiat_id)"
				  required
				  id="powiat_id"
				  :options="powiaty"
				  v-model="attr.powiat_id">
				</b-form-select>
			 </b-form-group>
		  </b-col>
		  
		  <b-col v-show="attr.powiat_id">
			 <b-form-group
				label="gmina"
				label-for="gmina_id">
				<b-form-select
				  required
				  id="gmina_id"
				  :options="gminy"
				  v-model="attr.gmina_id">
				</b-form-select>
			 </b-form-group>
		  </b-col>
		</b-form-row>
		
		<b-form-row v-show="attr.gmina_id">
		  <b-col>
			 <b-form-group
				label="miejscowość"
				label-for="miejscowosc">
				<b-form-input
				  required
				  id="miejscowosc"
				  v-model="attr.miejscowosc">
				</b-form-input>
			 </b-form-group>
		  </b-col>
		  
		  <b-col>
			 <b-form-group
				label="ulica"
				label-for="ulica">
				<b-form-input
				  id="ulica"
				  v-model="attr.ulica">
				</b-form-input>
			 </b-form-group>
		  </b-col>
		</b-form-row>
		
		<b-form-row v-show="attr.gmina_id">
		  <b-col cols="2">
			 <b-form-group
				label="nr domu"
				label-for="nrdom">
				<b-form-input
				  required
				  id="nrdom"
				  v-model="attr.nrdom">
				</b-form-input>
			 </b-form-group>
		  </b-col>
		  <b-col cols="2">
			 <b-form-group
				label="nr mieszkania"
				label-for="nrmieszkania">
				<b-form-input
				  id="nrmieszkania"
				  v-model="attr.nrmieszkania">
				</b-form-input>
			 </b-form-group>
		  </b-col>

		  <b-col cols="3">
			 <b-form-group
				label="kod"
				label-for="kod">
				<b-form-input
				  required
				  id="kod"
				  v-model="attr.kod">
				</b-form-input>
			 </b-form-group>
		  </b-col>

		  <b-col>
			 <b-form-group
				label="poczta"
				label-for="poczta">
				<b-form-input
				  required
				  id="poczta"
				  v-model="attr.poczta">
				</b-form-input>
			 </b-form-group>
		  </b-col>
		  
		</b-form-row>

		<b-form-row>
		  <b-col cols="3">
			 <b-form-group
				label="tel."
				label-for="tel">
				<b-form-input
				  id="tel"
				  v-model="attr.tel">
				</b-form-input>
			 </b-form-group>
		  </b-col>
		  <b-col cols="3">
			 <b-form-group
				label="kom:"
				label-for="kom">
				<b-form-input
				  id="kom"
				  v-model="attr.kom">
				</b-form-input>
			 </b-form-group>
		  </b-col>
		  <b-col>
			 <b-form-group
				label="email"
				label-for="mail">
				<b-form-input
				  id="mail"
				  v-model="attr.mail">
				</b-form-input>
			 </b-form-group>
		  </b-col>
		</b-form-row>
		
  	 </b-container>

	 <div slot="modal-footer" class="w-100 text-center">
		<hr />
		<b-button type="button" @click="modalForm.hide()">anuluj</b-button>
		<b-button type="reset" variant="dark">resetuj</b-button>
		<b-button type="submit" variant="primary">zapisz</b-button>
	 </div>
	 
  </b-form>

</b-modal>
</template>
<script>

export default {
	 name: 'cform',
	 data() {
		  return {
				wojewodztwa: [],
				powiaty: [],
				gminy: []
		  }
	 },
	 computed: {
		  attr: {
				get() {
					 return this.$store.state.attr
				},
				set(value) {
					 this.$store.commit('attr', value)
				}
		  },
		  modalForm: {
				get() {
					 return this.$store.state.modalForm
				},
				set(value) {
					 this.$store.commit('modalForm', value)
				}
		  },
		  rolnicy: {
				get() {
					 return this.$store.state.rolnicy
				},
				set(value) {
					 this.$store.commit('rolnicy', value)
				}
		  },
	 },
	 methods: {
		  title(id) {
				if (id) {
					 return 'edytuj dane rolnika'
				} else {
					 return 'dodaj rolnika do bazy'
				}
		  },
		  save(e) {
				e.preventDefault()
				
				if (this.attr.id) {
					 // update
					 this.$http.patch('/instytucje/' + gon.instytucja_id + "/rolnicy/" + this.attr.id + ".json", { rolnik: this.attr }, {})
						  .then((res) => {
								this.$refs.formModal.hide()
						  })
						  .catch((error) => console.log(error))
				} else {
					 // create
					 this.attr.id = null;
					 this.$http.post('/instytucje/' + gon.instytucja_id + "/rolnicy", { rolnik: this.attr }, {})
						  .then((res) => {
								this.rolnicy.unshift(res.body)
								this.$refs.formModal.hide()
						  })
						  .catch((error) => console.log(error))
				}
		  },
		  reset(e = false) {
				if (e) { e.preventDefault() }
				
				if (this.attr.id) {
					 this.pobierz_rolnika()
				} else {
					 this.clear()
				}
		  },
		  clear(data = false) {
				this.attr = {}
		  },
		  focus_rolnik_name() {
				this.$refs.rolnik_name.focus()
		  },
		  pobierz(v = { offset: 0, page: 0, rows: 20 }) {
				this.$http.get('/instytucje/' + gon.instytucja_id + '/rolnicy.json')
					 .then((result) => {
						  this.rolnicy = result.body
					 })
					 .catch((error) => { console.log(error) })
		  },
		  pobierz_rolnika() {
				this.$http.get('/instytucje/' + gon.instytucja_id + '/rolnicy/' + this.attr.id + '.json')
					 .then((result) => {
						  for (var k in result.body) {
								this.attr[k] = result.body[k]
						  }
					 })
					 .catch((error) => { console.log(error) })
		  },
		  pobierz_wojewodztwa() {
				this.$http.get('/wojewodztwa.json')
					 .then((result) => { this.wojewodztwa = result.body; })
					 .catch((error) => { console.log(error) })
		  },
		  pobierz_powiaty(w = false) {
				if (w) {
					 this.$http.get('/wojewodztwa/' + w + '/powiaty.json')
						  .then((result) => { this.powiaty = result.body; })
						  .catch((error) => { console.log(error) })
				}
		  },
		  pobierz_gminy(p = false) {
				if (p) {
					 this.$http.get('/powiaty/' + p + '/gminy.json')
						  .then((result) => { this.gminy = result.body; })
						  .catch((error) => { console.log(error) })
				}
		  }
	 },
	 mounted() {
		  this.$store.commit('modalForm', this.$refs.formModal)
		  this.pobierz_wojewodztwa()
	 }
}
</script>
