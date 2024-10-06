class Esercizi {
  List<String> _esercizi = ["ESERCIZIO 1", "ESERCIZIO 2" , "ESERCIZIO 3"];

  // Costruttore opzionale per inizializzare la lista
  Esercizi([List<String>? allenamenti]) {
    if (allenamenti != null) {
      _esercizi = allenamenti;
    }
  }

  // Getter per la lista di esercizi
  List<String> get esercizi => _esercizi;

  // Setter per la lista di esercizi
  set esercizi(List<String> nuoviAllenamenti) {
    _esercizi = nuoviAllenamenti;
  }

  // Metodo per aggiungere un singolo esercizio
  void aggiungiEsercizio(String allenamento) {
    _esercizi.add(allenamento);
  }

  // Metodo per rimuovere un esercizio
  void rimuoviEsercizio(String allenamento) {
    _esercizi.remove(allenamento);
  }

  // Metodo per ottenere un esercizio specifico per indice
  String getEsercizio(int index) {
    if (index >= 0 && index < _esercizi.length) {
      return _esercizi[index];
    } else {
      throw IndexError(index, _esercizi);
    }
  }

  // Metodo per aggiornare un esercizio specifico per indice
  void aggiornaEsercizio(int index, String nuovoAllenamento) {
    if (index >= 0 && index < _esercizi.length) {
      _esercizi[index] = nuovoAllenamento;
    } else {
      throw IndexError(index, _esercizi);
    }
  }
}