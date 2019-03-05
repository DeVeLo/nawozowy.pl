<template>
<b-container class="text-left m-0 p-0">
  <b-card
	 bg-variant="light"
	 class="mt-2">
	 
	 <b-form-row>
		
		<b-col>
		  
		  <b-form-group
			 label="Rozdysponuj nawóz naturalny"
			 label-class="font-weight-bold">

			 <b-form-row v-for="group in animalgroups">
				<b-col>
				  <dl>
					 <dt>{{ group.animalsname }}</dt>
					 <dd>
						produkcja: {{ group.produkt }} t(m<sup>3</sup>)	/
						pozostało: {{ group.pozostalynawoz }} t(m<sup>3</sup>)
					 </dd>
					 <dd>
						produkcja N: {{ group.produkcja_azot }} kg /
						pozostały N: {{ group.pozostaly_azot }} kg
					 </dd>
					 <dd>
						produkcja P<sub>2</sub>O<sub>5</sub>: {{ group.produkcja_fosfor }} kg /
						pozostały P<sub>2</sub>O<sub>5</sub>: {{ group.pozostaly_fosfor }} kg
					 </dd>
					 <dd>
						produkcja K<sub>2</sub>O: {{ group.produkcja_potas }} kg /
						pozostały K<sub>2</sub>O: {{ group.pozostaly_potas }} kg
					 </dd>
				  </dl>
				</b-col>
			 </b-form-row>
			 
			 <b-form-row>
  
				<b-col cols="6">
				  <b-form-group
					 label="wybierz nawóz"
					 label-for="animalgroups"
					 label-size="sm">
					 <b-form-select
						size="sm"
						id="animalgroups"
						:options="animalgroups"
						@input="pobierzAnimalgroup(animalgroup_id)"
						v-model="animalgroup_id"></b-form-select>
				  </b-form-group>
				</b-col>
	 
				<b-col cols="3">
				  <b-form-group
					 label="sezon"
					 label-for="sezony"
					 label-size="sm">
					 <b-form-select
						size="sm"
						id="sezony"
						:options="sezonoptions"
						v-model="sezon_id"></b-form-select>
				  </b-form-group>
				</b-col>
				
				<b-col cols="2">
				  <b-form-group
					 label="ilość t/ha"
					 label-for="ilosc"
					 label-size="sm">
					 <b-form-input
						size="sm"
						id="ilosc"
						v-model="ilosc"
						:formatter="formatter_decimal"></b-form-input>
				  </b-form-group>
				</b-col>
				
				<b-col cols="1">
				  <b-form-group
					 label="&nbsp;"
					 label-size="sm"
					 label-for="dodajnawoz">
					 <b-button
						id="dodajnawoz"
						size="sm"
						@click="save()">dodaj</b-button>
				  </b-form-group>
				</b-col>

			 </b-form-row>
			 
		  </b-form-group>

		</b-col>

	 </b-form-row>

  </b-card>
			 
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
	 :items="uzytek.nawozynaturalne_attributes">
	 <template slot="ilosc" slot-scope="row">
		{{ row.item.ilosc }}&nbsp;t/ha
	 </template>

	 <template slot="ilosc_na_pole" slot-scope="row">
		{{ row.item.ilosc_na_pole }}&nbsp;t
	 </template>
	 
	 <template slot="przyciski" slot-scope="row">
		<b-button variant="danger" @click="destroy(row.item.id, row.index)">[&nbsp;-&nbsp;]</b-button>
	 </template>
	 
  </b-table>
  
</b-container>
</template>
<script>
import {mapGetters, mapActions} from 'vuex'
  
