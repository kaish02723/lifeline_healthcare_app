// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
//
// class NetworkWrapper extends StatefulWidget {
//   final Widget child;
//   const NetworkWrapper({super.key, required this.child});
//
//   @override
//   State<NetworkWrapper> createState() => _NetworkWrapperState();
// }
//
// class _NetworkWrapperState extends State<NetworkWrapper> {
//   bool isOffline = false;
//
//   @override
//   void initState() {
//     super.initState();
//     checkConnection();
//     // Listen to changes
//     Connectivity().onConnectivityChanged.listen((result) {
//       setState(() {
//         isOffline = result == ConnectivityResult.none;
//       });
//       if (isOffline) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("No Internet Connection!"),
//             duration: Duration(seconds: 3),
//           ),
//         );
//       }
//     });
//   }
//
//   Future<void> checkConnection() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     setState(() {
//       isOffline = connectivityResult == ConnectivityResult.none;
//     });
//
//     if (isOffline) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("No Internet Connection!"),
//             duration: Duration(seconds: 3),
//           ),
//         );
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }
