import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobil_test_projesi1/dio_packet_rest_api/dio_api_service/comments_learn_view.dart';
import 'package:mobil_test_projesi1/dio_packet_rest_api/dio_api_service/post_model.dart';

class ServicePostLearn extends StatefulWidget {
  const ServicePostLearn({super.key});

  @override
  State<ServicePostLearn> createState() => _ServicePostLearnState();
}

class _ServicePostLearnState extends State<ServicePostLearn> {
  late bool _isLoading = false; // Durum değişkeni: veri yüklenme durumunu değerlendirmek için.
  late final Dio _dio;
  final _baseUrl = 'https://jsonplaceholder.typicode.com/';

  String? name;

//TextField'lar için controller nesneleri
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  /// Ana Sayfa Oluşturma İşlemi.
  @override
  void initState() {
    super.initState();

    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
  }

  /// Durum Değişkeni Değiştirmek İçin İşlev.
  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> _addItemToService(PostModel postModel) async {
    _changeLoading();
    _dio.options.headers['Content-Type'] = 'application/json';
    final response = await _dio.post('posts', data: postModel);
    if (response.statusCode == HttpStatus.created) {
      name = 'Basarili';
      print('---!!--- Name : Başarılı');
    }
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rest API test Projesi"),
          actions: [_isLoading ? const CircularProgressIndicator.adaptive() : const SizedBox.shrink()], //
        ),
        body: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title:"),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: "Body:"),
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: _userIdController,
              keyboardType: TextInputType.number,
              autofillHints: const [AutofillHints.creditCardNumber],
              decoration: const InputDecoration(labelText: "UserId:"),
            ),
            TextButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        if (_titleController.text.isNotEmpty && _bodyController.text.isNotEmpty && _userIdController.text.isNotEmpty) {
                          final model =
                              PostModel(body: _bodyController.text, title: _titleController.text, userId: int.tryParse(_userIdController.text));
                          _addItemToService(model);
                          print('---!!---içerikler başarı ile çekildi!!');
                        }
                      },
                child: const Text('Send'))
          ],
        ));
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    super.key,
    required PostModel? model,
  }) : _model = model;
  final PostModel? _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CommentsLearnView(
                postId: _model?.id,
              ),
            ),
          );
        },
        title: Text(_model?.title ?? ''),
        subtitle: Text(_model?.body ?? ''),
      ),
    );
  }
}