export default {
	 name: 'uprawanaturalny',
	 data() {
		  return {
				animalgroup: {},
				ilosc: "",
				sezon_id: false,
				animalgroup_id: false,
				gon: gon,
				naglowki: [
					 { key: 'grupa', label: 'grupa zwierząt' },
					 { key: 'sezon_name', label: 'sezon' },
					 { key: 'ilosc', label: 'ilość' },
					 { key: 'ilosc_na_pole', label: 'ilość na pole' },
					 { key: 'przyciski', label: '' },
				],
				confirm: false,
				sezonoptions: [
					 { text: 'jesień', value: 1 },
					 { text: 'wiosna', value: 2 },
				],
		  }
	 },
	 methods: {
		  ...mapActions([ 'pobierz' ]),
		  pobierzUzytek() {
				this.$http.get('/instytucje/'
									+ gon.instytucja_id
									+ '/rolnicy/'
									+ gon.rolnik_id
									+ '/zlecenia/'
									+ gon.id
									+ '/uzytki/'
									+ this.uzytek.id
									+ '.json')
					 .then((result) => {
						  for (var k in result.body) {
								this.uzytek[k] = result.body[k]
						  }
					 })
					 .catch((error) => { console.log(error) })
		  },
		  save() {
				this.$http.post('/instytucje/'
										  + gon.instytucja_id
										  + "/rolnicy/"
										  + gon.rolnik_id
										  + "/zlecenia/"
										  + gon.id
										  + "/uzytki/"
										  + this.uzytek.id
										  + "/nawozynaturalne.json",
									 {
										  animalgroup_id: this.animalgroup_id,
										  sezon_id: this.sezon_id,
										  ilosc: this.ilosc,
									 },
									 {})
					 .then((result) => {
						  // this.uzytek.nawozynaturalne_attributes.push(result.body)
						  this.pobierzUzytek()
						  this.wyczyscNawoz()
						  this.pobierz()
						  this.pobierzAnimalgroup(result.body.animalgroup.id)
						  this.pobierzAnimalgroups()
					 })
					 .catch((error) => {
						  console.log(error)
					 })
		  },
		  pobierzUzytek() {
				this.$http.get('/instytucje/'
									+ gon.instytucja_id
									+ '/rolnicy/'
									+ gon.rolnik_id
									+ '/zlecenia/'
									+ gon.id
									+ '/uzytki/'
									+ this.uzytek.id
									+ '.json')
					 .then((result) => {
						  for (var k in result.body) {
								this.uzytek[k] = result.body[k]
						  }
					 })
					 .catch((error) => { console.log(error) })
		  },
		  destroy(id, index) {
				this.$http.delete('/instytucje/'
										+ gon.instytucja_id
										+ "/rolnicy/"
										+ gon.rolnik_id
										+ "/zlecenia/"
										+ gon.id
										+ "/uzytki/"
										+ this.uzytek.id
										+ "/nawozynaturalne/"
										+ id + ".json",)
					 .then((result) => {
						  let animalgroup_id = this.uzytek.nawozynaturalne_attributes[index].animalgroup_id
						  this.uzytek.nawozynaturalne_attributes.splice(index,1)
						  this.pobierz()
						  this.pobierzUzytek()
						  this.pobierzAnimalgroup(animalgroup_id)
						  this.pobierzAnimalgroups()
					 })
					 .catch((error) => {
						  console.log(error)
					 })
		  },
		  wyczyscNawoz() {
				this.ilosc = ""
				this.sezon_id = false
				this.animalgroup_id = false
		  },
		  formatter_decimal(v,e) {
				if (v !== null) {
					 v = v.replace(',','.')
					 var r = /^[0-9]+([.]{0,1}[0-9]*)?$/g
					 if (r.test(v)) { return v } else { return v.substr(0, v.length -1)}
				} else { return '' }
		  },
		  pobierzAnimalgroups() {
				this.$http.get('/instytucje/'
									+ gon.instytucja_id
									+ '/rolnicy/'
									+ gon.rolnik_id
									+ '/zlecenia/'
									+ gon.id
									+ '/animalgroups.json')
					 .then((result) => { this.animalgroups = result.body })
					 .catch((error) => { console.log(error)} )
		  },
		  pobierzAnimalgroup(id) {
				if (id) {
					 this.$http.get('/instytucje/'
										 + gon.instytucja_id
										 + '/rolnicy/'
										 + gon.rolnik_id
										 + '/zlecenia/'
										 + gon.id
										 + '/animalgroups/'
										 + id
										 + '.json')
					 .then((result) => { this.animalgroup = result.body })
					 .catch((error) => { console.log(error)} )
				}
		  },
		  
	 },
	 computed: {
		  animals: {
				get() { return this.$store.state.animals },
				set(v) { this.$store.commit('animals', v) }
		  },
		  animal: {
				get() { return this.$store.state.animal },
				set(v) { this.$store.commit('animal', v) }
		  },
		  uzytek: { get() { return this.$store.state.uzytek },
						set(v) { this.$store.commit('uzytek', v) } },
		  animalgroups: { get() { return this.$store.state.animalgroups },
								set(v) { this.$store.commit('animalgroups', v) } },
		  ...mapGetters(['animalmodal']),
	 },
}
</script>
