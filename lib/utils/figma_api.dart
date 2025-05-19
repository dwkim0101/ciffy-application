import 'dart:convert';
import 'package:http/http.dart' as http;

class FigmaApi {
  final String apiKey;
  final String fileId;

  FigmaApi({required this.apiKey, required this.fileId});

  Future<Map<String, dynamic>> fetchFigmaData() async {
    final url = 'https://api.figma.com/v1/files/$fileId';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-Figma-Token': apiKey,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Figma data: ${response.statusCode}');
    }
  }
}
