<template>
<div>

  <div class="mb-3">
	 Pobranie składnika na wytworzenie
	 {{ uzytek.plon }} t
	 {{ uzytek.nazwarosliny }} ::
	 <strong>{{ uzytek.plon }} * {{ uzytek.pobranie_n }} = {{ uzytek.pelne_pobranie_n }}</strong>.
  </div>

  <div v-if="uzytek.roslinaprzedplon_id > 2 && uzytek.stanprzedplonu == false && uzytek.wspolczynnikrosliny == 0.9" class="mb-3">
	 Azot na rozłożenie zaoranej słomy <strong>21</strong>.
  </div>
  
  <span class="text-danger">
	 1.
  </span>
  Użytek - (gleba {{ this.uzytek.kategoria }}) ilość azotu uzyskana
  <template v-if="uzytek.badania">
	 na podstawie badania gleby
	 <i v-if="uzytek.nminsezon == false">
		wiosną
	 </i>
	 <i v-else>
		jesienią ({{ uzytek.nmin }}&nbsp;kg&nbsp;N/ha&nbsp;*&nbsp;{{ uzytek.przelicznik }})
	 </i>
  </template>
  <template v-else>
	 na podstawie tabeli 12
	 <i v-if="uzytek.nminsezon == false">
		wiosną
	 </i>
	 <i v-else>
		jesienią ({{ uzytek.zasob }}&nbsp;kg&nbsp;N/ha&nbsp;*&nbsp;{{ uzytek.przelicznik }})
	 </i>
  </template>
  <br />

  <strong>{{ uzytek.gleba }}&nbsp;kg&nbsp;N/ha</strong>

  <br />
  <br />
  <span class="text-danger">
	 2.
  </span>
  Uprawa - {{ uzytek.nazwarosliny }} ({{ uzytek.gleba }} kg N/h * {{ uzytek.wspolczynnikrosliny }})
  
  <br />
  <strong>{{ uzytek.jaraozima }}&nbsp;kg&nbsp;N/ha</strong>

  <br />
  <br />
  <span class="text-danger">
	 3.
  </span>
  Obornik pod przedplon - Zastosowano obornik pod przedplon w ilości: {{ uzytek.przedplon }} kg N/ha,
  <br />
  po przemnożeniu przez 0.15 pozostaje <i>{{ uzytek.realnyprzedplon }} kg N/ha</i>
  <br />

  <span class="text-danger">Suma (2+3)</span> <strong>{{ uzytek.zprzedplonem }} kg N/ha</strong>

  
  <template v-if="uzytek.roslinaprzedplon_id == 2">
	 <br />
	 <br />
	 <span class="text-danger">
		4.
	 </span>
	 Przedplon - {{ uzytek.nazwaroslinaprzedplon }} {{ roslinaprzedplony.find(x => x.id === uzytek.roslinaprzedplon_id).n }} kg N/ha + {{ uzytek.zprzedplonem }} kg N/ha
	 <br>
	 <span class="text-danger">Suma (2+3+4)</span> <strong>{{ uzytek.zroslinaprzedplon }} kg N/ha</strong>
  </template>
  <template v-else-if v-if="uzytek.roslinaprzedplon_id > 2">
	 <br />
	 <br />
	 <span class="text-danger">
		4.
	 </span>
	 Przedplon - {{ uzytek.nazwaroslinaprzedplon }} 0 kg N/ha + {{ uzytek.zprzedplonem }} kg N/ha
	 <br>
	 <span class="text-danger">Suma (2+3+4)</span> <strong>{{ uzytek.zroslinaprzedplon }} kg N/ha</strong>
  </template>
  <template v-else-if  v-if="uzytek.roslinaprzedplon_id < 2">
	 <br />
	 <br />
	 <span class="text-danger">
		4.
	 </span>
	 Przedplon - brak 0 kg N/ha
	 <br />
	 <span class="text-danger">Suma (2+3+4)</span> <strong>{{ uzytek.zroslinaprzedplon }} kg N/ha</strong>
  </template>
  

  <template v-if='uzytek.bobowata_id>1'>
	 <br>
	 <br>
	 <span class="text-danger">
		5.
	 </span>
	 Bobowate - {{ uzytek.nazwabobowata }} {{ bobowate.find(x => x.id === uzytek.bobowata_id).n }} kg N/ha + {{ uzytek.zroslinaprzedplon }} kg N/ha
	 <br />
	 <span class="text-danger">zapasy azotu ze wszystkich źródeł -Suma (2+3+4+5)</span> <strong>{{ uzytek.zbobowata }} kg N/ha</strong>
  </template>
  <template v-else>
	 <br>
	 <br>
	 <span class="text-danger">
		5.
	 </span>
	 Bobowate - brak 0 kg N/ha
	 <br />
	 <span class="text-danger">zapasy azotu ze wszystkich źródeł - Suma (2+3+4+5)</span> <strong>{{ uzytek.zbobowata }} kg N/ha</strong>
  </template>

	 
  <template v-if="uzytek.nawoznaturalny != ''">
	 <br>
	 <br>
	 Ilość azotu z zastosowanego nawozu naturalnego - {{ Math.round(100*uzytek.nawoznaturalnyzastosowany)/100 }} kg N/ha <br />
	 ilość azotu <b>działającego</b> z zastosowanego nawozu naturalnego - {{ Math.round(100*uzytek.nawoznaturalny)/100 }}kg N/ha<br />
	 <br />
	 
	 <strong><u>Ilość azotu działającego z nawozu naturalnego + z pozostałych źródeł {{ Math.round(100*uzytek.zanimalsami)/100 }} kg N/ha</u></strong>
  </template>

  <br>
  <br>
  <center><b>PODSUMOWANIE</b></center><br>
  dawka azotu działającego w N kg/1 ha {{ Math.round(100*uzytek.zapotrzebowanie_ha)/100 }} - {{ Math.round(100*uzytek.azot_naturalny_ha)/100 }} kg/1 ha = {{ Math.round(100*uzytek.azot_mineralny_ha)/100 }} kg/1 ha<br>
  Bilans azotu <span :style="'color: ' + kolor_salda + ';'">{{ Math.round(uzytek.saldo_n) }}</span><br>
  dawka nawozu mineralnego do zastosowania {{ Math.round(100*uzytek.azot_mineralny_ha)/100 }} / 0.7 = <u>{{ Math.round(100*uzytek.azot_mineralny_ha_w_nawozie)/100 }} dawka z nawozu</u>
  </div>
