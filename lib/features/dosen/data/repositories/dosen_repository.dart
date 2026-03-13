import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../models/dosen_model.dart';

class DosenRepository {
  final Dio _dio = Dio(BaseOptions(
    headers: {
      'User-Agent': 'PostmanRuntime/7.32.3',
      'Accept': 'application/json',
    },
  ));

  /// CONTOH 1: Menggunakan DIO (Instruksi No. 7)
  Future<List<DosenModel>> getDosenWithDio() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/users');
      final List<dynamic> data = response.data;
      return data.map((json) => DosenModel.fromJson(json)).toList();
    } catch (e) {
      print('Dio Error: $e');
      // Jika Dio gagal (403), coba otomatis pakai Http sebagai fallback
      return getDosenWithHttp();
    }
  }

  /// CONTOH 2: Menggunakan HTTP
  Future<List<DosenModel>> getDosenWithHttp() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => DosenModel.fromJson(json)).toList();
      } else {
        throw Exception('Server return ${response.statusCode}');
      }
    } catch (e) {
      print('Http Error: $e');
      throw Exception('Gagal memuat data dosen');
    }
  }

  // Method utama yang dipanggil provider
  Future<List<DosenModel>> getDosenList() => getDosenWithDio();
}
