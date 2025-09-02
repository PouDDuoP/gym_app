import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // <--- THIS IS THE MISSING IMPORT
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  ApiService({required this.baseUrl, required this.defaultHeaders});

  Uri _buildUri(String endpoint, [Map<String, String>? queryParams]) {
    return Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
  }

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token != null) {
      defaultHeaders['Authorization'] =
          'Bearer $token'; // Formato común para JWT
      defaultHeaders['Content-Type'] = 'application/json';
    }
    return defaultHeaders;
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    final response = await http.get(
      _buildUri(endpoint, queryParams),
      headers: await _getHeaders(),
    );
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, dynamic body) async {
    final response = await http.post(
      _buildUri(endpoint),
      headers: await _getHeaders(),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, dynamic body) async {
    final response = await http.put(
      _buildUri(endpoint),
      headers: await _getHeaders(),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> patch(String endpoint, dynamic body) async {
    final response = await http.patch(
      _buildUri(endpoint),
      headers: await _getHeaders(),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(
      _buildUri(endpoint),
      headers: await _getHeaders(),
    );
    return _handleResponse(response);
  }

  Future<dynamic> postMultipart(
    String endpoint, {
    required String path,
    String fieldName = 'file',
    Map<String, String>? fields,
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(endpoint);
    final request = http.MultipartRequest('POST', uri);

    // Campos de texto adicionales (si hay)
    if (fields != null) {
      request.fields.addAll(fields);
    }

    // Añadir el archivo
    final multipartFile = await http.MultipartFile.fromPath(
      fieldName,
      path,
      filename: basename(path),
      contentType: MediaType('image', 'png'),
    );
    request.files.add(multipartFile);

    // Headers: combina los default con los específicos si los hay
    request.headers.addAll({
      ...await _getHeaders()
        ..remove('Content-Type'), // Content-Type lo maneja MultipartRequest
      if (headers != null) ...headers,
    });

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }
}
