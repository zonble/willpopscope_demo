import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Demo3 extends StatefulWidget {
  @override
  _Demo3State createState() => _Demo3State();
}

class _Demo3State extends State<Demo3> {
  GlobalKey<NavigatorState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) => Scaffold(
      body: WillPopScope(
          onWillPop: () async {
            if (_key.currentState.canPop()) {
              _key.currentState.pop();
              return false;
            }
            return true;
          },
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Navigator(
                      key: _key,
                      initialRoute: '',
                      onGenerateRoute: (settings) => CupertinoPageRoute(
                          builder: (context) => _Demo3Inner(depth: 0),
                          settings: RouteSettings()))),
              Container(
                  height: 44 + MediaQuery.of(context).padding.bottom,
                  width: double.infinity,
                  color: Colors.black12,
                  child: Column(children: <Widget>[
                    SizedBox(height: 10),
                    Text('Bottom Bar')
                  ]))
            ],
          )));
}

class _Demo3Inner extends StatefulWidget {
  final int depth;

  _Demo3Inner({Key key, this.depth}) : super(key: key);

  @override
  _Demo3InnerState createState() => _Demo3InnerState();
}

class _Demo3InnerState extends State<_Demo3Inner> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('畫面深度 ${widget.depth}'),
        actions: <Widget>[
          TextButton(
              // textColor: Colors.white,
              child: Text('關閉'),
              onPressed: () => Navigator.of(context, rootNavigator: true).pop())
        ],
      ),
      body: Scrollbar(
          child: ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('如果在你的 App 當中，想在某個位置當中放一個常駐的 UI 元件，' +
                  '像是在這個畫面中，下方常駐了一個 Bottom Bar，那麼，你就有可能需要自訂的 Navigator。\n\n' +
                  '而當你有自訂的 Navigator 的時候，就要為這個 Navigator 設置 WillPopScope，這樣才能夠讓 Back 按鈕處理這個 Navigator 的行為，不然就會直接退出。')),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) =>
                            _Demo3Inner(depth: widget.depth + 1)));
                  },
                  child: Text('開啟下一頁')))
        ],
      )));
}
