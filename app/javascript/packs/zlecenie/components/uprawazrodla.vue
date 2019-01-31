<template>
<b-modal
  :title="'źródła azotu - użytek ' + uzytek.name"
  centered
  id="uprawazrodla"
  ref="uprawazrodla"
  size="lg"
  header-bg-variant="dark"
  header-text-variant="light"
  hide-footer
  class="text-center">

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
  </template>
  <br />

  <strong>{{ uzytek.gleba }}&nbsp;kg&nbsp;N/ha</strong>

  <br />
  <br />
  wybrano roślinę: {{ uzytek.nazwarosliny }} ({{ uzytek.gleba }} kg N/h * {{ uzytek.wspolczynnikrosliny }})

  <br />
  <strong>{{ uzytek.jaraozima }}&nbsp;kg&nbsp;N/ha</strong>

  <template v-if="uzytek.przedplon > 0">
	 <br />
	 <br />
	 Zastosowano obornik pod przedplon w ilości: {{ uzytek.przedplon }} kg N/ha,
	 <br />
	 po przemnożeniu przez 0.15 pozostaje <i>{{ uzytek.realnyprzedplon }} kg N/ha</i>
	 <br />

	 <strong>{{ uzytek.zprzedplonem }} kg N/ha</strong>
  </template>

  <template v-if="uzytek.roslinaprzedplon_id > 1">
	 <br />
	 <br />
	 {{ uzytek.nazwaroslinaprzedplon }} {{ roslinaprzedplony.find(x => x.id === uzytek.roslinaprzedplon_id).n }} kg N/ha + {{ uzytek.zprzedplonem }} kg N/ha
	 <br>
	 <strong>{{ uzytek.zroslinaprzedplon }} kg N/ha</strong>
  </template>

  <template v-if='uzytek.bobowata_id>1'>
	 <br>
	 <br>
	 {{ uzytek.nazwabobowata }} {{ bobowate.find(x => x.id === uzytek.bobowata_id).n }} kg N/ha + {{ uzytek.zroslinaprzedplon }} kg N/ha
	 <br />
	 <strong>{{ uzytek.zbobowata }} kg N/ha</strong>
  </template>
  
  
</b-modal>
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
