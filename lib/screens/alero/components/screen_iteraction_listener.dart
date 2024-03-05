

import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/Global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:one_context/one_context.dart';
import 'package:quiver/async.dart';

class ScreenInteractionListener extends StatefulWidget {
  final Widget child;
  final int timeout;
  final String route;

  const ScreenInteractionListener(
      {Key? key,
        required this.child,
        required this.timeout,
        this.route = '/login'})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScreenInteractionListenerState();
  }
}

class _ScreenInteractionListenerState extends State<ScreenInteractionListener>
    with WidgetsBindingObserver {
  late CountdownTimer countdownTimer;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    if (state == AppLifecycleState.paused) {
      countdownTimer = CountdownTimer(
          Duration(minutes: Global.APP_TIMEOUT!), Duration(seconds: 1));
    } else if (state == AppLifecycleState.resumed) {
      if (countdownTimer.remaining > Duration(seconds: 0)) {
        print(countdownTimer.remaining);
        print('lifecycle still on');
      } else {
        print('lifecycle ended logging out');
        logoutUser(context);
      }
      countdownTimer.cancel();
    }
  }

  void logoutUser(BuildContext context) async {
    var apiService = AleroAPIService();
    var response;
    try {
      OneContext().hideProgressIndicator();
      response = await apiService.logoutUser();
      if (response != null) {
        OneContext().hideProgressIndicator();
        Phoenix.rebirth(context);
      }
    } catch (error) {
      print(error);
      OneContext().hideProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}
