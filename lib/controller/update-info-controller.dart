import 'package:ecommerce_app/models/update_user_response.dart';
import 'package:ecommerce_app/service/user_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class UserController extends GetxController {
  UpdateUser? user;

  set updateUser(value) => user = value;
  Future updateUserProfile(
      String userName, String fullname, String email, String phone) async {
    //call api to update user profile
    Logger().i('Log update thong tin ne');
    await UserService.instance.updateUser(userName, fullname, email, phone);
  }

  Future changePassword(String userId, String oldPass, String newPass) async {
    Logger().i('Log Update pass');
    var response =
        await UserService.instance.changePass(userId, oldPass, newPass);
    Logger().i(response!.message!);
  }
}
