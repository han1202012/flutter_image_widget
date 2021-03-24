import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        child: ListView(
          children: [


            Center(
              // 加载自定义图标
              child: Icon(IconData(0xe855, fontFamily: "MyFlutterApp",), size: 150,),
            ),

            Center(
              // 加载 Flutter 内置图标
              child: Icon(Icons.threed_rotation, size: 200,),
            ),


            Stack(
              children: [
                Center(
                  // 网络加载时显示本地的资源图片
                  child: FadeInImage.assetNetwork(
                    // Placeholder
                    placeholder: "images/waiting.gif",
                    image: "https://img-blog.csdnimg.cn/20210324110914742.png",
                  ),
                )
              ],
            ),


            Stack(
              children: [
                // 进度条
                Center(child: CircularProgressIndicator(),),
                Center(
                  // 网络加载时渐变出现
                  child: FadeInImage.memoryNetwork(
                    // Placeholder
                    placeholder: kTransparentImage,
                    image: "https://img-blog.csdnimg.cn/2021032321394771.png",
                  ),
                )
              ],
            ),


            Center(
              // 图片加载完成之前显示的是 placeholder , 加载完成后显示网络图片
              child: CachedNetworkImage(
                // 加载网络图片过程中显示的内容 , 这里显示进度条
                placeholder: (context, url)=>CircularProgressIndicator(),
                // 网络图片地址
                imageUrl: "https://img-blog.csdnimg.cn/20210324100419204.png",
              ),
            ),




            // 图片组件 , 从网络中加载一张图片
            Image.network(
              // 图片地址
              "https://img-blog.csdnimg.cn/2021032313493741.png",
            ),

            Image(
              image: AssetImage("images/sidalin.png"),
            ),

            //Image.asset('images/sidalin2.png', ),

            /// 从 SD 卡加载图片
            if(sdPath != null)
              Image.file(
                File('$sdPath/sidalin3.png'),
                width: 200,
              ),
          ],
        )

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
