import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noblepay/App/widgets/constants/const.dart';

class ApiService {
  final String _baseUrl = Constants.baseUrl;

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
}
