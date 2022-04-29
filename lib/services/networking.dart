import 'package:http/http.dart' as http;
import 'dart:convert';

//this helper take a url, and then with json.decode() parse the data. json data being as map.
class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

  Future getData() async {
    try {
      http.Response response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
