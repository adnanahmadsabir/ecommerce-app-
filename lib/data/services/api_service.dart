import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const _hostUrl = "http://192.168.1.177/clothes_app";

  Future<Map<String, dynamic>?> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final response =
        await http.post(Uri.parse("$_hostUrl/$endpoint"), body: data);
    if (response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>?> get(String endpoint) async {
    final response = await http.get(Uri.parse("$_hostUrl/$endpoint"));
    if (response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>?> multiPartRequest(String endpoint,
      String imageCol, String path, Map<String, String> data) async {
    final req = http.MultipartRequest('POST', Uri.parse("$_hostUrl/$endpoint"));
    req.files.add(await http.MultipartFile.fromPath(imageCol, path));
    req.fields.addAll(data);

    final res = await req.send();
    return json.decode(await res.stream.bytesToString());
  }
}
