import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobil_test_projesi1/dio_packet_rest_api/http_service/comment_model.dart';
import 'post_model.dart';

abstract class IPostService {
  Future<bool> addItemToService(PostModel postModel, int id);
  Future<bool> putItemToService(PostModel postModel);
  Future<bool> deleteItemToService(PostModel postModel, int id);
  Future<List<PostModel>?> fetchPostItemsAdvance();
  Future<List<CommentModel>?> fetchRelatedCommentsWithPostId(int postId);
}

class PostService implements IPostService {
  late final Dio _dio;

  //final olarak tanımlama yapmamak için tanımlama şeklini kullanıyoruz.
  PostService() : _dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/'));

  ///Bir item için post işlemi yapılıyor. Sonuç olarak bool değer döndürür
  @override
  Future<bool> putItemToService(PostModel postModel) async {
    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      final response = await _dio.post(_PostServicePath.posts.name, data: postModel);
      return response.statusCode == HttpStatus.created;
    } on DioException catch (exception) {
      _ShowDebug.showDoError(exception, this);
    }
    return false;
  }

  //Verilen id değerine göre veriyi günceller. Sonuç olarak bool degeri döner. Servis işleminde hata olursa 'false' döner.
  @override
  Future<bool> addItemToService(PostModel postModel, int id) async {
    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      final response = await _dio.put('${_PostServicePath.posts.name}/$id', data: postModel);
      return response.statusCode == HttpStatus.ok;
    } on DioException catch (exception) {
      _ShowDebug.showDoError(exception, this);
    }
    return false;
  }

  ///Id'ye göre item silme işlemi. İşlem durumunu bool tipinde geriye döndürür.
  @override
  Future<bool> deleteItemToService(PostModel postModel, int id) async {
    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      final response = await _dio.put('${_PostServicePath.posts.name}/$id');
      return response.statusCode == HttpStatus.ok;
    } on DioException catch (exception) {
      _ShowDebug.showDoError(exception, this);
    }
    return false;
  }

  /// REST API'den bütün verileri almak işlevi gerçekleştirir. Gelen veriyi liste olarak döner. Değer gelmezse null döner.
  @override
  Future<List<PostModel>?> fetchPostItemsAdvance() async {
    try {
      ///Dio'yu kullanarak bir REST API'sinden veri alır.
      final response = await _dio.get(_PostServicePath.posts.name);

      // Eğer istek başarılıysa ve 'ok' durum koduyla dönerse,
      if (response.statusCode == HttpStatus.ok) {
        // Verileri json formatından PostModel tipine çevirin ve items değişkenine atayın.
        final _datas = response.data;
        if (_datas is List) {
          return _datas.map((e) => PostModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (exception) {
      _ShowDebug.showDoError(exception, this);
    }
    return null;
  }

  @override
  Future<List<CommentModel>?> fetchRelatedCommentsWithPostId(int postId) async {
    try {
      ///Dio'yu kullanarak bir REST API'sinden veri alır.
      final response = await _dio.get(_PostServicePath.comments.name, queryParameters: {_PostQueryPaths.postId.name: postId});

      // Eğer istek başarılıysa ve 'ok' durum koduyla dönerse,
      if (response.statusCode == HttpStatus.ok) {
        // Verileri json formatından PostModel tipine çevirin ve items değişkenine atayın.
        final _datas = response.data;
        if (_datas is List) {
          return _datas.map((e) => CommentModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (exception) {
      _ShowDebug.showDoError(exception, this);
    }
    return null;
  }
}

enum _PostServicePath { posts, comments }

enum _PostQueryPaths { postId }

///Hata yakalama sistemi
class _ShowDebug {
  static void showDoError<T>(DioException error, T type) {
    if (kDebugMode) {
      print(error.message);
      print(type);
    }
  }
}
