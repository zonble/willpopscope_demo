import 'package:flutter/material.dart';

import 'demo1.dart';
import 'demo2.dart';
import 'demo3.dart';
import 'demo4.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'WillPopScope Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage(title: 'WillPopScope 範例'),
        routes: {
          'demo1': (_) => Demo1(),
          'demo2': (_) => Demo2(),
          'demo3': (_) => Demo3(),
          'demo4': (_) => Demo4(),
        },
      );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('你確定要退出嗎？'),
                actions: <Widget>[
                  ElevatedButton(
                      child: Text('退出'),
                      onPressed: () => Navigator.of(context).pop(true)),
                  ElevatedButton(
                      child: Text('取消'),
                      onPressed: () => Navigator.of(context).pop(false)),
                ],
              )),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SafeArea(
            child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 30),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 10, bottom: 10),
                    child: RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                          TextSpan(
                              text: 'WillPopScope ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  '這個 Widget 的用途，是用來處理各種後退的行為，包含 Android 系統上的實體後退按鈕。\n\n'),
                          TextSpan(
                              text:
                                  '通常 iOS 工程師在寫 Flutter app 的時候，往往會開啟 iOS 模擬器開發，所以很容易會忘記要處理實體後退按鍵，所以，在開發的時候，記得還是要開啟一個 Android 模擬器或 Android 設備測試，免得忘記這些平台專屬的問題。\n\n'),
                          TextSpan(text: '在這個範例當中，會簡單示範如何使用這個 Widget。')
                        ]))),
                Divider(),
                ListTile(
                    leading: TileLeading(text: '1'),
                    title: Text('詢問用戶是否要退出目前的畫面',
                        style: Theme.of(context).textTheme.titleMedium)),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 10, bottom: 10),
                    child: Text(
                        '很多時候，你會希望用戶不要因為不小心按到後退按鈕而退出，造成用戶失去正在輸入的資料。所以，你會想要在用戶按下後退時，跳出一個確認對話框。')),
                ListTile(
                    onTap: () => Navigator.of(context).pushNamed('demo1'),
                    title: Text('前往「後退時跳出提示」範例', textAlign: TextAlign.end),
                    trailing: Icon(Icons.arrow_forward_ios)),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 10, bottom: 10),
                    child: Text('另外一種方式則是，你可以要求用戶按兩下後退，才會真正退出。')),
                ListTile(
                    onTap: () => Navigator.of(context).pushNamed('demo2'),
                    title:
                        Text('前往「使用 Snack Bar」的範例', textAlign: TextAlign.end),
                    trailing: Icon(Icons.arrow_forward_ios)),
                Divider(),
                ListTile(
                    leading: TileLeading(text: '2'),
                    title: Text('控制自訂的 Navigator',
                        style: Theme.of(context).textTheme.titleMedium)),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 10, bottom: 10),
                    child: Text('如果在你的 App 當中，想在某個位置當中放一個常駐的 UI 元件，' +
                        '像是在這個畫面中，下方常駐了一個 Bottom Bar，那麼，你就有可能需要自訂的 Navigator。\n\n' +
                        '而當你有自訂的 Navigator 的時候，就要為這個 Navigator 設置 WillPopScope，這樣才能夠讓 Back 按鈕處理這個 Navigator 的行為，不然就會直接退出。')),
                ListTile(
                    onTap: () => Navigator.of(context).pushNamed('demo3'),
                    title:
                        Text('前往「控制自訂的 Navigator」範例', textAlign: TextAlign.end),
                    trailing: Icon(Icons.arrow_forward_ios)),
                Divider(),
                ListTile(
                    leading: TileLeading(text: '3'),
                    title: Text('CupertinoTabScaffold',
                        style: Theme.of(context).textTheme.titleMedium)),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 10, bottom: 10),
                  child: Text(
                      '在使用 Cupertino Widgets 的 App 中，往往會用到 CupertinoTabScaffold，也就是說，這個 App 裡頭有多個分頁，而每個分頁裡頭其實都有各自的 Navigator。\n\n' +
                          '如果我們希望 Android 的 Back 按鈕按下去之後，是讓 Tab 裡頭的 Navigator 回到上一頁，而不是整個退出 CupertinoTabScaffold，那麼我們就需要多放一個 WillPopScope。'),
                ),
                ListTile(
                    onTap: () => Navigator.of(context).pushNamed('demo4'),
                    title: Text('前往「CupertinoTabScaffold」範例',
                        textAlign: TextAlign.end),
                    trailing: Icon(Icons.arrow_forward_ios)),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class TileLeading extends StatelessWidget {
  const TileLeading({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 30,
        height: 30,
        color: Colors.black,
        child:
            Center(child: Text(text, style: TextStyle(color: Colors.white))));
  }
}
