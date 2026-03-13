import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  final Dio _dio = Dio(BaseOptions(
    headers: {
      'User-Agent': 'Mozilla/5.0',
      'Accept': 'application/json',
    },
  ));

  /// CONTOH 1: Menggunakan DIO
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifWithDio() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
      final List<dynamic> data = response.data;
      return data.map((json) => MahasiswaAktifModel.fromJson(json)).toList();
    } catch (e) {
      print('Dio Error (Mahasiswa Aktif): $e');
      // Jika Dio gagal (403), coba otomatis pakai Http
      return getMahasiswaAktifWithHttp();
    }
  }

  /// CONTOH 2: Menggunakan HTTP
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifWithHttp() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => MahasiswaAktifModel.fromJson(json)).toList();
      } else {
        throw Exception('Server return ${response.statusCode}');
      }
    } catch (e) {
      print('Http Error (Mahasiswa Aktif): $e');
      throw Exception('Gagal memuat data mahasiswa aktif');
    }
  }

  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() => getMahasiswaAktifWithDio();
}
