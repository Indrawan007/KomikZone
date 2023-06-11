import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:komikzone/app/routes/app_pages.dart';

class AuthController extends GetxController {
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;

  Future<void> login() async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.signIn().then((value) => _currentUser = value);

      await _googleSignIn.isSignedIn().then((value) {
        if (value) {
          print("Berhasil Login dengan akun : ");
          print(_currentUser);
          isAuth.value = true;
          Get.offAllNamed(Routes.HOME);
        } else {
          print("Tidak berhasil Login");
        }
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
