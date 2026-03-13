import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  final Dio _dio = Dio(BaseOptions(
    headers: {
      'User-Agent': 'Mozilla/5.0',
      'Accept': 'application/json',
    },
  ));

  /// CONTOH 1: Menggunakan DIO
  Future<List<MahasiswaModel>> getMahasiswaWithDio() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/comments');
      final List<dynamic> data = response.data;
      return data.map((json) => MahasiswaModel.fromJson(json)).toList();
    } catch (e) {
      print('Dio Error: $e');
      // Jika Dio gagal, coba pakai Http sebagai cadangan
      return getMahasiswaWithHttp();
    }
  }

  /// CONTOH 2: Menggunakan HTTP
  Future<List<MahasiswaModel>> getMahasiswaWithHttp() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/comments'),
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => MahasiswaModel.fromJson(json)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Http Error: $e');
      throw Exception('Gagal memuat data mahasiswa');
    }
  }

  Future<List<MahasiswaModel>> getMahasiswaList() => getMahasiswaWithDio();
}
