import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = "http://127.0.0.1:8000/api";

  Future<bool> simpanBooking({
    required String nama,
    required String noHp,
    required String jenisLaundry,
    required String alamat,
    required String tanggal,
    required String jam,
  }) async {

    final response = await http.post(
      Uri.parse("$baseUrl/orders"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "nama": nama,
        "no_hp": noHp,
        "jenis_laundry": jenisLaundry,
        "alamat": alamat,
        "tanggal": tanggal,
        "jam": jam,
      }),
    );

    print(response.statusCode);
    print(response.body);

    return response.statusCode == 201;
  }
}