<template>
<b-card
  :header="rolnik.name + ' ' + rolnik.lname"
  :sub-title="rolnik.gname"

  footer-text-variant="secondary"
  class="mt-3">
</b-card>
</template>
<script>
import {mapGetters} from 'vuex'
  
export default {
	 name: 'crolnik',
	 computed: {
		  ...mapGetters(['rolnik'])
	 },
}
</script>
