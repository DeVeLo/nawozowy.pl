<template>
<b-container fluid>
  
  <b-row>
	 
	 <b-col xl="3">
		<crolnik></crolnik>
		<cinstytucja class="d-none d-xl-block"></cinstytucja>
	 </b-col>
	 
	 <b-col>
 		<b-row class="mt-3">
		  <b-col>
			 <h2>lista zleceń</h2>
		  </b-col>
		  
		  <b-col class="text-right">
			 <b-button :href="'/instytucje/' + gon.instytucja_id + '/rolnicy'">lista rolników</b-button>
			 <b-button @click="create">dodaj zlecenie</b-button>
		  </b-col>
		</b-row>
		
		<b-row>
		  <cform></cform>
		</b-row>
		
		<b-row>
		  <ctable></ctable>
		</b-row>
		
	 </b-col>
  </b-row>
  
</b-container>
</template>

<script>
import {mapActions, mapGetters} from 'vuex'
import cform from './components/cform.vue'
import ctable from './components/ctable.vue'
import crolnik from '../components/crolnik.vue'
import cinstytucja from '../components/cinstytucja.vue'

export default {
	 name: 'zlecenia',
	 data() {
		  return {
				gon: gon
		  }
	 },
	 components: {
		  cform,
		  ctable,
		  crolnik,
		  cinstytucja,
	 },
	 computed: {
		  ...mapGetters([ 'modalForm' ]),
		  attr: {
				get() {
					 return this.$store.state.attr
				},
				set(value) {
					 this.$store.commit('attr', value)
				}
		  }
	 },
	 methods: {
		  ...mapActions(['pobierz_instytucje', 'pobierz_rolnika']),
		  create() {
				this.attr = {
					 // domyślnie zlecenie w wariancie wykonanie
					 wariant_id: 1,
					 instytucja_id: gon.instytucja_id,
					 rolnik_id: gon.rolnik_id,
					 wojewodztwo_id: gon.wojewodztwo_id,
					 powiat_id: gon.powiat_id,
					 gmina_id: gon.gmina_id,
					 miejscowosc: gon.miejscowosc,
					 datawplywu: new Date
				}
				this.modalForm.show()
		  }
	 },
	 created() {
		  this.pobierz_instytucje()
		  this.pobierz_rolnika()
	 },
}
</script>
