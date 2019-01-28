import 'package:flutter/material.dart';
import './registration.dart' as registration;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Http Request'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      bottomNavigationBar: new Material(
         color: Colors.blue,
         child: new TabBar(
           indicatorColor: Colors.white,
           controller: controller,
           tabs: <Widget>[
             new Tab(icon: new Icon(Icons.face,color: Colors.white)),
             new Tab(icon: new Icon(Icons.dashboard,color: Colors.white)),
           ],
         ),
      ),
       body: new TabBarView(
         controller: controller,
         children: <Widget>[
           new registration.Registration(),
           new registration.Registration()
         ]
       ),
     );
  }
}
