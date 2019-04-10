<template>
<div>

  <b-navbar toggleable="md" type="dark" variant="dark" sticky>
	 <b-navbar-brand href="https://nawozowy.pl/">nawozowy.pl</b-navbar-brand>
	 <b-navbar-toggle target="nav_collapse" />
	 
	 <b-collapse is-nav id="nav_collapse">
		<b-navbar-nav class="ml-auto">
		  
		  <b-nav-item :href="'/instytucje/' + gon.instytucja_id + '/rolnicy'">{{ instytucja.name }}</b-nav-item>
		  <b-nav-item :href="'/instytucje/' + gon.instytucja_id + '/rolnicy/' + gon.rolnik_id + '/zlecenia'">{{ rolnik.name }} {{ rolnik.lname }}</b-nav-item>
		  <b-nav-item @click="create">Nowe Zlecenie</b-nav-item>
		  <b-nav-item @click="logout">Wyloguj</b-nav-item>
		  
		</b-navbar-nav>
	 </b-collapse>
  </b-navbar>

  <b-container fluid>
	 <b-form-row>
		<b-col>
 		  <b-row class="mt-3">
			 <b-col>
				<h2>lista zleceń</h2>
			 </b-col>
		  </b-row>
		  
		  <b-row>
			 <cform></cform>
		  </b-row>
		  
		  <b-row>
			 <ctable></ctable>
		  </b-row>
		  
		</b-col>
	 </b-form-row>
	 
  </b-container>
</div>
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
		  ...mapGetters([ 'modalForm', 'instytucja', 'rolnik' ]),
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
		  set_name() {
				let y = (new Date).getFullYear()
				let y2 = y
				if ((new Date).getMonth()<6) { y = y - 1 } else { y2 = y2 + 1 }
				return y + '/' + y2
		  },
		  create() {
				this.attr = {
					 // domyślnie zlecenie w wariancie wykonanie
					 name: this.set_name(),
					 typ: false,
					 wariant_id: 1,
					 instytucja_id: gon.instytucja_id,
					 rolnik_id: gon.rolnik_id,
					 wojewodztwo_id: gon.wojewodztwo_id,
					 powiat_id: gon.powiat_id,
					 gmina_id: gon.gmina_id,
					 miejscowosc: gon.miejscowosc,
					 datawplywu: new Date,
					 datawydruku: new Date,
					 bilansn: false,
					 zmiendatewydruku: false,
				}
				this.modalForm.show()
		  },
		  logout() {
				this.$http.delete('/users/sign_out')
					 .then((r) => {
						  window.history.go()
					 })
					 .catch((e) => {
						  console.log(e)
					 })
		  }
	 },
	 created() {
		  this.pobierz_instytucje()
		  this.pobierz_rolnika()
	 },
}
</script>
