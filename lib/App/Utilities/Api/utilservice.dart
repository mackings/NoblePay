import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:noblepay/App/widgets/constants/const.dart';

class UtilApiService {
  final String _baseUrl = Constants.baseUrl;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> purchaseAirtime({
    required double amount,
    required String currency,
    required String recipientPhone,
    required String senderPhone,
    required String countryIso,
    bool useLocalAmount = true,
    Map<String, dynamic>? metadata,
  }) async {
    final url = Uri.parse("$_baseUrl/AirtimeRecharge");

    final payload = {
      "amount": amount,
      "currency": currency,
      "recipientPhone": recipientPhone,
      "senderPhone": senderPhone,
      "countryIso": "US",
     // "countryIso": countryIso,
      "useLocalAmount": useLocalAmount,
      "metadata": metadata,
    };

    try {
      print("🔹 PurchaseAirtime API Call");
      print("➡️ URL: $url");
      print("📦 Payload: ${jsonEncode(payload)}");

      // ✅ Retrieve token from secure storage
      final token = await _secureStorage.read(key: "accessToken");

      if (token == null) {
        return {
          "isSuccess": false,
          "message": "Authentication required. Please login again.",
          "data": null,
        };
      }

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
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
      print("❌ PurchaseAirtime failed: $e");
      return {
        "isSuccess": false,
        "message": "PurchaseAirtime request failed: $e",
        "data": null,
      };
    }
  }

  /// Get Airtime Transaction Status
  Future<Map<String, dynamic>> getAirtimeTransactionStatus(
    String transactionId,
  ) async {
    final url = Uri.parse("$_baseUrl/Airtime/transaction/$transactionId");

    try {
      print("🔹 GetAirtimeTransactionStatus API Call");
      print("➡️ URL: $url");

      final token = await _secureStorage.read(key: "accessToken");

      if (token == null) {
        return {
          "isSuccess": false,
          "message": "Authentication required. Please login again.",
          "data": null,
        };
      }

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
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
      print("❌ GetAirtimeTransactionStatus failed: $e");
      return {
        "isSuccess": false,
        "message": "GetAirtimeTransactionStatus request failed: $e",
        "data": null,
      };
    }
  }
}