</template>
<script>
export default {
	 name: 'uprawazrodla',
	 data() {
		  return {
				roslinaprzedplony: [],
				bobowate: [],
		  }
	 },
	 methods: {
		  pobierzBobowate() {
				this.$http.get('/bobowate.json')
					 .then((result) => { this.bobowate = result.body })
					 .catch((error) => { console.log(error) })
		  },
		  pobierzRoslinaprzedplony() {
				this.$http.get('/roslinaprzedplony.json')
					 .then((result) => { this.roslinaprzedplony = result.body })
					 .catch((error) => { console.log(error) })
		  },
	 },
	 computed: {
		  kolor_salda: {
				get() {
					 if (this.uzytek.saldo_n > 30) {
						  return 'red'
					 } else {
						  return ''
					 }
				}
		  },
		  uprawazrodla: { get() { return this.$store.state.uprawazrodla },
								set(v) { this.$store.commit('uprawazrodla', v) } },
		  uzytek: { get() { return this.$store.state.uzytek },
						set(v) { this.$store.commit('uzytek', v) } },
	 },
	 created() {
		  this.pobierzBobowate()
		  this.pobierzRoslinaprzedplony()
	 },
	 mounted() {
		  this.uprawazrodla = this.$refs.uprawazrodla
	 }
}
</script>
