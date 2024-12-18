import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkAware extends StatefulWidget {
  final Widget child;
  final Widget Function(bool)? connectionStateBuilder;

  const NetworkAware({
    Key? key,
    required this.child,
    this.connectionStateBuilder,
  }) : super(key: key);

  @override
  _NetworkAwareState createState() => _NetworkAwareState();
}

class _NetworkAwareState extends State<NetworkAware> {
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _isConnected = result != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.connectionStateBuilder != null) {
      return widget.connectionStateBuilder!(_isConnected);
    }

    return Stack(
      children: [
        widget.child,
        if (!_isConnected)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'No internet connection',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
