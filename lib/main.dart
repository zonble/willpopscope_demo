import 'package:flutter/material.dart';

import 'demo1.dart';
import 'demo2.dart';
import 'demo3.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WillPopScope Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'WillPopScope 範例'),
      routes: {
        'demo1': (context) => Demo1(),
        'demo2': (context) => Demo2(),
        'demo3': (context) => Demo3(),
      },
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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('你確定要退出嗎？'),
                actions: <Widget>[
                  RaisedButton(
                    child: Text('退出'),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                  RaisedButton(
                    child: Text('取消'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              )),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SafeArea(
            child: Scrollbar(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 10, bottom: 10),
                child: Text(
                    'WillPopScope 這個 Widget 的用途，是用來決定 Android 上的實體退後按鍵的行為。在這個範例當中，會簡單示範如何使用這個 Widget。\n\n' +
                        '通常 iOS 工程師在寫 Flutter app 的時候，往往會開啟 iOS 模擬器開發，所以很容易會忘記要處理實體後退按鍵，所以，在開發的時候，記得還是要開啟一個 Android 模擬器或 Android 設備測試，免得忘記這些平台專屬的問題。'),
              ),
              Divider(),
              ListTile(
                  leading: TileLeading(text: '1'),
                  title: Text('詢問用戶是否要退出目前的畫面')),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 10, bottom: 10),
                child: Text(
                    '您在目前所在頁面，按下實體後退按鍵，就會跳出一個提示對話框。請試試看。\n\n您也可以試試看下面這個單獨的範例。'),
              ),
              ListTile(
                onTap: () => Navigator.of(context).pushNamed('demo1'),
                title: Text('前往「後退時跳出提示」範例', textAlign: TextAlign.end),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () => Navigator.of(context).pushNamed('demo2'),
                title: Text('前往「使用 Snack Bar」的範例', textAlign: TextAlign.end),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
              ListTile(
                  leading: TileLeading(text: '2'),
                  title: Text('控制自訂的 Navigator')),
              ListTile(
                onTap: () => Navigator.of(context).pushNamed('demo3'),
                title: Text('前往「控制自訂的 Navigator」範例', textAlign: TextAlign.end),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
              ListTile(
                  leading: TileLeading(text: '3'),
                  title: Text('CupertinoTabScaffold')),
              ListTile(
                onTap: () {},
                title: Text('前往範例', textAlign: TextAlign.end),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class TileLeading extends StatelessWidget {
  const TileLeading({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(width: 30, height: 30, child: Center(child: Text(text)));
  }
}
