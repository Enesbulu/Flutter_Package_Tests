import 'package:flutter/material.dart';
import 'package:mobil_test_projesi1/dio_packet_rest_api/dio_api_service/post_service.dart';
import 'package:mobil_test_projesi1/http_packet/http_packet_2/http_service/http_model.dart';

class CommentHomeView extends StatefulWidget {
  const CommentHomeView({super.key, this.id});
  final int? id;

  @override
  State<CommentHomeView> createState() => _CommentHomeViewState();
}

class _CommentHomeViewState extends State<CommentHomeView> {
  late final postService;
  List<CommentModel>? _commentsItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: ListView.builder(
        itemCount: _commentsItem?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Text(_commentsItem?[index].email ?? ''),
          );
        },
      ),
    );
  }
}
