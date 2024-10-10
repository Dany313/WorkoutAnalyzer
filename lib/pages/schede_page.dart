import 'package:flutter/material.dart';
import 'package:workout_analyzer/components/custom_list.dart';
import 'esercizi_page.dart';


class SchedePage extends StatefulWidget {
  const SchedePage({super.key});

  @override
  State<SchedePage> createState() => _SchedePageState();
}

class _SchedePageState extends State<SchedePage> {
  List<String> _schedeAllenamnto = ["SCHEDA 1", "SCHEDA 2" , "SCHEDA 3"];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Schede Allenamento"),
      ),
      body: CustomList(items: _schedeAllenamnto, onTap: (selectedItem) {
        // Naviga alla seconda pagina passando l'elemento selezionato
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EserciziPage(selectedItem: selectedItem),
          ),
        );
      },),
      floatingActionButton : FloatingActionButton(
        onPressed: () {
          setState(() {
            _schedeAllenamnto.add('SCHEDA ${_schedeAllenamnto.length+1}');
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}