import 'package:flutter/material.dart';

class Demo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Deme 2')),
      body: Container(child: SnackBarPage()),
    );
  }
}

class SnackBarPage extends StatefulWidget {
  @override
  _SnackBarPageState createState() => _SnackBarPageState();
}

class _SnackBarPageState extends State<SnackBarPage> {
  var _snackBarPresenting = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_snackBarPresenting) return true;
        _snackBarPresenting = true;
        var snackBar = SnackBar(content: Text('再按一次 Back 按鈕退出'));
        Scaffold.of(context).showSnackBar(snackBar)
          ..closed.then((_) {
            _snackBarPresenting = false;
          });
        return false;
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('在這個範例中，如果您按下了實體的 Back 按鈕，會詢問您是否要退出'),
        ),
      ),
    );
  }
}
