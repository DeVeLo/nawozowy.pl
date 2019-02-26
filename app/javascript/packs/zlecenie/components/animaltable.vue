<template>
<b-table
  class="m-0 p-0"
  thead-class="thead-light"
  striped
  hover
  outlined
  show-empty
  small
  :empty-text="'W tej chwili nie ma tutaj nic do wyświetlenia. '"
  :fields="naglowki"
  :items="animals.filter((x) => { return x.animalgroup_id == animalgroup.id })">

  <template slot="nazwautrzymania" slot-scope="row">
	 {{ row.item.nazwautrzymania.name }}
  </template>

  <template slot="zwierze" slot-scope="row">
	 {{ row.item.zwierze.name }}
  </template>

  <template slot="produkcja" slot-scope="row">
	 <span :id="'produkcja_obornik_gnojowica_' + row.item.id">{{ row.item.produkt }}&nbsp;{{ row.item.systemutrzymania.jednostkautrzymania.produkcja }}</span>
	 <b-tooltip :target="'produkcja_obornik_gnojowica_' + row.item.id">
		<strong>produkcja jednostkowa:</strong> {{ row.item.systemutrzymania.produkcja }}&nbsp;{{ row.item.systemutrzymania.jednostkautrzymania.produkcja }}
	 </b-tooltip>
  </template>

  <template slot="zawartosc" slot-scope="row">
	 <span :id="'zawartosc_azotu_' + row.item.id">{{ row.item.azot }}&nbsp;kg/rok</span>
	 <b-tooltip :target="'zawartosc_azotu_' + row.item.id">

		<span v-if="row.item.badania">
		  <span>
			 <strong>zawartość N na podstawie wyników badań:</strong> {{ row.item.zawartosc_wynikowa }}&nbsp;{{ row.item.systemutrzymania.jednostkautrzymania.zawartosc }}
		  </span>
		</span>
		  
		<span v-else>
		  <span v-if="row.item.specjalnezywienie">
			 <strong>zawartość N z Tabeli 9 (zastosowano specjalne żywienie):</strong> {{ row.item.systemutrzymania.zawartosc * row.item.zwierze.koncentracja }}&nbsp;{{ row.item.systemutrzymania.jednostkautrzymania.zawartosc }}
		  </span>
		  <span v-else>
			 <strong>zawartość N z Tabeli 9:</strong> {{ row.item.systemutrzymania.zawartosc }}&nbsp;{{ row.item.systemutrzymania.jednostkautrzymania.zawartosc }}
		  </span>
		</span>
		
	 </b-tooltip>
  </template>

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
				<b-button @click="usun_animal(row.item.id, row.index)" variant="danger" size="sm">tak</b-button>
				<b-button @click="confirm = false" variant="secondary" size="sm">nie</b-button>
			 </span>
		  </b-col>
		  
		</b-row>
				
	 </b-container>
	 
  </template>
  
</b-table>
</template>
<script>
import {mapActions, mapGetters} from 'vuex'
export default {
	 name: 'animaltable',
	 props: ['animalgroup'],
	 data() {
		  return {
				gon: gon,
				naglowki: [
					 { key: 'zwierze', label: 'zwierzę' },
					 { key: 'sztuk', label: 'szt.' },
					 { key: 'nazwautrzymania', label: 'system utrzymania' },
					 { key: 'produkcja', label: 'ilość nawozu wyprodukowanego / zakupionego' },
					 { key: 'zawartosc', label: 'prod N' },
					 { key: 'przyciski', label: '' },
				],
				confirm: false,
		  }
	 },
	 computed: {
		  animal: {
				get() { return this.$store.state.animal },
				set(v) { this.$store.commit('animal', v) }
		  },
		  animals: {
				get() { return this.$store.state.animals },
				set(v) { this.$store.commit('animals', v) }
		  },
		  ...mapGetters(['animalmodal']),
	 },
	 methods: {
		  usun_animal(id,index) {
				this.$http.delete('/instytucje/'
										+ gon.instytucja_id
										+ '/rolnicy/'
										+ gon.rolnik_id
										+ '/zlecenia/'
										+ gon.id
										+ '/animalgroups/'
										+ this.animalgroup.id
										+ '/animals/'
										+ id + '.json')
					 .then((result) => {
						  this.animals.splice(index,1)
					 })
					 .catch((error) => { console.log(error) })
		  },
		  edit(item) {
				this.animal = item
				this.animalmodal.show()
		  },
		  pobierzAnimals() {
				this.$http.get('/instytucje/'
									+ gon.instytucja_id
									+ '/rolnicy/'
									+ gon.rolnik_id
									+ '/zlecenia/'
									+ gon.id
									+ "/animalgroups/"
									+ this.animalgroup.id
									+ '/animals.json')
					 .then((result) => {
						  this.animals = result.body
					 })
					 .catch((error) => { console.log(error)} )
		  },
	 },
	 created() {
		  this.pobierzAnimals()
	 }
}
</script>
