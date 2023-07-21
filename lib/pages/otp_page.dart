import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OptPage extends StatefulWidget {
  final String verificationId;
  const OptPage({super.key, required this.verificationId});

  @override
  State<OptPage> createState() => _OptPageState();
}

class _OptPageState extends State<OptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
              child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Verification",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Text(
                "Enter the code sent to your phone number",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Pinput(
                length: 6,
                showCursor: true,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Verify"),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
