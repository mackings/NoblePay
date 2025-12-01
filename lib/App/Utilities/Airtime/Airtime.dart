import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:noblepay/App/Utilities/Airtime/contacts.dart';
import 'package:noblepay/App/Utilities/Airtime/payment.dart';
import 'package:noblepay/App/widgets/button.dart';
import '../Api/utilservice.dart';


class RechargeScreen extends StatefulWidget {
  final String? selectedContactName;
  final String? selectedContactPhone;

  const RechargeScreen({
    Key? key,
    this.selectedContactName,
    this.selectedContactPhone,
  }) : super(key: key);

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final UtilApiService _apiService = UtilApiService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  String selectedTab = 'Recharge'; // 'Recharge' or 'Plans'
  double selectedAmount = 40.00;
  bool isLoading = false;
  
  String? userPhone;
  String? recipientPhone;
  String? recipientName;

  final List<double> quickAmounts = [5.00, 10.00, 20.00, 30.00, 40.00, 50.00];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    userPhone = await _secureStorage.read(key: "phoneNumber");
    
    setState(() {
      recipientPhone = widget.selectedContactPhone;
      recipientName = widget.selectedContactName;
    });
  }

  void _selectAmount(double amount) {
    setState(() {
      selectedAmount = amount;
    });
  }

  void _incrementAmount() {
    setState(() {
      selectedAmount += 1;
    });
  }

  void _decrementAmount() {
    if (selectedAmount > 1) {
      setState(() {
        selectedAmount -= 1;
      });
    }
  }

  Future<void> _handleRecharge() async {
    if (recipientPhone == null || userPhone == null) {
      _showErrorDialog("Please select a contact and ensure you're logged in");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final result = await _apiService.purchaseAirtime(
        amount: selectedAmount,
        currency: "USD",
        recipientPhone: recipientPhone!,
        senderPhone: userPhone!,
        countryIso: "NG", // Update based on your country
        useLocalAmount: true,
      );

      if (result["isSuccess"] == true) {
        final data = result["data"];
        
        if (data["requiresAction"] == true && data["redirectUrl"] != null) {
          // Launch in-app browser
          await _launchInAppBrowser(
            data["redirectUrl"],
            data["transactionId"],
          );
        } else {
          _showSuccessDialog("Recharge completed successfully!");
        }
      } else {
        _showErrorDialog(result["message"] ?? "Recharge failed");
      }
    } catch (e) {
      _showErrorDialog("An error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _selectContact() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ContactsScreen(),
      ),
    );

    // If contact was selected from ContactsScreen, it would navigate
    // directly to a new RechargeScreen instance with the contact
    // So we don't need to handle the result here
  }

  Future<void> _launchInAppBrowser(String url, String transactionId) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentWebView(
          url: url,
          transactionId: transactionId,
        ),
      ),
    );

    if (result == true) {
      _showSuccessDialog("Payment completed successfully!");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Success"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Return to previous screen
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Recharge',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 30),

            // Selected Contact or Select Button
            recipientName != null && recipientPhone != null
                ? Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'NoblePay',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipientName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                recipientPhone!,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: _selectContact,
                          icon: const Icon(Icons.edit, color: Colors.orange),
                        ),
                      ],
                    ),
                  )
                : InkWell(
                    onTap: _selectContact,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_add_outlined,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Select contact',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(height: 30),

            // Set Amount
            const Text(
              'Set Amount',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'How much you would like to transfer?',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Amount Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _decrementAmount,
                  icon: const Icon(Icons.remove_circle, color: Colors.red, size: 32),
                ),
                const SizedBox(width: 20),
                Text(
                  '\$${selectedAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: _incrementAmount,
                  icon: const Icon(Icons.add_circle, color: Colors.red, size: 32),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Quick Amount Options
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: quickAmounts.map((amount) {
                final isSelected = selectedAmount == amount;
                return InkWell(
                  onTap: () => _selectAmount(amount),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : Colors.white,
                      border: Border.all(
                        color: isSelected ? Colors.red : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '\$${amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),

CustomButton(
  text: isLoading ? "Please wait..." : "Confirmation",
  onPressed: isLoading ? () {} : _handleRecharge,
  width: double.infinity,
  height: 56,
  borderRadius: 12,
  outlined: false,
)

          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, IconData icon) {
    final isSelected = selectedTab == title;
    return InkWell(
      onTap: () {
        setState(() {
          selectedTab = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}