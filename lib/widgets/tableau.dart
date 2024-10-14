// lib/custom_widget.dart
import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'coup.dart';

class Tableau extends StatefulWidget {
  final String title;
  Tableau({Key? key, required this.title}) : super(key: key);

  @override
  _TableauState createState() => _TableauState();
}

class _TableauState extends State<Tableau> {
  final List<int> data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];


  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: Container(
  //       width: 400, // Espacement interne autour du tableau
  //       child: GridView.builder(
  //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 4, // 4 colonnes
  //           childAspectRatio: 1, // Chaque cellule est carrée
  //         ),
  //         itemCount: 16, // 4x4 = 16 cellules
  //         itemBuilder: (context, index) {
  //           return GestureDetector(
  //             onTap: () {
  //               print('Tapped on tile $index');
  //             }, // Gérer le tap sur la case ici
  //             child: Container(
  //               margin: EdgeInsets.all(1), // Espacement entre les cellules
  //               height: 50.0,
  //               color: Colors.grey,
  //               alignment: Alignment.center,
  //               child: Text(
  //                 '$index',
  //                 style: TextStyle(color: Colors.black, fontSize: 16),
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  // void IncrementCoup(int nbCoup){
  //   nbCoup++;
  // }

  Widget buildItem(int value) {
    return Card(
      key: ValueKey(value),
      elevation: 4,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped on item: $value')),
          );
        },
        child: Center(
          child: Text(
            '$value',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        child: ReorderableGridView.count(
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          crossAxisCount: 4,
          childAspectRatio: 1,
          children: data.map((value) => buildItem(value)).toList(),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) newIndex--;
              final element = data.removeAt(oldIndex);
              data.insert(newIndex, element);
            });
          },
          footer: [
            Card(
              child: Center(
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}