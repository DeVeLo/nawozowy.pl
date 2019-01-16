<template>
<b-table
  thead-class="thead-dark"
  tfoot-class="thead-dark"
  striped
  hover
  foot-clone
  outlined
  show-empty
  empty-text="W tej chwili nie ma tutaj nic do wyświetlenia."
  :fields="naglowki"
  :items="uzytki"
  class="my-3">

  
  
  <template slot="przyciski" slot-scope="row">
	 <b-container fluid>

		<b-row>
		  <b-col class="text-center">
			 <b-button class="mt-1" size="sm" @click="edit(row.item)">
				edytuj
			 </b-button>
		  </b-col>

		  <b-col class="text-center">
			 <b-button class="my-1" v-show="row.item.id != confirm" @click="confirm = row.item.id" variant="danger" size="sm">
				usuń
			 </b-button>
			 
			 <span v-show="row.item.id == confirm">
				<p>na pewno?</p>
				<b-button @click="usun_uzytek(row.item.id, row.index)" variant="danger" size="sm">tak</b-button>
				<b-button @click="confirm = false" variant="secondary" size="sm">nie</b-button>
			 </span>
		  </b-col>
		  
		</b-row>
				
	 </b-container>
	 
  </template>

</b-table>
</template>

<script>
import {mapGetters} from 'vuex'
  
export default {
	 name: 'uprawatable',
	 data() {
		  return {
				naglowki: [
					 { key: 'name', label: 'oznaczenie' },
					 { key: 'przyciski', label: '' },
				],
				confirm: false,
		  }
	 },
	 computed: {
		  ...mapGetters(['uprawamodal']),
		  uzytki: { get() { return this.$store.state.uzytki },
						set(v) { this.$store.commit('uzytki', v) } },
		  uzytek: { get() { return this.$store.state.uzytek },
						set(v) { this.$store.commit('uzytek', v) } },
	 },
	 methods: {
		  usun_uzytek(id,index) {
				this.$http.delete('/instytucje/'
										+ gon.instytucja_id
										+ '/rolnicy/'
										+ gon.rolnik_id
										+ '/zlecenia/'
										+ gon.id
										+ '/uzytki/'
										+ id + '.json')
					 .then((result) => {
						  this.uzytki.splice(index,1)
					 })
					 .catch((error) => { console.log(error) })
		  },
		  edit(item) {
				this.uzytek = item
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
	 },
	 created() {
		  this.pobierzUzytki()
	 }
}
</script>
