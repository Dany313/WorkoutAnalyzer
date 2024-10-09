import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_analyzer/pages/esercizio_dettaglio_page.dart';

import '../components/custom_list_widget.dart';

class EserciziPage extends StatefulWidget {
  final String selectedItem;
  const EserciziPage({super.key, required this.selectedItem});

  @override
  State<EserciziPage> createState() => _EserciziPageState();
}

class _EserciziPageState extends State<EserciziPage> {
  List<String> _esercizi = ["ESERCIZIO 1", "ESERCIZIO 2" , "ESERCIZIO 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedItem),
      ),
      body: CustomListWidget(items: _esercizi, onTap: (selectedItem) {
        // Naviga alla seconda pagina passando l'elemento selezionato
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EsercizioDettaglioPage(
              esercizio: selectedItem,
              scheda: widget.selectedItem,),
          ),
        );
      },),
      floatingActionButton : FloatingActionButton(
        onPressed: () {
          setState(() {
            _esercizi.add('ESERCIZIO ${_esercizi.length+1}');
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
