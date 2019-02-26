<template>
<b-modal
  :title="title(attr.id)"
  centered
  id="modalForm"
  ref="modalForm"
  size="lg"
  header-bg-variant="dark"
  header-text-variant="light"
  hide-footer
  @shown="focus"
  @hidden="clear()">
  
  <b-form @submit="save" @reset="reset">
	 
	 <b-form-row>
		<input type="hidden" id="id" v-model="attr.id"></input>
		<input type="hidden" id="instytucja_id" :value="attr.instytucja_id"></input>
		<input type="hidden" id="rolnik_id" :value="attr.rolnik_id"></input>
	 </b-form-row>
	 
	 <b-form-row>
		<b-col cols="1">
		  <b-form-group
			 label="n.p."
			 label-for="lp">
			 <b-form-input
				type="number"
				id="lp"
				ref="zlecenie_lp"
				v-model="attr.lp"></b-form-input>
		  </b-form-group>
		</b-col>

		<b-col>
		  <b-form-group
			 label="rok gospodarczy"
			 label-for="name">
			 <b-form-input
				required
				id="name"
				ref="zlecenie_name"
				v-model="attr.name"></b-form-input>
		  </b-form-group>
		</b-col>
		<b-col>
		  <b-form-group
			 label="nr/kod sprawy (opcjonalnie)"
			 label-for="sprawa">
			 <b-form-input
				id="sprawa"
				v-model="attr.sprawa"></b-form-input>
		  </b-form-group>
		</b-col>
		<b-col>
		  <b-form-group
			 label="data wpływu"
			 label-for="datawplywu">
			 <datepicker
				bootstrap-styling
				required
				:language="pl"
				id="datawplywu"
				v-model="attr.datawplywu"></datepicker>
		  </b-form-group>
		</b-col>
	 </b-form-row>
	 
	 <b-form-row>
		<b-col>
		  <b-form-group
			 label="rodzaj"
			 label-for="wariant_id">
			 <b-form-select
				required
				id="warianty"
				:options="warianty"
				v-model="attr.wariant_id">
			 </b-form-select>
		  </b-form-group>
		</b-col>
		
		<b-col v-if="attr.wariant_id == 2">
		  <b-form-group
			 label="zaopiniowanie na podstawie"
			 label-for="podstawa_id">
			 <b-form-select
				required
				id="podstawa"
				:options="podstawy"
				v-model="attr.podstawa_id">
			 </b-form-select>
		  </b-form-group>
		</b-col>

	 </b-form-row>

	 <b-form-row v-if="attr.podstawa_id == 3 && attr.wariant_id == 2">
		<b-col>
		  <b-form-group
			 label="zaopiniowanie na jakiej innej podstawie"
			 label-for="podstawainna">
			 <b-form-input
				required
				id="podstawainna"
				v-model="attr.podstawainna"></b-form-input>
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
	 </b-form-row>

	 <b-form-row>
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

		<b-col v-show="attr.gmina_id">
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
	 </b-form-row>
		
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
import Datepicker from 'vuejs-datepicker'
import {pl} from 'vuejs-datepicker/dist/locale'
  
export default {
	 name: 'cform',
	 data() {
		  return {
				podstawy: [],
				warianty: [],
				wojewodztwa: [],
				powiaty: [],
				gminy: [],
				pl: pl,
		  }
	 },
	 components: {
		  Datepicker
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
		  zlecenia: {
				get() {
					 return this.$store.state.zlecenia
				},
				set(value) {
					 this.$store.commit('zlecenia', value)
				}
		  },
	 },
	 methods: {
		  title(id) {
				if (id) {
					 return 'edytuj dane zlecenia'
				} else {
					 return 'dodaj zlecenie do bazy'
				}
		  },
		  focus() {
				this.$refs.zlecenie_name.focus()
		  },
		  clear() {
				if (this.attr.id) {
					 this.pobierz_zlecenie()
				} else {
					 this.attr = {
						  wariant_id: 1,
						  instytucja_id: gon.instytucja_id,
						  rolnik_id: gon.rolnik_id,
					 }
				}
		  },
		  save(e) {
				e.preventDefault()
				
				if (this.attr.id) {
					 // update
					 this.$http.patch('/instytucje/' +
											this.attr.instytucja_id +
											"/rolnicy/" +
											this.attr.rolnik_id +
											"/zlecenia/" +
											this.attr.id + ".json",
											{ zlecenie: this.attr }, {})
						  .then((res) => {
								this.modalForm.hide()
						  })
						  .catch((error) => console.log(error))
				} else {
					 // create
					 this.attr.id = null;
					 this.$http.post('/instytucje/' +
										  this.attr.instytucja_id +
										  "/rolnicy/" +
										  this.attr.rolnik_id +
										  "/zlecenia.json",
										  { zlecenie: this.attr }, {}
										 )
						  .then((result) => {
								this.zlecenia.unshift(result.body)
								this.modalForm.hide()
						  })
						  .catch((error) => console.log(error))
				}
				
		  },
		  reset(e) {
				e.preventDefault()
				
				if (this.attr.id) {
					 this.pobierz_zlecenie()
				} else {
					 this.clear()
				}
		  },
		  pobierz_zlecenie() {
				this.$http.get('/instytucje/' + gon.instytucja_id + '/rolnicy/' + gon.rolnik_id + '/zlecenia/' + this.attr.id + '.json')
					 .then((result) => {
						  for (var k in result.body) {
								this.attr[k] = result.body[k]
						  }
					 })
					 .catch((error) => { console.log(error) })
		  },
		  pobierz_warianty() {
				this.$http.get('/warianty.json')
					 .then((result) => { this.warianty = result.body })
					 .catch((error) => { console.log(error) })
		  },
		  pobierz_podstawy() {
				this.$http.get('/podstawy.json')
					 .then((result) => { this.podstawy = result.body })
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
		  this.pobierz_podstawy()
		  this.pobierz_warianty()
		  this.pobierz_wojewodztwa()
		  this.$store.commit('modalForm', this.$refs.modalForm)
	 },
}
</script>
