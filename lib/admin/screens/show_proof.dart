import 'package:flutter/material.dart';

class Proof extends StatefulWidget {
  final String proofImg;
  const Proof({super.key, required this.proofImg});

  @override
  State<Proof> createState() => _ProofState();
}

class _ProofState extends State<Proof> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Proof'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image(
          fit: BoxFit.contain,
          image: NetworkImage(widget.proofImg),
        ),
      ),
    );
  }
}
