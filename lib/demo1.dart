import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Deme 1')),
        body: WillPopScope(
            onWillPop: () async => showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(title: Text('你確定要退出嗎？'), actions: <Widget>[
                      ElevatedButton(
                          child: Text('退出'),
                          onPressed: () => Navigator.of(context).pop(true)),
                      ElevatedButton(
                          child: Text('取消'),
                          onPressed: () => Navigator.of(context).pop(false)),
                    ])),
            child: Container(
                child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('在這個範例中，如果您按下了實體的 Back 按鈕，會詢問您是否要退出')),
            ))));
  }
}
