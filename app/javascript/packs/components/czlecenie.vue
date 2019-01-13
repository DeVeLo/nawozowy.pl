<template>
<b-card
  header="Informacje ogólne o zleceniu"
  :title="zlecenie.name"
  :sub-title="zlecenie.sprawa"

  footer-text-variant="secondary"
  class="mt-3">
</b-card>
</template>
<script>
import {mapGetters} from 'vuex'

export default {
	 name: 'czlecenie',
	 computed: {
		  ...mapGetters(['zlecenie'])
	 },
}
</script>
