class EsercizioDettaglio {
  int serie;
  int ripetizioni;
  int peso;

  // Costruttore
  EsercizioDettaglio({required this.serie, required this.ripetizioni, required this.peso});

  // Metodo per visualizzare i dettagli
  void stampaDettagli() {
    print("Serie: $serie, Ripetizioni: $ripetizioni, Peso: $peso kg");
  }
}