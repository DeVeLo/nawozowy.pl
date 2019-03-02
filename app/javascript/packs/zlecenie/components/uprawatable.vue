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

  <template slot="powierzchnia" slot-scope="row">
	 <span :id="'uzytki_powierzchnia_' + row.item.id">{{ row.item.powierzchnia }}&nbsp;ha</span>
  </template>

  <template slot="roslina" slot-scope="row">
	 <span :id="'uzytki_roslina_' + row.item.id">{{ row.item.roslina.name }}&nbsp;ha</span>
	 <b-tooltip :target="'uzytki_roslina_' + row.item.id">
		{{ row.item.roslina.rodzajuprawy.name }}
	 </b-tooltip>
  </template>
  
  <template slot="zapotrzebowanie" slot-scope="row">
	 <span :id="'uzytki_zapotrzebowanie_' + row.item.id">{{ row.item.zapotrzebowanie }}&nbsp;kg N</span>
	 <b-tooltip :target="'uzytki_zapotrzebowanie_' + row.item.id">
		<strong>sposób liczenia:</strong> powierzchnia&nbsp;{{ row.item.powierzchnia }}&nbsp;ha&nbsp;*&nbsp;plon&nbsp;{{ row.item.plon }}&nbsp;t&nbsp;*&nbsp;pobranie&nbsp;{{ row.item.roslina.pobranie }}&nbsp;kg&nbsp;N/ha
	 </b-tooltip>
  </template>
  
  <template slot="przyciski" slot-scope="row">
	 <b-container fluid>

		<b-row>
		  <b-col class="text-center">
			 <b-button
				class="mt-1"
				size="sm"
				target="_blank"
				:href="'/instytucje/' + gon.instytucja_id + '/rolnicy/' + gon.rolnik_id + '/zlecenia/' + gon.id + '/uzytki/' + row.item.id + '.pdf'"
				variant="warning">
				PDF
			 </b-button>
		  </b-col>

		  <b-col class="text-center">
			 <b-button variant="primary" class="mt-1" size="sm" @click="zrodla(row.item)">
				źródła&nbsp;N
			 </b-button>
		  </b-col>

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
				gon: gon,
				naglowki: [
					 { key: 'lp', label: 'n.p.', sortable: true },
					 { key: 'name', label: 'oznaczenie' },
					 { key: 'roslina', label: 'roślina' },
					 { key: 'powierzchnia', label: 'powierzchnia' },
					 { key: 'zapotrzebowanie', label: 'zapotrzebowanie' },
					 { key: 'przyciski', label: '' },
				],
				confirm: false,
		  }
	 },
	 computed: {
		  ...mapGetters(['uprawamodal', 'uprawazrodla']),
		  uzytki: { get() { return this.$store.state.uzytki },
						set(v) { this.$store.commit('uzytki', v) } },
		  uzytek: { get() { return this.$store.state.uzytek },
						set(v) { this.$store.commit('uzytek', v) } },
		  sezony: { get() { return this.$store.state.sezony },
						set(v) { this.$store.commit('sezony', v) } },
		  ilosc: { get() { return this.$store.state.ilosc },
					  set(v) { this.$store.commit('ilosc', v) } },
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
				this.sezony = []
				this.ilosc = []
				for (var s in item.nawozynaturalne) {
					 this.sezony[item.nawozynaturalne[s].animal_id] = item.nawozynaturalne[s].sezon_id
					 this.ilosc[item.nawozynaturalne[s].animal_id] = item.nawozynaturalne[s].ilosc
				}
				
				this.uprawamodal.show()
		  },
		  zrodla(item) {
				this.uzytek = item
				this.uprawazrodla.show()
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
