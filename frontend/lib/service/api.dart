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
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    final url = Uri.parse('$baseUrl/accounts/signup/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
      }),
    );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return {'success': true, 'user_id': data['user_id']};
    } else {
      return {'success': false, 'error': data['info'] ?? data.toString()};
    }
  }

  static Future<Map<String, dynamic>> verifyOtp(
    String email,
    String code,
  ) async {
    final url = Uri.parse('$baseUrl/accounts/verify-signup/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'code': code,
      }),
    );
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      return {'success': true, 'message': data['message']};
    } else {
      return {'success': false, 'error': data['error'] ?? 'Unknown error'};
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
    required String division,
    required String zip,
    required String experience_title,
    required String experience_duration,
    required String experience_company,
    required String experience_organization_address,
    required String experience_description,
    required String education_institution,
    required String education_duration,
    required String education_department_name,
    required String education_institution_address,
    required String certification_title,
    required String certification_year,
    required String certification_description,
    required String bio,
    File? imageFile,
    String? oldPassword,
    String? newPassword,
    String? bloodGroup,
    Map<String, String>? experience,
    Map<String, String>? certification,
  }) async {
    final token = await getAccessToken();
    if (token == null) {
      return {'success': false, 'error': 'Not authenticated'};
    }

    final url = Uri.parse('$baseUrl/accounts/users/me/');
    final request = http.MultipartRequest('PATCH', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['profile.phone'] = phone
      ..fields['profile.location.home_address'] = address1
      ..fields['profile.location.office_address'] = address2
      ..fields['profile.location.city'] = city
      ..fields['profile.location.district'] = state
      ..fields['profile.location.division'] = division
      ..fields['profile.location.zip_code'] = zip
      ..fields['profile.experience.experience_title'] = experience_title
      ..fields['profile.experience.duration'] = experience_duration
      ..fields['profile.experience.organization_name'] = experience_company
      ..fields['profile.experience.organization_address'] =
          experience_organization_address
      ..fields['profile.experience.description'] = experience_description
      ..fields['profile.education.institution_name'] = education_institution
      ..fields['profile.education.duration'] = education_duration
      ..fields['profile.education.department_name'] = education_department_name
      ..fields['profile.education.institution_address'] =
          education_institution_address
      ..fields['profile.certification.certificate_title'] = certification_title
      ..fields['profile.certification.year'] = certification_year
      ..fields['profile.certification.description'] = certification_description
      ..fields['profile.bio'] = bio;

    if (bloodGroup != null && bloodGroup.isNotEmpty) {
      request.fields['profile.blood_group'] = bloodGroup;
    }

    if (oldPassword != null && oldPassword.isNotEmpty) {
      request.fields['old_password'] = oldPassword;
    }
    if (newPassword != null && newPassword.isNotEmpty) {
      request.fields['password'] = newPassword;
    }
    if (imageFile != null) {
      request.files.add(
          await http.MultipartFile.fromPath('profile.image', imageFile.path));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      try {
        final data = json.decode(response.body);
        return {'success': false, 'error': data['info'] ?? data.toString()};
      } catch (e) {
        return {'success': false, 'error': 'Unexpected error'};
      }
    }
  }

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

  static Future<List<SafetyGuide>> getSafetyGuides() async {
    final url = Uri.parse('$baseUrl/safety/guides/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((item) => SafetyGuide.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load safety guides');
    }
  }
}

class SafetyAdvice {
  final int id;
  final String text;

  SafetyAdvice({required this.id, required this.text});

  factory SafetyAdvice.fromJson(Map<String, dynamic> json) {
    return SafetyAdvice(
      id: json['id'],
      text: json['text'] ?? '',
    );
  }
}

class SafetyGuide {
  final int id;
  final String icon;
  final String title;
  final List<SafetyAdvice> advices;

  SafetyGuide({
    required this.id,
    required this.icon,
    required this.title,
    required this.advices,
  });

  factory SafetyGuide.fromJson(Map<String, dynamic> json) {
    var advicesJson = json['advices'] as List<dynamic>? ?? [];
    return SafetyGuide(
      id: json['id'],
      icon: json['icon'] ?? '',
      title: json['title'] ?? '',
      advices: advicesJson.map((a) => SafetyAdvice.fromJson(a)).toList(),
    );
  }
}
