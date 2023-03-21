import 'package:consumo_de_api/data/models/post_model.dart';
import 'package:consumo_de_api/data/repositories/api_repository.dart';
import 'package:consumo_de_api/data/repositories/errors/api_exception.dart';

class PostController {
  final ApiRepository apiRepository;

  PostController(this.apiRepository);

  // Caso de algum erro ao carregar o post, mostrar feedback para o usuário
  String? _errorLoadingPost;

  // Get do error loading post
  String? get getErrorLoadingPost => _errorLoadingPost;

  // Mostrar o circular progress indicator
  bool isLoading = true;

  // Post que vamos carregar
  PostModel? _loadedPost;

  PostModel? get getLoadedPost => _loadedPost;

  Future<void> onLoadPost(int postId) async {
    isLoading = true;
    _errorLoadingPost = null;

    try {
      final post = await apiRepository.getPost(postId);

      _loadedPost = post;
    } on ApiException catch (apiException) {
      _errorLoadingPost = apiException.message;
    } catch (error) {
      _errorLoadingPost = "Erro ao carregar post";
    }

    isLoading = false;
  }
}
