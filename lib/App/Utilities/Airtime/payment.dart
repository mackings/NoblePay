import 'package:flutter/material.dart';
import 'package:noblepay/App/Utilities/Api/utilservice.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String url;
  final String transactionId;

  const PaymentWebView({
    Key? key,
    required this.url,
    required this.transactionId,
  }) : super(key: key);

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;
  bool isLoading = true;
  final UtilApiService _apiService = UtilApiService();

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
            });
            _checkPaymentStatus(url);
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (request) {
            // Handle navigation and check for success/failure URLs
            _checkPaymentStatus(request.url);
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _checkPaymentStatus(String currentUrl) async {
    // Check if the URL indicates payment completion
    if (currentUrl.contains('success') || 
        currentUrl.contains('payment_intent') ||
        currentUrl.contains('complete')) {
      
      // Verify transaction status with backend
      final result = await _apiService.getAirtimeTransactionStatus(
        widget.transactionId,
      );

      if (result["isSuccess"] == true) {
        final status = result["data"]["status"];
        
        if (status == "Completed" || status == "Success") {
          // Payment successful
          Navigator.pop(context, true);
        } else if (status == "Failed" || status == "Cancelled") {
          // Payment failed
          _showPaymentFailedDialog();
        }
      }
    } else if (currentUrl.contains('cancel') || currentUrl.contains('failed')) {
      _showPaymentFailedDialog();
    }
  }

  void _showPaymentFailedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Payment Failed"),
        content: const Text("Your payment was not completed. Please try again."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context, false); // Close webview
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Payment'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Cancel Payment?"),
                content: const Text(
                  "Are you sure you want to cancel this payment?",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context, false); // Close webview
                    },
                    child: const Text(
                      "Yes, Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}