

import 'package:wldd/features/developers/model/user_details_model.dart';

abstract class UserDetailsRepo{

  Future<UserDetailsModel> getUserDetails (String url);
}