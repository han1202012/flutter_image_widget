import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  /// SD 卡路径
  String sdPath;

  @override
  void initState() {
    // 获取 SD 卡路径
    getSdPath();
  }

  void getSdPath() async {
    String path = (await getExternalStorageDirectory()).path;
    setState(() {
      sdPath = path;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    print("sdPath : $sdPath");
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              'приветствовать товарища Сталина:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),

            // 图片组件 , 从网络中加载一张图片
            Image.network(
              // 图片地址
              "https://img-blog.csdnimg.cn/2021032313493741.png",
              width: 200,
            ),

            Image(
              width: 200,
              image: AssetImage("images/sidalin.png"),
            ),

            Image.asset(
              'images/sidalin2.png',
              width: 200,),

            /// 从 SD 卡加载图片
            if(sdPath != null)
              Image.file(
                File('$sdPath/sidalin3.png'),
                width: 200,
              ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
