import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fullWidth = MediaQuery.of(context).size.width;
    final fullHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Home page")),
      body: Center(
        child: Column(
          children: [
            Text(
              'Hello world',
              style: TextStyle(
                fontSize: 24,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            Container(
              width: fullWidth,
              padding: EdgeInsets.all(8),
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Container', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => {print("Button Pressed")},
              child: Text('Click'),
            ),
            Menu(),
          ],
        ),
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('Container')));
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Row(
          children: [
            ElevatedButton(
              onPressed:
                  () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SegundaTela(),
                      ),
                    ),
                  },
              child: Text("Tela 2"),
            ),
            ElevatedButton(
              onPressed:
                  () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TerceiraTela()),
                    ),
                  },
              child: Text("Tela 3"),
            ),
          ],
        ),
      ),
    );
  }
}

class SegundaTela extends StatelessWidget {
  const SegundaTela({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Segunda Tela')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Voltar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class TerceiraTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terceira tela")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => {Navigator.pop(context)},
              child: Text("Voltar"),
            ),
          ],
        ),
      ),
    );
  }
}
