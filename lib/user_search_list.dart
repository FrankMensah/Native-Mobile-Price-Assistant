import 'models.dart';
import 'database_helper.dart';

class FetchUser {
  //var data = [];

  Future<List<PricoData>> pricoData() async {
    List<PricoData> results = [];
    var data = await DatabaseHelper.instance.queryAll();

    for (var u in data) {
      PricoData priCo = PricoData(
          id: u["id"],
          productCode: u["productCode"].toString(),
          productName: u["productName"].toString(),
          productAmount: u["productAmount"].toString());
      results.add(priCo);
    }

    return results;
  }
}
