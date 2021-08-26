import 'package:get/get.dart';
import 'package:allsafe_appmobile/src/models/users_model.dart';
import 'package:allsafe_appmobile/src/provider/users_provider.dart';

class CharacterState extends GetxController {
  List<UserModel> user = [];
  final _userProvider = UserProvider();

  Future<void> obtenerUsuarios() async {
    final users = await _userProvider.ObtenerUsers();
    user.addAll(users);
    update();
  }
}
