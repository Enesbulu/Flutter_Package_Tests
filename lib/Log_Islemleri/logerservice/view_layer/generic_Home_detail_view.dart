import 'package:flutter/material.dart';

class GenericHomeDetailView extends StatefulWidget {
  const GenericHomeDetailView({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<GenericHomeDetailView> createState() => _GenericHomeDetailViewState();
}

class _GenericHomeDetailViewState extends State<GenericHomeDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(widget.id)),
    );
  }
}
