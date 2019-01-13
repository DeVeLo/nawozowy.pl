<template>
<b-card
  :header="instytucja.name"

  footer-text-variant="secondary"
  class="mt-3">
  <address>
	 {{ instytucja.miejscowosc }}<span v-if="instytucja.ulica">, {{ instytucja.ulica }}</span>
	 {{ instytucja.nrp }}<span v-if="instytucja.nrm">/{{ instytucja.nrm }}</span><br />
	 <span v-if="instytucja.kod">{{ instytucja.kod }}</span>
	 <span v-if="instytucja.poczta">{{ instytucja.poczta }}</span>
  </address>
  
  <dl class="row">
	 
	 <dt class="col-sm-4 text-right">NIP</dt>
	 <dd class="col-sm-8 text-left">{{ instytucja.nip }}</dd>
	 
	 <dt class="col-sm-4 text-right">REGON</dt>
	 <dd class="col-sm-8 text-left">{{ instytucja.regon }}</dd>
  </dl>
  
</b-card>
</template>

<script>
import {mapGetters} from 'vuex'
  
export default {
	 name: 'cinstytucja',
	 computed: {
		  ...mapGetters(['instytucja'])
	 },
}
</script>
