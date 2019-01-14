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

		</b-form-row>

	 <b-form-row>
		<b-col>
		  <b-form-group
			 label="kategoria agronomiczna gleby"
			 label-for="kategoria">
			 <b-form-select
				id="kategoria"
				:options="kategorie"
				v-model="uzytek.kategoria_id"></b-form-select>
		  </b-form-group>
		</b-col>

		<b-col>
		  <b-form-group
			 label="(wynika badania N<small>min</small> wiosną"
			 label-for="nmin">
			 <b-form-input
				></b-form-input>
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
export default {
	 name: 'uprawaform',
	 data() {
		  return {
				rodzajeuprawy: [],
				kategorie: [],
		  }
	 },
	 computed: {
		  uprawamodal: { get() { return this.$store.state.uprawamodal },
							  set(v) { this.$store.commit('uprawamodal', v) } },
		  uzytek: { get() { return this.$store.state.uzytek },
						set(v) { this.$store.commit('uzytek', v) } },
	 },
	 methods: {
		  title() {
				
		  },
		  focus() {

		  },
		  save(e) {
				e.preventDefault()
		  },
		  reset(e) {
				e.preventDefault()
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
		  }
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
