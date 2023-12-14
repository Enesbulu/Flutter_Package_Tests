import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobil_test_projesi1/dio_packet_rest_api/http_service/comments_learn_view.dart';
import 'package:mobil_test_projesi1/dio_packet_rest_api/http_service/post_model.dart';
import 'package:mobil_test_projesi1/dio_packet_rest_api/http_service/post_service.dart';

class ServiceLearn extends StatefulWidget {
  const ServiceLearn({super.key});

  @override
  State<ServiceLearn> createState() => _ServiceLearnState();
}

class _ServiceLearnState extends State<ServiceLearn> {
  List<PostModel>? _items;
  late bool _isLoading = false; // Durum değişkeni: veri yüklenme durumunu değerlendirmek için.
  late final Dio _dio;
  final _baseUrl = "https://jsonplaceholder.typicode.com/";
  late final IPostService _postService;

  /// Ana Sayfa Oluşturma İşlemi.
  @override
  void initState() {
    super.initState();
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    _postService = PostService();
    fetchPostItemsAdvance();
  }

  /// Durum Değişkeni Değiştirmek İçin İşlev.
  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  /// REST API'den Veri Almak İçin İşlev.
  Future<void> fetchPostItems() async {
    _changeLoading();

    ///Dio'yu kullanarak bir REST API'sinden veri alır.
    final response = await Dio().get("https://jsonplaceholder.typicode.com//posts");

    // Eğer istek başarılıysa ve 'ok' durum koduyla dönerse,
    if (response.statusCode == HttpStatus.ok) {
      // Verileri json formatından PostModel tipine çevirin ve items değişkenine atayın.
      final _datas = response.data;
      if (_datas is List) {
        setState(() {
          _items = _datas.map((e) => PostModel.fromJson(e)).toList();
        });
      }
    }
    _changeLoading();
  }

  Future<List<PostModel>?> fetchPostItemsAdvance() async {
    ///Dio'yu kullanarak bir REST API'sinden veri alır.
    _changeLoading();
    _items = await _postService.fetchPostItemsAdvance();
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rest API test Projesi"),
        actions: [_isLoading ? const CircularProgressIndicator.adaptive() : const SizedBox.shrink()], //
      ),
      body: _items == null
          ? const Placeholder()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: _items?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return _PostCard(model: _items?[index]);
              },
            ),
    );
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
