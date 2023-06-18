import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:komikzone/app/data/db/favorite.dart';
import 'package:komikzone/app/data/model/details.dart';
import 'package:komikzone/app/data/models/user_model.dart';
import 'package:komikzone/app/routes/app_pages.dart';
import 'package:sqflite/sqflite.dart';

class AuthController extends GetxController {
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  UserCredential? userCredential;

  var user = UserModel().obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> firstInitialized() async {
    await autoLogin().then(
      (value) {
        if (value) {
          isAuth.value = true;
        }
      },
    );
  }

  Future<bool> autoLogin() async {
    // mengubah isAuth => true => autoLogin
    try {
      final isSIgnIn = await _googleSignIn.isSignedIn();

      if (isSIgnIn) {
        await _googleSignIn
            .signInSilently()
            .then((value) => _currentUser = value);
        final googleAuth = await _currentUser!.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);
        print("User Credential");

        // masukkan data ke firebase...
        CollectionReference users = firestore.collection("Users");

        users.doc(_currentUser!.email).update({
          "lastSignInTime":
              userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
        });

        final currUser = await users.doc(_currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;

        user(UserModel(
          uid: currUserData["uid"],
          name: currUserData["name"],
          email: currUserData["email"],
          photoUrl: currUserData["photoUrl"],
          status: currUserData["status"],
          createdAt: currUserData["createdAt"],
          lastSignInTime: currUserData["lastSignInTime"],
          updateAt: currUserData["updateAt"],
        ));

        return true;
      }
      return false;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<void> login() async {
    try {
      // Untuk handle kebocoran data user sebelum login
      await _googleSignIn.signOut();

      // Untuk mendapatkan google account
      await _googleSignIn.signIn().then((value) => _currentUser = value);

      // Untuk mengecek status login user
      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        // Kondisi login berhasil
        print("Berhasil Login dengan akun : ");
        print(_currentUser);

        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);
        print("User Credential");

        // masukkan data ke firebase...
        CollectionReference users = firestore.collection("Users");

        final checkuser = await users.doc(_currentUser!.email).get();

        if (checkuser.data() == null) {
          users.doc(_currentUser!.email).set({
            "uid": userCredential!.user!.uid,
            "name": _currentUser!.displayName,
            "email": _currentUser!.email,
            "photoUrl": _currentUser!.photoUrl ?? "noimage",
            "status": "",
            "createdAt":
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "updateAt": DateTime.now().toIso8601String(),
          });
        } else {
          users.doc(_currentUser!.email).update({
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
          });
        }

        final currUser = await users.doc(_currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;

        user(UserModel(
          uid: currUserData["uid"],
          name: currUserData["name"],
          email: currUserData["email"],
          photoUrl: currUserData["photoUrl"],
          status: currUserData["status"],
          createdAt: currUserData["createdAt"],
          lastSignInTime: currUserData["lastSignInTime"],
          updateAt: currUserData["updateAt"],
        ));

        isAuth.value = true;
        Get.offAllNamed(Routes.HOME);
      } else {
        print("Tidak berhasil Login");
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void changeProfile(String name) {
    String date = DateTime.now().toIso8601String();

    CollectionReference users = firestore.collection("Users");

    users.doc(_currentUser!.email).update({
      // Update firebase
      "name": name,
      "lastSignInTime":
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      "updateAt": date
    });

    // Update Model
    user.update((user) {
      user!.name = name;
      user.lastSignInTime =
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      user.updateAt = date;
    });

    user.refresh();

    Get.defaultDialog(title: "Succes", middleText: "Change Profile Success");
  }

  DatabaseManager database = DatabaseManager.instance;

  void addFavorite(bool lastRead, Details komik, int indexComic) async {
    // insert data
    Database db = await database.db;

    bool flagExist = false;

    if (lastRead == true) {
      await db.delete("favorite", where: "last_read = 1");
    } else {
      List checkData = await db.query("favorite",
          where:
              'comic = "${komik.title}" and chapter = "${komik.chapters![indexComic].chapter}" and via = "comic" and index = $indexComic and lastRead = 0');
      if (checkData.length != 0) {
        // add data
        flagExist = true;
      }
    }

    if (flagExist == false) {
      await db.insert(
        "favorite",
        {
          "comic": "${komik.title}",
          "thumbnail": "${komik.thumbnail}",
          "chapter": "${komik.chapters![indexComic].chapter}",
          "via": "comic",
          "index": indexComic,
          "last_read": lastRead == true ? 1 : 0,
        },
      );

      Get.back(); // tutup dialog
      Get.snackbar(
        "Barhasil",
        "Berhasil menambahkan favorite",
      );
    } else {
      Get.back(); // tutup dialog
      Get.snackbar(
        "Terjadi Kesalahan",
        "Favorite telah tersedia",
      );
    }

    var data = await db.query("favorite");
    print(data);
  }
}
