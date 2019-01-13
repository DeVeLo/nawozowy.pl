<template>
<b-container fluid>
  
  <b-row>
	 <b-col xl="3">
		
		<cinstytucja></cinstytucja>
		
	 </b-col>
	 <b-col>
		<b-row class="mt-3">
		  <b-col>
			 <h2>lista rolników</h2>
		  </b-col>
		  <b-col class="text-right">
			 <b-button @click="create">dodaj rolnika</b-button>
		  </b-col>
		</b-row>
		
		<b-row>
		  
		  <cform></cform>
		  
		  <b-table
			 thead-class="thead-dark"
			 tfoot-class="thead-dark"
			 striped
			 hover
			 foot-clone
			 outlined
			 empty-text="W tej chwili nie ma tutaj nic do wyświetlenia."
			 show-empty
			 :fields="naglowki"
			 :items="rolnicy">
			 
			 <span slot="id" slot-scope="row">{{ row.value.substr(1,12) }}&nbsp;&#8230;</span>
			 
			 <template slot="lname" slot-scope="row">{{ row.item.name }} {{ row.item.lname }}</template>
			 
			 <template slot="przyciski" slot-scope="row">
				<b-container fluid>
				  <b-row>
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
						  <b-button @click="usun_rolnika(row.item.id, row.index)" variant="danger" size="sm">tak</b-button>
						  <b-button @click="confirm = false" variant="secondary" size="sm">nie</b-button>
						</span>
					 </b-col>
					 <b-col class="text-center">
						<b-button :href="'/instytucje/' + row.item.instytucja_id + '/rolnicy/' + row.item.id + '/zlecenia'" size="sm" variant="primary">
						  zlecenia
						</b-button>
					 </b-col>
				  </b-row>		  
				</b-container>
		</template>

  </b-table>
		</b-row>
	 </b-col>
  </b-row>
</b-container>
</template>

<script>
import {mapActions, mapGetters} from 'vuex'
import cform from './components/cform.vue'
import cinstytucja from '../components/cinstytucja.vue'

export default {
	 
	 name: 'rolnicy',
	 components: {
		  cform,
		  confirm: false,
		  cinstytucja,
	 },
	 computed: {
		  rolnicy: {
				get() {
					 return this.$store.state.rolnicy
				},
				set(value) {
					 this.$store.commit('rolnicy', value)
				},
		  },
	 },
	 data() {
		  return {
				form: {},
				wojewodztwa: [],
				powiaty: [],
				gminy: [],
				naglowki: [
					 { key: 'id',
						label: '#',
					 },
					 { key: 'nig', label: 'NIG', sortable: true },
					 { key: 'lname', label: 'imię i nazwisko', sortable: true },
					 { key: 'gname', label: 'nazwa', sortable: true },
					 { key: 'gmina', label: 'gmina', formatter: (v) => { return v.name }, sortable: true },
					 { key: 'przyciski', label: '' },
				],
				confirm: false,
		  }
	 },
	 methods: {
		  ...mapActions(['pobierz', 'pobierz_instytucje']),
		  usun_rolnika(id,index) {
				this.$http.delete('/instytucje/' + gon.instytucja_id + '/rolnicy/' + id + '.json')
					 .then((result) => {
						  this.rolnicy.splice(index,1)
					 })
					 .catch((error) => { console.log(error) })
		  },
		  create() {
				this.$store.commit('attr', {})
				this.$store.state.modalForm.show()
		  },
		  edit(item) {
				this.$store.commit('attr', item)
				this.$store.state.modalForm.show()
		  },
	 },
	 mounted() {
		  this.pobierz_instytucje()
		  this.pobierz()
	 }
}
</script>
