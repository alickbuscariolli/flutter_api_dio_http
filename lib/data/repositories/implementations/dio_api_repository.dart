import 'dart:developer';

import 'package:consumo_de_api/data/models/post_model.dart';
import 'package:consumo_de_api/data/repositories/api_repository.dart';
import 'package:consumo_de_api/data/repositories/errors/api_exception.dart';
import 'package:dio/dio.dart';

class DioApiRepository implements ApiRepository {
  final Dio _dio;

  DioApiRepository({required Dio dio}) : _dio = dio;

  @override
  Future<PostModel?> getPost(int postId) async {
    try {
      final url = '$API_URL/posts/$postId';

      final response = await _dio.get(url);

      return PostModel.fromMap(response.data);
    } on DioError catch (dioError) {
      throw ApiException(message: dioError.message ?? "Erro ao carregar post");
    } catch (error, stacktrace) {
      log("Erro ao fazer get do post:", error: error, stackTrace: stacktrace);

      throw ApiException(message: "Erro ao carregar post");
    }
  }
}
