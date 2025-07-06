import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  static const String clientId = 'U3jeq6BLABuDDRmc62UfthLO3dzzjgLZy7SsO4w8';
  static const String clientSecret =
      'pN2GWvHcCedaelB5Om2JPWIU1LHo2Dkpb9DfhnBV1Zc09hE5voRBLI0X6DX2vhlcQ4IHMDSDdn5C8m7jF2QsXCpvkDpCRKUBmQNSP7pEtfgSXHMSWUpR7HaUUKlpZdWF';

  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/token/');
    final response = await http.post(url, body: {
      'grant_type': 'password',
      'client_id': clientId,
      'client_secret': clientSecret,
      'username': username,
      'password': password,
    });

    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', data['access_token']);
      await prefs.setString('refresh_token', data['refresh_token']);
      return {'success': true, 'data': data};
    } else {
      return {
        'success': false,
        'error': data['error_description'] ?? 'Login failed'
      };
    }
  }

  static Future<Map<String, dynamic>> signup(
      String username, String email, String password) async {
    final url = Uri.parse('$baseUrl/accounts/users/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return {'success': true};
    } else {
      final data = json.decode(response.body);
      return {'success': false, 'error': data['info'] ?? data.toString()};
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static Future<Map<String, dynamic>?> getUserProfile() async {
    final token = await getAccessToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/accounts/users/me/');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  static Future<Map<String, dynamic>> updateUserProfile({
    required String phone,
    required String address1,
    required String address2,
    required String city,
    required String state,
    required String zip,
    required String bio,
    File? imageFile,
    String? oldPassword,
    String? newPassword,
  }) async {
    final token = await getAccessToken();
    if (token == null) {
      return {'success': false, 'error': 'Not authenticated'};
    }

    final url = Uri.parse('$baseUrl/accounts/users/me/');
    final request = http.MultipartRequest('PATCH', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['profile.phone'] = phone
      ..fields['profile.present_address'] = address1
      ..fields['profile.permanent_address'] = address2
      ..fields['profile.city'] = city
      ..fields['profile.state'] = state
      ..fields['profile.zip_code'] = zip
      ..fields['profile.bio'] = bio;

    if (oldPassword != null && oldPassword.isNotEmpty) {
      request.fields['old_password'] = oldPassword;
    }
    if (newPassword != null && newPassword.isNotEmpty) {
      request.fields['password'] = newPassword;
    }
    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath('profile.image', imageFile.path),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      final data = json.decode(response.body);
      return {'success': false, 'error': data['info'] ?? data.toString()};
    }
  }

  // ✅ SEND RESET OTP
  static Future<Map<String, dynamic>> requestPasswordReset(String email) async {
    final url = Uri.parse('$baseUrl/accounts/request-reset/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      final data = jsonDecode(response.body);
      return {'success': false, 'error': data['error'] ?? 'Reset failed'};
    }
  }

  // ✅ VERIFY OTP
  static Future<Map<String, dynamic>> verifyOTP(
      String email, String code) async {
    final url = Uri.parse('$baseUrl/accounts/verify-otp/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'code': code}),
    );
    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      final data = jsonDecode(response.body);
      return {
        'success': false,
        'error': data['error'] ?? 'OTP verification failed'
      };
    }
  }

  // ✅ RESET PASSWORD
  static Future<Map<String, dynamic>> resetPassword(
      String email, String newPassword) async {
    final url = Uri.parse('$baseUrl/accounts/reset-password/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'new_password': newPassword}),
    );
    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      final data = jsonDecode(response.body);
      return {
        'success': false,
        'error': data['error'] ?? 'Password reset failed'
      };
    }
  }
}
