import 'package:flutter/material.dart';
import 'package:mobil_test_projesi1/Log_Islemleri/logerservice/view_layer/generic_Home_detail_view.dart';

class GenericHomeView extends StatefulWidget {
  const GenericHomeView({super.key});

  @override
  State<GenericHomeView> createState() => _GenericHomeViewState();
}

class _GenericHomeViewState extends State<GenericHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Text('$index'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GenericHomeDetailView(id: '$index'))),
            ),
          );
        },
      ),
    );
  }
}
