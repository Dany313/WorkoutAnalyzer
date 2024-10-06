import 'package:flutter/material.dart';

import '../fragments/esercizi_fragment.dart';
import '../fragments/schede_allenamento_fragment.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Widget> fragments = [
    SchedeAllenamentoFragment(),
    EserciziFragment(),

  ];

  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Workout Analyzer'),
      ),
      body: fragments[pageIndex] ,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
            print(pageIndex);
          });
        },
        items: const [
          BottomNavigationBarItem(label: "Schede allenamento",icon: Icon(Icons.supervised_user_circle)),
          BottomNavigationBarItem(label: "Esercizi",icon: Icon(Icons.image)),

        ],),
    );
  }
}