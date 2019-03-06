<template>
<div>
  <b-card
	 bg-variant="light"
	 class="m-0 mt-2">
	 
	 <b-form-row
		class="m-0 mb-2">
		
		<b-col>
		  
		  <b-form-group
			 label="Zastosowany nawóz naturalny"
			 label-class="font-weight-bold">
			 
			 <b-form-row>
				
				<b-col>
				  
				  <b-table
					 class="m-0 p-0 small"
					 thead-class="thead-dark"
					 size="sm"
					 striped
					 hover
					 outlined
					 show-empty
					 small
					 :empty-text="'Nie ma jeszcze dodanego nawozu naturalnego do użytku.'"
					 :fields="naglowki"
					 :items="uzytek.nawozynaturalne_attributes">
					 <template slot="ilosc" slot-scope="row">
						{{ Math.round(10*row.item.ilosc)/10 }}&nbsp;t/ha<br>
						N&nbsp;{{ Math.round(10*row.item.wykorzystany_azot)/10 }}&nbsp;kg/ha<br>
						Nd&nbsp;{{ Math.round(10*row.item.wykorzystany_azot_dzialajacy)/10 }}&nbsp;kg/ha<br>
						P<sub>2</sub>O<sub>5</sub>&nbsp;{{ Math.round(10*row.item.wykorzystany_fosfor)/10 }}&nbsp;kg/ha<br>
						K<sub>2</sub>O&nbsp;{{ Math.round(10*row.item.wykorzystany_potas)/10 }}&nbsp;kg/ha<br>
					 </template>
					 
					 <template slot="ilosc_na_pole" slot-scope="row">
						{{ Math.round(10*row.item.ilosc_na_pole)/10 }}&nbsp;t<br>
						N&nbsp;{{ Math.round(10*row.item.wykorzystany_azot_pole)/10 }}&nbsp;kg/pole<br>
						Nd&nbsp;{{ Math.round(10*row.item.wykorzystany_azot_dzialajacy_pole)/10 }}&nbsp;kg/pole<br>
						P<sub>2</sub>O<sub>5</sub>&nbsp;{{ Math.round(10*row.item.wykorzystany_fosfor_pole)/10 }}&nbsp;kg/pole<br>
						K<sub>2</sub>O&nbsp;{{ Math.round(10*row.item.wykorzystany_potas_pole)/10 }}&nbsp;kg/pole<br>
					 </template>
					 
					 <template slot="przyciski" slot-scope="row">
						<b-button
						  variant="danger"
						  size="sm"
						  @click="destroy(row.item.id, row.index)">
						  usuń
						</b-button>
					 </template>
					 
				  </b-table>
				  
				</b-col>
				
			 </b-form-row>
			 
		  </b-form-group>
		  
		</b-col>
		
	 </b-form-row>
	 
  </b-card>
  
  <b-card
	 bg-variant="light"
	 class="mt-2">
	 
	 <b-form-row>
		
		<b-col>
		  
		  <b-form-group
			 label="Rozdysponuj nawóz naturalny"
			 label-class="font-weight-bold">
			 
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
						@input="pobierzAnimalgroup(animalgroup_id); $root.$emit('bv::toggle::collapse', ('a' + animalgroup_id).substr(0,7))"
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
			 
			 <b-form-row>
				<b-col role="tablist">
				  <b-card no-body v-for="group in animalgroups" :key="group.id">
					 <b-card-header
						header-tag="header"
						role="tab"
						class="m-0 p-0">
						<b-button
						  block
						  @click="animalgroup_id = group.id"
						  variant="info"
						  size="sm">
						  {{ group.animalsname }}
						</b-button>
					 </b-card-header>
					 
					 <b-collapse
						:id="'a' + group.id.substr(0,6)"
						accordion="animalgroups-accordion"
						role="tabpanel">
						<b-card-body class="m-0 p-0">
						  <b-form-row class="mt-2 mb-0">
							 <b-col class="text-center">
								<dl>
								  <dt>prod./dost. t(m<sup>3</sup>)</dt>
								  <dd>{{ Math.round(100*group.produkt)/100 }} / {{ Math.round(100*group.pozostalynawoz)/100 }}</dd>
								</dl>
							 </b-col>
							 
							 <b-col class="text-center">
								<dl>
								  <dt>N kg</dt>
								  <dd>{{ Math.round(100*group.produkcja_azot)/100 }} /	{{ Math.round(100*group.pozostaly_azot)/100 }}</dd>
								</dl>
							 </b-col>
							 
							 <b-col class="text-center">
								<dl>
								  <dt>P<sub>2</sub>O<sub>5</sub> kg</dt>
								  <dd>{{ Math.round(100*group.produkcja_fosfor)/100 }} / {{ Math.round(100*group.pozostaly_fosfor)/100 }}</dd>
								</dl>
							 </b-col>
							 
							 <b-col class="text-center">
								<dl>
								  <dt>K<sub>2</sub>O kg</dt>
								  <dd>{{ Math.round(100*group.produkcja_potas)/100 }} / {{ Math.round(100*group.pozostaly_potas)/100 }}</dd>
								</dl>
							 </b-col>
						  </b-form-row>

						  <b-form-row>
							 <b-col class="ml-3 mb-1">
								Maksymalna dawka do zastosowania {{ Math.round(100*group.maksymalna_dawka)/100 }} t/ha
							 </b-col>
						  </b-form-row>
						  
						</b-card-body>
					 </b-collapse>
					 
				  </b-card>
				  
				</b-col>
				
			 </b-form-row>			 
			 
		  </b-form-group>
		  
		</b-col>
		
	 </b-form-row>
	 
  </b-card>		 
  
  <b-card
	 bg-variant="light"
	 class="mt-2 mb-0">
	 
	 <b-form-group
		label="Podusmowanie produkcji"
		label-class="font-weight-bold"
		description="Podsumowanie produkcji oraz wykorzystania nawozów naturalnych w gospodarstwie">
		
		<b-form-row>
		  
		  <b-col class="text-center">
			 <dl>
				<dt>prod./dost. t(m<sup>3</sup>)/rok</dt>
				<dd>{{ zlecenie.produkcja_nawozu }} / {{ zlecenie.pozostaly_nawoz }}</dd>
			 </dl>
		  </b-col>
		  
		  <b-col class="text-center">
			 <dl>
				<dt>N kg/rok</dt>
				<dd>{{ zlecenie.produkcja_azotu }} / {{ zlecenie.pozostaly_azot }}</dd>
			 </dl>
		  </b-col>
		  
		  <b-col class="text-center">
			 <dl>
				<dt>P<sub>2</sub>O<sub>5</sub> kg/rok</dt>
				<dd>{{ zlecenie.produkcja_fosforu }} / {{ zlecenie.pozostaly_fosfor }}</dd>
			 </dl>
		  </b-col>
				
		  <b-col class="text-center">
			 <dl>
				<dt>K<sub>2</sub>O kg/rok</dt>
				<dd>{{ zlecenie.produkcja_potasu }} / {{ zlecenie.pozostaly_potas }}</dd>
			 </dl>
		  </b-col>
		  
		</b-form-row>

	 </b-form-group>
		
  </b-card>

</div>
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
					 { key: 'ilosc_na_pole', label: 'il./pole' },
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
				// this.animalgroup_id = false
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
		  ...mapGetters(['zlecenie']),
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
