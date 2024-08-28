import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ewaste/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  StreamSocket streamSocket = StreamSocket();

  void connectAndListen() {
    print("Connecting....");
    IO.Socket socket = IO.io(dotenv.env['API_URL']!,
        IO.OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((_) {
      print('Connected to Socket');
    });

    // When an event recieved from server, data is added to the stream
    socket.on(context.read<AuthProvider>().user!.sensorId, (data) {
      print("Received Data: $data");
      streamSocket.addResponse(data.toString());
    });

    socket.onDisconnect((_) => print('Disconnected from socket'));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => connectAndListen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('E Waste Dashboard'),
          elevation: 3,
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: streamSocket.getResponse,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return Column(children: [
                  const SizedBox(height: 20),
                  Container(
                      height: 250,
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/bin.jpg'),
                              fit: BoxFit.contain))),
                  const SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFE7E9ED))),
                        Container(
                          width: MediaQuery.of(context).size.width *
                              (snapshot.data != null &&
                                      double.tryParse(snapshot.data!) != null
                                  ? double.tryParse(snapshot.data!)! / 100
                                  : 0),
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF3CB62A)),
                        )
                      ])),
                  const SizedBox(height: 10),
                  Text(
                    "${snapshot.data ?? 0}% filled",
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        color: Color(0xFF1F1F1F),
                        fontWeight: FontWeight.w300,
                        fontSize: 18),
                  ),
                ]);
              }),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
