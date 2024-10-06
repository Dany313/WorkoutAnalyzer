class SchedeAllenamento {
  List<String> _schedeAllenamnto = ["SCHEDA 1", "SCHEDA 2" , "SCHEDA 3"];

  // Costruttore opzionale per inizializzare la lista
  SchedeAllenamento([List<String>? allenamenti]) {
    if (allenamenti != null) {
      _schedeAllenamnto = allenamenti;
    }
  }

  // Getter per la lista di allenamenti
  List<String> get allenamenti => _schedeAllenamnto;

  // Setter per la lista di allenamenti
  set allenamenti(List<String> nuoviAllenamenti) {
    _schedeAllenamnto = nuoviAllenamenti;
  }

  // Metodo per aggiungere un singolo allenamento
  void aggiungiAllenamento(String allenamento) {
    _schedeAllenamnto.add(allenamento);
  }

  // Metodo per rimuovere un allenamento
  void rimuoviAllenamento(String allenamento) {
    _schedeAllenamnto.remove(allenamento);
  }

  // Metodo per ottenere un allenamento specifico per indice
  String getAllenamento(int index) {
    if (index >= 0 && index < _schedeAllenamnto.length) {
      return _schedeAllenamnto[index];
    } else {
      throw IndexError(index, _schedeAllenamnto);
    }
  }

  // Metodo per aggiornare un allenamento specifico per indice
  void aggiornaAllenamento(int index, String nuovoAllenamento) {
    if (index >= 0 && index < _schedeAllenamnto.length) {
      _schedeAllenamnto[index] = nuovoAllenamento;
    } else {
      throw IndexError(index, _schedeAllenamnto);
    }
  }
}