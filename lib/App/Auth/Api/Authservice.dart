import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noblepay/App/widgets/constants/const.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String _baseUrl = Constants.baseUrl;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  /// Register a new customer
  Future<Map<String, dynamic>> registerCustomer(
    Map<String, dynamic> payload,
  ) async {
    final url = Uri.parse("$_baseUrl/Auth/register/customer");

    try {
      print("🔹 RegisterCustomer API Call");
      print("➡️ URL: $url");
      print("📦 Payload: ${jsonEncode(payload)}");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(payload),
      );

      print("⬅️ Status Code: ${response.statusCode}");
      print("📩 Response Body: ${response.body}");

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded["isSuccess"] == true)
        return decoded;

      if (decoded["errors"] != null) {
        final errors = decoded["errors"] as Map<String, dynamic>;
        final errorMessages = errors.entries
            .map((e) => "${e.key}: ${(e.value as List).join(", ")}")
            .join("\n");
        return {"isSuccess": false, "message": errorMessages, "data": null};
      }

      if (decoded["message"] != null)
        return {
          "isSuccess": false,
          "message": decoded["message"],
          "data": null,
        };

      return {
        "isSuccess": false,
        "message": "Unexpected server error (${response.statusCode})",
        "data": null,
      };
    } catch (e) {
      print("❌ Request failed: $e");
      return {
        "isSuccess": false,
        "message": "Request failed: $e",
        "data": null,
      };
    }
  }

  /// Login a customer
  Future<Map<String, dynamic>> loginCustomer(
    String emailOrUsername,
    String password,
  ) async {
    final url = Uri.parse("$_baseUrl/Auth/login/customer");

    final payload = {"email": emailOrUsername, "password": password};

    try {
      print("🔹 LoginCustomer API Call");
      print("➡️ URL: $url");
      print("📦 Payload: ${jsonEncode(payload)}");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(payload),
      );

      print("⬅️ Status Code: ${response.statusCode}");
      print("📩 Response Body: ${response.body}");

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded["isSuccess"] == true)
        return decoded;

      if (decoded["errors"] != null) {
        final errors = decoded["errors"] as Map<String, dynamic>;
        final errorMessages = errors.entries
            .map((e) => "${e.key}: ${(e.value as List).join(", ")}")
            .join("\n");
        return {"isSuccess": false, "message": errorMessages, "data": null};
      }

      if (decoded["message"] != null)
        return {
          "isSuccess": false,
          "message": decoded["message"],
          "data": null,
        };

      return {
        "isSuccess": false,
        "message": "Unexpected server error (${response.statusCode})",
        "data": null,
      };
    } catch (e) {
      print("❌ Request failed: $e");
      return {
        "isSuccess": false,
        "message": "Request failed: $e",
        "data": null,
      };
    }
  }

  /// Verify registration (OTP)
  Future<Map<String, dynamic>> verifyRegistration({
    String? email,
    String? phoneNumber,
    required String otp,
  }) async {
    final url = Uri.parse("$_baseUrl/Auth/verify/registration");

    final payload = {
      if (email != null) "email": email,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      "otp": otp,
    };

    try {
      print("🔹 VerifyRegistration API Call");
      print("➡️ URL: $url");
      print("📦 Payload: ${jsonEncode(payload)}");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(payload),
      );

      print("⬅️ Status Code: ${response.statusCode}");
      print("📩 Response Body: ${response.body}");

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded["isSuccess"] == true)
        return decoded;

      if (decoded["errors"] != null) {
        final errors = decoded["errors"] as Map<String, dynamic>;
        final errorMessages = errors.entries
            .map((e) => "${e.key}: ${(e.value as List).join(", ")}")
            .join("\n");
        return {"isSuccess": false, "message": errorMessages, "data": null};
      }

      if (decoded["message"] != null)
        return {
          "isSuccess": false,
          "message": decoded["message"],
          "data": null,
        };

      return {
        "isSuccess": false,
        "message": "Unexpected server error (${response.statusCode})",
        "data": null,
      };
    } catch (e) {
      print("❌ Request failed: $e");
      return {
        "isSuccess": false,
        "message": "Request failed: $e",
        "data": null,
      };
    }
  }

  /// Resend verification email
  Future<Map<String, dynamic>> resendVerificationEmail(
    String email, {
    int verificationType = 0,
  }) async {
    final url = Uri.parse("$_baseUrl/Auth/resend/email");

    final payload = {"email": email, "verificationType": verificationType};

    try {
      print("🔹 ResendVerificationEmail API Call");
      print("➡️ URL: $url");
      print("📦 Payload: ${jsonEncode(payload)}");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(payload),
      );

      print("⬅️ Status Code: ${response.statusCode}");
      print("📩 Response Body: ${response.body}");

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded["isSuccess"] == true) {
        return decoded;
      }

      if (decoded["errors"] != null) {
        final errors = decoded["errors"] as Map<String, dynamic>;
        final errorMessages = errors.entries
            .map((e) => "${e.key}: ${(e.value as List).join(", ")}")
            .join("\n");
        return {"isSuccess": false, "message": errorMessages, "data": null};
      }

      if (decoded["message"] != null) {
        return {
          "isSuccess": false,
          "message": decoded["message"],
          "data": null,
        };
      }

      return {
        "isSuccess": false,
        "message": "Unexpected server error (${response.statusCode})",
        "data": null,
      };
    } catch (e) {
      print("❌ Request failed: $e");
      return {
        "isSuccess": false,
        "message": "Request failed: $e",
        "data": null,
      };
    }
  }

  /// Verify login with OTP
  Future<Map<String, dynamic>> verifyLogin({
    String? email,
    String? phoneNumber,
    required String otp,
  }) async {
    final url = Uri.parse("$_baseUrl/Auth/verify/login");

    final payload = {
      if (email != null) "email": email,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      "otp": otp,
    };

    try {
      print("🔹 VerifyLogin API Call");
      print("➡️ URL: $url");
      print("📦 Payload: ${jsonEncode(payload)}");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(payload),
      );

      print("⬅️ Status Code: ${response.statusCode}");
      print("📩 Response Body: ${response.body}");

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded["isSuccess"] == true) {
        final data = decoded["data"];

        // ✅ Save to secure storage
        if (data != null) {
          await _secureStorage.write(key: "username", value: data["userName"]);
          await _secureStorage.write(key: "userId", value: data["userId"]);
          await _secureStorage.write(key: "email", value: data["email"]);
          await _secureStorage.write(
            key: "phoneNumber",
            value: data["phoneNumber"],
          );
          await _secureStorage.write(
            key: "accessToken",
            value: data["accessToken"],
          );
          await _secureStorage.write(
            key: "refreshToken",
            value: data["refreshToken"],
          );
          await _secureStorage.write(key: "expires", value: data["expires"]);
          await _secureStorage.write(
            key: "refreshTokenExpiresAt",
            value: data["refreshTokenExpiresAt"],
          );
        }

        return decoded;
      }

      if (decoded["errors"] != null) {
        final errors = decoded["errors"] as Map<String, dynamic>;
        final errorMessages = errors.entries
            .map((e) => "${e.key}: ${(e.value as List).join(", ")}")
            .join("\n");
        return {"isSuccess": false, "message": errorMessages, "data": null};
      }

      if (decoded["message"] != null) {
        return {
          "isSuccess": false,
          "message": decoded["message"],
          "data": null,
        };
      }

      return {
        "isSuccess": false,
        "message": "Unexpected server error (${response.statusCode})",
        "data": null,
      };
    } catch (e) {
      print("❌ VerifyLogin failed: $e");
      return {
        "isSuccess": false,
        "message": "VerifyLogin request failed: $e",
        "data": null,
      };
    }
  }

  /// Forgot Password
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final url = Uri.parse("$_baseUrl/Auth/forgot-password");

    final payload = {"email": email};

    try {
      print("🔹 ForgotPassword API Call");
      print("➡️ URL: $url");
      print("📦 Payload: ${jsonEncode(payload)}");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization":
              "Bearer YOUR_SECRET_TOKEN", // 🔑 Replace with real token
        },
        body: jsonEncode(payload),
      );

      print("⬅️ Status Code: ${response.statusCode}");
      print("📩 Response Body: ${response.body}");

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded["isSuccess"] == true) {
        return decoded;
      }

      if (decoded["errors"] != null) {
        final errors = decoded["errors"] as Map<String, dynamic>;
        final errorMessages = errors.entries
            .map((e) => "${e.key}: ${(e.value as List).join(", ")}")
            .join("\n");
        return {"isSuccess": false, "message": errorMessages, "data": null};
      }

      if (decoded["message"] != null) {
        return {
          "isSuccess": false,
          "message": decoded["message"],
          "data": null,
        };
      }

      return {
        "isSuccess": false,
        "message": "Unexpected server error (${response.statusCode})",
        "data": null,
      };
    } catch (e) {
      print("❌ ForgotPassword failed: $e");
      return {
        "isSuccess": false,
        "message": "ForgotPassword request failed: $e",
        "data": null,
      };
    }
  }

  /// Reset Password
  Future<Map<String, dynamic>> resetPassword({
    required String userId, // UUID in the URL
    required String passwordResetCode,
    required String newPassword,
  }) async {
    final url = Uri.parse("$_baseUrl/Auth/reset-password/$userId");

    final payload = {
      "passwordResetCode": passwordResetCode,
      "newPassword": newPassword,
    };

    try {
      print("🔹 ResetPassword API Call");
      print("➡️ URL: $url");
      print("📦 Payload: ${jsonEncode(payload)}");

      // ✅ Retrieve token from secure storage
      final token = await _secureStorage.read(key: "accessToken");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode(payload),
      );

      print("⬅️ Status Code: ${response.statusCode}");
      print("📩 Response Body: ${response.body}");

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded["isSuccess"] == true) {
        return decoded;
      }

      if (decoded["errors"] != null) {
        final errors = decoded["errors"] as Map<String, dynamic>;
        final errorMessages = errors.entries
            .map((e) => "${e.key}: ${(e.value as List).join(", ")}")
            .join("\n");
        return {"isSuccess": false, "message": errorMessages, "data": null};
      }

      if (decoded["message"] != null) {
        return {
          "isSuccess": false,
          "message": decoded["message"],
          "data": null,
        };
      }

      return {
        "isSuccess": false,
        "message": "Unexpected server error (${response.statusCode})",
        "data": null,
      };
    } catch (e) {
      print("❌ ResetPassword failed: $e");
      return {
        "isSuccess": false,
        "message": "ResetPassword request failed: $e",
        "data": null,
      };
    }
  }
}
