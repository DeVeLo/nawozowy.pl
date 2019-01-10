<template>
<div class="container">
  <p>&nbsp;</p>
  
  <b-container>
	 <b-row>
		<b-col>
		  <h1>lista rolników</h1>
		</b-col>
		<b-col class="text-right">
		  <b-button @click="create">dodaj rolnika</b-button>
		</b-col>
	 </b-row>
  </b-container>
  
  <p>&nbsp;</p>

  <cform></cform>
  
  <b-table
	 thead-class="thead-dark"
	 tfoot-class="thead-dark"
	 striped
	 hover
	 foot-clone
	 outlined
	 :fields="naglowki"
	 :items="rolnicy">

	 <template slot="name" slot-scope="row">
		{{ row.item.name }} {{ row.item.lname }}
	 </template>
	 
	 <template slot="przyciski" slot-scope="row">
		<b-container>
		  <b-row>
			 <b-col>
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
				  <b-button @click="confirm = false" variant="success" size="sm">nie</b-button>
				</span>
			 </b-col>
			 </b-row>
		</b-container>
	 </template>

  </b-table>
  
</div>
</template>

<script>
import cform from './components/cform.vue'

export default {
	 
	 name: 'rolnicy',
	 components: {
		  cform,
		  confirm: false
	 },
	 computed: {
		  rolnicy: {
				get() {
					 return this.$store.state.rolnicy
				},
				set(value) {
					 this.$store.commit('rolnicy', value)
				},
		  }
	 },
	 data() {
		  return {
				form: {},
				wojewodztwa: [],
				powiaty: [],
				gminy: [],
				naglowki: [
					 { key: 'nig', label: '# NIG' },
					 { key: 'name', label: 'imię i nazwisko' },
					 { key: 'gname', label: 'nazwa' },
					 { key: 'gmina', label: 'gmina', formatter: (v) => { return v.name } },
					 { key: 'przyciski', label: 'przyciski' },
				],
				confirm: false,
		  }
	 },
	 methods: {
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
		  edit(item, index) {
				this.$store.commit('attr', item)
				this.form.row = item
				this.form.wojewodztwo_id = item.wojewodztwo_id
				this.$store.state.modalForm.show()
		  },
		  pobierz(v = { offset: 0, page: 0, rows: 20 }) {
				this.$http.get('/instytucje/' + gon.instytucja_id + '/rolnicy.json')
					 .then((result) => {
						  this.rolnicy = result.body
					 })
					 .catch((error) => { console.log(error) })
		  },
	 },
	 mounted() {
		  this.pobierz()
	 }
}
</script>
