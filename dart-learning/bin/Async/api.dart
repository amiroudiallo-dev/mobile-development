import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {

  var data = await fetchAllAlbum();

  print(data[0]['title']);

  for (var i = 1; i <= data.length; i++){
      print(data[i]['userId']);
      print(data[i]['id']);
      print(data[0]['title']);
      print('---------');
  }

}

Future<dynamic> fetchAllAlbum() async {
    final url = 'https://jsonplaceholder.typicode.com/albums';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var  obj = json.decode(res.body);
      return obj;
    } else {
      print('Error');
    }
}