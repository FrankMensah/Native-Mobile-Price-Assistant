import 'models.dart';
import 'data_helper.dart';

class FetchLogin {
  //var data = [];

  Future<List<UserAccess>> userAccess() async {
    List<UserAccess> result = [];
    var data = await DatabaseHelper.instance.queryAllPass();

    for (var u in data) {
      UserAccess priCo = UserAccess(
          id: u["id"],
          loginPin: u["loginPin"].toString(),
          phoneNo: u["phoneNo"].toString(),
          dodYear: u["dodYear"].toString(),
          adminPass: u["adminPass"].toString());
      result.add(priCo);
    }

    return result;
  }
}
