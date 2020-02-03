import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Demo4 extends StatefulWidget {
  @override
  _Demo4State createState() => _Demo4State();
}

const int kTabCount = 3;

class _Demo4State extends State<Demo4> {
  GlobalKey<NavigatorState> _key = GlobalKey();
  List<GlobalKey<NavigatorState>> _tabKeys =
      List.generate(kTabCount, (_) => GlobalKey());
  var _controller = CupertinoTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    print('build');
    return WillPopScope(
      onWillPop: () async {
        var key = _tabKeys[_controller.index];
        if (key.currentState.canPop()) {
          key.currentState.pop();
          return false;
        }
        return true;
      },
      child: CupertinoApp(
        navigatorKey: _key,
        theme: CupertinoThemeData(
            primaryColor: Colors.blue, brightness: Brightness.light),
        home: CupertinoTabScaffold(
          controller: _controller,
          tabBuilder: (context, index) => CupertinoTabView(
              navigatorKey: _tabKeys[index],
              builder: (context) => Demo4Inner(index: index, depth: 0)),
          tabBar: CupertinoTabBar(
            items: List.generate(
                kTabCount,
                (index) => BottomNavigationBarItem(
                    icon: Icon(Icons.info), title: Text('分頁 $index'))),
          ),
        ),
      ),
    );
  }
}

class Demo4Inner extends StatefulWidget {
  final int index;
  final int depth;

  Demo4Inner({Key key, this.index, this.depth}) : super(key: key);

  @override
  _Demo4InnerState createState() => _Demo4InnerState();
}

class _Demo4InnerState extends State<Demo4Inner> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('分頁 ${widget.index} 深度 ${widget.depth}'),
        trailing: FlatButton(
          child: Text('關閉'),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ),
      child: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 800),
                      child: Text(
                          '在使用 Cupertino Widgets 的 App 中，往往會用到 CupertinoTabScaffold，也就是說，這個 App 裡頭有多個分頁，而每個分頁裡頭其實都有各自的 Navigator。\n\n' +
                              '如果我們希望 Android 的 Back 按鈕按下去之後，是讓 Tab 裡頭的 Navigator 回到上一頁，而不是整個退出 CupertinoTabScaffold，那麼我們就需要多放一個 WillPopScope。')),
                ),
              ),
              RaisedButton(
                child: Text('開啟下一頁'),
                onPressed: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => Demo4Inner(
                            index: widget.index,
                            depth: widget.depth + 1,
                          )));
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
