import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /*RefreshIndicator(
              key: _refreshIndicatorKey,
              color: Colors.white,
              backgroundColor: Colors.blue,
              strokeWidth: 4.0,
              onRefresh: () async {
                // Replace this delay with the code to be executed during refresh
                // and return a Future when code finishes execution.
                return Future<void>.delayed(const Duration(seconds: 3));
              },
              // Pull from top to show refresh indicator.
              child: ListView.builder(
                itemCount: 25,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
              ),
            ),*/
            FloatingActionButton(
              onPressed: () {
                // Action à exécuter lors de l'appui
              },
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              shape: const CircleBorder(),
            ),
          ],
        ),
      ),
    );
  }
}
