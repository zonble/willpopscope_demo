# PopScope Demo (Modernized from WillPopScope)

Demonstrates how to use PopScope widget in Flutter 3.32.0+ to handle back button behavior on different platforms. This project has been modernized from the deprecated WillPopScope to the new PopScope widget.

## Overview

PopScope is a widget that prevents or controls back navigation gestures and system back button presses. It's the modern replacement for the deprecated WillPopScope widget.

## Key Changes from WillPopScope to PopScope

- **Old (WillPopScope)**: `onWillPop: () async { return true/false; }`
- **New (PopScope)**: `canPop: false, onPopInvokedWithResult: (didPop, result) async { ... }`

## Demo 1: Exit Confirmation Dialog

Shows how to display a confirmation dialog when the user tries to navigate back:

```dart
PopScope(
  canPop: false,
  onPopInvokedWithResult: (didPop, result) async {
    if (didPop) return;
    
    final shouldPop = await showDialog<bool>(
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
      ),
    );
    
    if (shouldPop == true) {
      Navigator.of(context).pop();
    }
  },
  child: YourWidgetHere(),
)
```

## Demo 2: Double-Tap to Exit with SnackBar

Requires users to press back twice to exit, showing a SnackBar as feedback:

```dart
class _SnackBarPageState extends State<SnackBarPage> {
  var _snackBarPresenting = false;

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, result) async {
      if (didPop) return;
      
      if (_snackBarPresenting) {
        Navigator.of(context).pop();
        return;
      }
      
      _snackBarPresenting = true;
      var snackBar = SnackBar(content: Text('再按一次 Back 按鈕退出'));
      ScaffoldMessenger.of(context)
        ..showSnackBar(snackBar)
            .closed
            .then((_) => _snackBarPresenting = false);
    },
    child: YourContentWidget(),
  );
}
```

## Demo 3: Custom Navigator Control

Handles back navigation in apps with custom Navigators (e.g., with persistent bottom bars):

```dart
class _Demo3State extends State<Demo3> {
  GlobalKey<NavigatorState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        
        if (_key.currentState?.canPop() == true) {
          _key.currentState?.pop();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Column(
        children: <Widget>[
          Expanded(
            child: Navigator(
              key: _key,
              initialRoute: '',
              onGenerateRoute: (settings) => CupertinoPageRoute(
                builder: (context) => YourPageWidget(),
              ),
            ),
          ),
          BottomBarWidget(),
        ],
      ),
    ),
  );
}
```

## Demo 4: CupertinoTabScaffold Navigation

Proper back button handling in iOS-style tab applications:

```dart
class _Demo4State extends State<Demo4> {
  List<GlobalKey<NavigatorState>> _tabKeys = 
      List.generate(kTabCount, (_) => GlobalKey());
  var _controller = CupertinoTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        
        var key = _tabKeys[_controller.index];
        if (key.currentState?.canPop() == true) {
          key.currentState?.pop();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: CupertinoTabScaffold(
        controller: _controller,
        tabBuilder: (context, index) => CupertinoTabView(
          navigatorKey: _tabKeys[index],
          builder: (context) => YourTabContent(index: index),
        ),
        tabBar: CupertinoTabBar(items: tabItems),
      ),
    );
  }
}
```

## Requirements

- Flutter 3.32.0 or later
- Dart 3.3.0 or later

## Getting Started

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

## Platform Support

This demo works on:
- Android (handles system back button)
- iOS (handles swipe back gestures when disabled)
- Web (handles browser back button)
- Desktop platforms

## Key Differences from WillPopScope

| Aspect | WillPopScope (deprecated) | PopScope (modern) |
|--------|---------------------------|-------------------|
| Return value | `bool` (true/false) | `void` (use canPop property) |
| Callback | `onWillPop` | `onPopInvokedWithResult` |
| Pop control | Return false to prevent | Set `canPop: false` and handle manually |
| Result handling | Not available | Access pop result via callback parameter |

## Migration Guide

To migrate from WillPopScope to PopScope:

1. Replace `WillPopScope` with `PopScope`
2. Replace `onWillPop: () async { ... }` with `onPopInvokedWithResult: (didPop, result) async { ... }`
3. Set `canPop: false` to prevent automatic popping
4. Handle navigation manually in the callback using `Navigator.of(context).pop()`
5. Check `didPop` parameter to avoid double-handling

## Learn More

- [Flutter PopScope Documentation](https://api.flutter.dev/flutter/widgets/PopScope-class.html)
- [Migration Guide](https://docs.flutter.dev/release/breaking-changes/willpopscope)
- [Navigation and Routing](https://docs.flutter.dev/development/ui/navigation)
