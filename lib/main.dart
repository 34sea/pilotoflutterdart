import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
            ElevatedButton(
              onPressed:
                  () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ApiConsumer()),
                    ),
                  },
              child: Text("Api"),
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
            CountState(title: "Counter"),
            ChangeColor(title: 'Color'),
          ],
        ),
      ),
    );
  }
}

//States

class CountState extends StatefulWidget {
  const CountState({super.key, required this.title});

  final String title;

  @override
  State<CountState> createState() => _MyCountState();
}

class _MyCountState extends State<CountState> {
  int _counter = 0;

  void incremente() {
    setState(() {
      _counter++;
      print('$_counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Counter'),
        Text('$_counter'),
        ElevatedButton(
          onPressed: () => {incremente()},
          child: Text('Incrementar'),
        ),
      ],
    );
  }
}

class ChangeColor extends StatefulWidget {
  ChangeColor({super.key, required this.title});

  final String title;

  @override
  State<ChangeColor> createState() => _ChangeStateColor();
}

class _ChangeStateColor extends State<ChangeColor> {
  var _colorItems = Colors.blue;
  bool _colorIsChange = false;
  void changeColor() {
    setState(() {
      if (!_colorIsChange) {
        _colorItems = Colors.red;
        _colorIsChange = !_colorIsChange;
      } else {
        _colorItems = Colors.amber;
        _colorIsChange = !_colorIsChange;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Color', style: TextStyle(color: _colorItems)),
        ElevatedButton(onPressed: () => {changeColor()}, child: Text('Change')),
      ],
    );
  }
}

//APi
class ApiConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Api')),
      body: Center(
        child: Column(
          children: [Text("Api"), ApiConsumerState(title: 'api'), PostsPage()],
        ),
      ),
    );
  }
}

class ApiConsumerState extends StatefulWidget {
  ApiConsumerState({super.key, required this.title});

  final String title;

  State<ApiConsumerState> createState() => _ApiConsumerStateShow();
}

class _ApiConsumerStateShow extends State<ApiConsumerState> {
  Future<void> readeData() async {
    print('object');
    try {
      var BASE_URL = Uri.parse("https://jsonplaceholder.typicode.com/posts");
      var response = await http.get(BASE_URL);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        for (final dados in data) {
          print(dados['id']);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  var _teste = 0;
  void incremente() {
    setState(() {
      _teste++;
      readeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        Text('$_teste'),

        ElevatedButton(onPressed: () => {incremente()}, child: Text('Click')),
      ],
    ));
  }
}

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao carregar os posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text('Api')]);
    // return Scaffold(
    //   appBar: AppBar(title: Text('Posts')),
    //   body: FutureBuilder<List<dynamic>>(
    //     future: fetchPosts(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(child: CircularProgressIndicator());
    //       } else if (snapshot.hasError) {
    //         return Center(child: Text('Erro: ${snapshot.error}'));
    //       } else if (snapshot.hasData) {
    //         final posts = snapshot.data!;
    //         return ListView.builder(
    //           itemCount: posts.length,
    //           itemBuilder: (context, index) {
    //             final post = posts[index];
    //             return ListTile(
    //               title: Text(post['title']),
    //               subtitle: Text(post['body']),
    //             );
    //           },
    //         );
    //       } else {
    //         return Center(child: Text('Nenhum dado encontrado'));
    //       }
    //     },
    //   ),
    // );
  }
}

class ListeWidget extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.amber[colorCodes[index]],
          child: Center(child: Text('Entry ${entries[index]}')),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
