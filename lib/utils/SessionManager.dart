import 'package:shared_preferences/shared_preferences.dart';

abstract class RuleUtils{
  void savePreference(bool status, String idUser, String fullnameUser, String emailUser, String photoUser);
  Future getPreference();
}

class SessionManager extends RuleUtils{
  String globIduser,globName,globEmail, globPhoto;
  bool globStatus;

  @override
  void savePreference(bool status, String idUser, String fullnameUser, String emailUser, String photoUser) async{
    // TODO: implement savePreference
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("myStatus", status);
    sharedPreferences.setString("myIduser", idUser);
    sharedPreferences.setString("myName", fullnameUser);
    sharedPreferences.setString("myEmail", emailUser);
    sharedPreferences.setString("myPhoto", photoUser);
    sharedPreferences.commit();
  }

  @override
  Future getPreference() async {
    // TODO: implement getPreference
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      globStatus = sharedPreferences.getBool("myStatus");
      globIduser = sharedPreferences.getString("myIduser");
      globName = sharedPreferences.getString("myName");
      globEmail = sharedPreferences.getString("myEmail");
      globPhoto = sharedPreferences.getString("myPhoto");
      return globStatus;
  }
}