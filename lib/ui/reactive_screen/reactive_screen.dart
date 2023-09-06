import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getx_and_rxdart/data/rx_dart/multiplication_controller.dart';

class ReactiveScreen extends StatelessWidget {
  const ReactiveScreen({Key? key, required this.controller}) : super(key: key);
  final MultiplicationController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reactive Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  try {
                    final intValue = int.parse(value);
                    controller.updateFirstNumber(intValue);
                  } catch (e) {

                  }
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'First Number',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  try {
                    final intValue = int.parse(value);
                    controller.updateSecondNumber(intValue);
                  } catch (e) {

                  }
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Second Number',
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: controller.resultStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('Result: ${snapshot.data}',
                      style: const TextStyle(fontSize: 24));
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
