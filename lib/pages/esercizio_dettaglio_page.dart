import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.scheda.toLowerCase()} > ${widget.esercizio}"),
      ),
      body: ListView.builder(
    itemCount: list.keys.length, // Numero di elementi nella lista
    itemBuilder: (context, index) {

      return Text(list[index+1].toString());

    }

      ),
    );
  }
}
