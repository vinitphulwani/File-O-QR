// ignore_for_file: file_names, avoid_print

import 'package:http/http.dart' as http;

void saveFileData(filename,password)async{
  var request = http.MultipartRequest('POST', Uri.parse('https://vesgroup4.000webhostapp.com/dbwritephp.php'));
request.fields.addAll({
  'filename': filename,
  'password': password
});
 
http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
}
else {
  print(response.reasonPhrase);
}
}