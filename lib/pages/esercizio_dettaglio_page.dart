import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/allenamento_tile.dart';
import '../entity/esercizio_dettaglio.dart';

class EsercizioDettaglioPage extends StatefulWidget {
  final String esercizio;
  final String scheda;

  const EsercizioDettaglioPage(
      {super.key, required this.esercizio, required this.scheda});

  @override
  State<EsercizioDettaglioPage> createState() => _EsercizioDettaglioPageState();
}

class _EsercizioDettaglioPageState extends State<EsercizioDettaglioPage> {
  Map<int, List<EsercizioDettaglio>> list = {
    1: [
      EsercizioDettaglio(serie: 1, ripetizioni: 6, peso: 30),
      EsercizioDettaglio(serie: 2, ripetizioni: 6, peso: 30),
      EsercizioDettaglio(serie: 3, ripetizioni: 6, peso: 30),
    ],
    2: [
      EsercizioDettaglio(serie: 1, ripetizioni: 8, peso: 30),
      EsercizioDettaglio(serie: 2, ripetizioni: 6, peso: 40),
      EsercizioDettaglio(serie: 3, ripetizioni: 4, peso: 50),
    ],
  };

  // Controlla quali pannelli sono espansi
  List<bool> _expandedPanels = [];

  @override
  void initState() {
    super.initState();
    // Inizializza la lista di pannelli espansi con tutti chiusi
    _expandedPanels = List.generate(list.length, (_) => true);
    print(_expandedPanels);
  }

  // Funzione per aggiungere un nuovo allenamento
  void _aggiungiAllenamento(int chiave) {
    setState(() {
      list[chiave]?.add(
        EsercizioDettaglio(
            serie: list[chiave]!.length + 1, ripetizioni: 10, peso: 20),
      );
    });
  }

  // Funzione per aggiornare le ripetizioni
  void _aggiornaRipetizioni(int chiave, int index, int nuoveRipetizioni) {
    setState(() {
      list[chiave]?.elementAt(index).ripetizioni = nuoveRipetizioni;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esercizi'),
      ),
      body: ListView(
        children: [
          ExpansionPanelList(
            expansionCallback: (int panelIndex, bool isExpanded) {
              setState(() {
                print(panelIndex);
                print(isExpanded);
                _expandedPanels[panelIndex] = isExpanded;
                print(_expandedPanels);
              });
            },
            children: list.entries.map<ExpansionPanel>((entry) {
              print(entry);
              int index = list.keys.toList().indexOf(entry.key); // Ottieni l'indice corretto
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text('Allenamento ${entry.key}'),
                  );
                },
                body: Column(
                  children: [
                    ...entry.value.asMap().entries.map((entryMap) {
                      int esercizioIndex = entryMap.key;
                      EsercizioDettaglio dettaglio = entryMap.value;
                      return AllenamentoTile(esercizio: dettaglio,
                        onUpdateReps: (int nuoveRipetizioni) {
                          _aggiornaRipetizioni(entry.key, esercizioIndex, nuoveRipetizioni);
                        },
                        );
                    }),
                    IconButton(
                      onPressed: () {
                        _aggiungiAllenamento(entry.key);
                        //_updateExpandedPanels(); // Assicurati di aggiornare la lista dei pannelli espansi
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                isExpanded: _expandedPanels[index],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
