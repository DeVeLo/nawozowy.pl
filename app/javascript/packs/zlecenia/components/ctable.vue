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
  :items="zlecenia">

  <template slot="wariant_id" slot-scope="row">
	 {{ row.item.wariant.name }}
  </template>

  <span slot="id" slot-scope="row">{{ row.value.substr(1,12) }}&nbsp;&#8230;</span>

  <template slot="rejestr" slot-scope="row">
	 {{ row.item.rejestr }}/{{ typ[row.item.typ] }}/{{ row.item.datawplywu.substr(0,4) }}
  </template>
  
  <template slot="przyciski" slot-scope="row">

	 <b-container fluid>

		<b-row>
 		  <b-col class="text-center">
			 <b-button size="sm" variant="info" @click="powiel(row.item.id)">
				powiel
			 </b-button>
		  </b-col>

 		  <b-col class="text-center">
			 <b-button size="sm" @click="edit(row.item)">
				edytuj
			 </b-button>
		  </b-col>

		  <b-col class="text-center">
			 <b-button v-show="row.item.id != confirm" @click="confirm = row.item.id" variant="danger" size="sm">
				usuń
			 </b-button>
			 
			 <span v-show="row.item.id == confirm">
				<p>na pewno?</p>
				<b-button @click="usun_zlecenie(row.item.id, row.index)" variant="danger" size="sm">tak</b-button>
				<b-button @click="confirm = false" variant="secondary" size="sm">nie</b-button>
			 </span>
		  </b-col>
		  
		  <b-col class="text-center">
			 <b-button :href="'/instytucje/' + row.item.instytucja_id + '/rolnicy/' + row.item.rolnik_id + '/zlecenia/' + row.item.id" size="sm" variant="primary">
				szczegóły
			 </b-button>
		  </b-col>

		</b-row>
				
	 </b-container>
  </template>
  
</b-table>
</template>

<script>
import {mapGetters, mapActions} from 'vuex'

export default {
	 name: 'ctable',
	 data() {
		  return {
				naglowki: [
					 { key: 'lp', label: 'n.p.', sortable: true },
					 { key: 'rejestr', label: 'nr rejestru', sortable: true },
					 { key: 'datawplywu', label: 'data wpływu', sortable: true },
					 { key: 'name', label: 'oznaczenie', sortable: true },
					 { key: 'wariant_id', label: 'wariant', sortable: true },
					 { key: 'przyciski', label: '' },
				],
				confirm: false,
				typ: {false: 'PA', true: 'PP'}
		  }
	 },
	 computed: {
		  ...mapGetters([ 'zlecenia' ]),
	 },
	 methods: {
		  ...mapActions([ 'pobierz' ]),
		  edit(item) {
				this.$store.commit('attr', item)
				this.$store.state.modalForm.show()
		  },
		  powiel(id) {
				this.$http.patch('/instytucje/' + gon.instytucja_id + '/rolnicy/' + gon.rolnik_id + '/zlecenia/' + id + '/powiel.json')
					 .then((result) => {
						  this.zlecenia.unshift(result.body)
					 })
					 .catch((error) => { console.log(error) })
		  },
		  usun_zlecenie(id,index) {
				this.$http.delete('/instytucje/' + gon.instytucja_id + '/rolnicy/' + gon.rolnik_id + '/zlecenia/' + id + '.json')
					 .then((result) => {
						  this.zlecenia.splice(index,1)
					 })
					 .catch((error) => { console.log(error) })
		  },
	 },
	 created() {
		  this.pobierz()
	 }
}
</script>
