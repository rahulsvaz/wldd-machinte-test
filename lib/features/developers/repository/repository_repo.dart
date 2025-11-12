

import 'package:wldd/features/developers/model/user_repo_model.dart';

abstract class RepoRepository {

  Future<List<UserRepoModel>> getUserRepository(String url);
}