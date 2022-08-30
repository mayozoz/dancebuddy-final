import 'package:flutter/material.dart';

class MyThirdPage extends StatefulWidget {
  const MyThirdPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyThirdPageState createState() => _MyThirdPageState();
}

class _MyThirdPageState extends State<MyThirdPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Screen 2',
            ),
            Text(
              'login',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.stadium_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}