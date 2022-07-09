import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider2_multi_provider/user.dart';


/*
* Multi Provider
 */
void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<User>(create: (context) => User(name: "Steve Lee", age: 52)),
          Provider<String>(create: (context) => "Stoney Creek",),
          Provider<String>(create: (context) => "Hamilton",), // 여기에 보다시피 String 의 타입으로 구분하기에 마지막에 있는게 출력된다.
        ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title; // 알지? widget.title 로 State<MyHomePage> 에서 사용하는걸..

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // [error] The instance member 'context' can't be accessed in an initializer.
    // [answer] 여기 State<MyHomePage 에는 context 가 존재하지 않는다. 그러니깐 없지. 방법은 context 가 있는 build 안에다가 넣어라.
    var name = Provider.of<User>(context).name.toString();
    final age = Provider.of<User>(context).age.toString();
    var address = Provider.of<String>(context).toString();
    // 값을 변경하는게 가능한가? 가능하지.. 그래서 전역변수처럼 사용할 수 있다. global variable
    Provider.of<User>(context).name = "Joseph Lee";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times: \n and Your name is  $name and age is $age '
                  'and address is $address',

            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
