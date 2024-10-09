<template>
  <v-dialog v-model="dialog" width="800">
    <template #activator="{ on, attrs }">
      <v-btn
        v-bind="attrs"
        outlined
        color="primary"
        class="mr-2"
        :loading="loadingDownload"
        v-on="on"
        @click="download"
      >
        Exporter les procédures
      </v-btn>
    </template>

    <v-card max-height="450" class="overflow-auto pb-6">
      <div class="text-right pr-2 pt-2">
        <v-btn color="primary" text @click="dialog = false">
          Fermer x
        </v-btn>
      </div>
      <v-card-title class="text-h5 align-start pl-8 font-weight-bold">
        <div>Téléchargement en cours...</div>
      </v-card-title>

      <v-card-text class="pt-0 px-5">
        <v-container>
          <v-row>
            <v-col cols="12" class="pt-0">
              Pendant votre téléchargement, consultez le dictionnaire des champs CSV pour vous familiariser avec le format du CSV de Docurba.
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12">
              <v-btn depressed color="primary" target="_blank" href="https://docurba.crisp.help/fr/article/dictionnaire-des-champs-export-csv-des-procedures-principales-de-plui-1jrrodk/">
                Voir le dictionnaire des champs CSV
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>
<script>
import axios from 'axios'
export default
{
  name: 'ExportCsvDialog',
  props: {

  },
  data () {
    return {
      loadingDownload: false
    }
  },
  methods: {
    async download () {
      const departementCode = this.$route.params.departement

      this.loadingDownload = true
      const { data } = await axios(`/api/urba/exports/departements/${departementCode}?csv=true`)

      const a = document.createElement('a')
      const blob = new Blob([data], { type: 'text/csv' })
      a.href = window.URL.createObjectURL(blob)
      a.download = `docurba_procedures_${departementCode}.csv`
      a.click()

      this.loadingDownload = false
    }
  }
}
</script>
