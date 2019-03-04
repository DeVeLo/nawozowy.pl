<template>
<b-container class="text-left m-0 p-0">
  <b-row>
	 <b-col cols="6">
		<b-form-group
		  label="wybierz nawóz"
		  label-for="animalgroups">
		  <b-form-select
			 id="animalgroups"
			 :options="animalgroups"
			 v-model="animalgroup_id"></b-form-select>
		</b-form-group>
	 </b-col>
	 
	 <b-col cols="3">
		<b-form-group
		  label="sezon"
		  label-for="sezony">
		  <b-form-select
			 id="sezony"
			 :options="sezonoptions"
			 v-model="sezon_id"></b-form-select>
		</b-form-group>
	 </b-col>

	 <b-col cols="2">
		<b-form-group
		  label="ilość t/ha"
		  label-for="ilosc">
		  <b-form-input
			 id="ilosc"
			 v-model="ilosc"
			 :formatter="formatter_decimal"></b-form-input>
		</b-form-group>
	 </b-col>

	 <b-col cols="1">
		<b-button @click="save()" class="mt-3">[+]</b-button>
	 </b-col>

  </b-row>

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
				ilosc: "",
				sezon_id: false,
				animalgroup_id: false,
				gon: gon,
				naglowki: [
					 { key: 'grupa', label: 'grupa zwierząt' },
					 { key: 'sezon_name', label: 'sezon' },
					 { key: 'ilosc', label: 'ilość' },
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
						  this.uzytek.nawozynaturalne_attributes.push(result.body)
						  this.wyczyscNawoz()
						  this.pobierz()
					 })
					 .catch((error) => {
						  console.log(error)
					 })
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
						  this.uzytek.nawozynaturalne_attributes.splice(index,1)
						  this.pobierz()
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
