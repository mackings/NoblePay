import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:noblepay/App/Utilities/Airtime/Airtime.dart';
import 'package:noblepay/App/Utilities/Airtime/contacts.dart';

class ReloadScreen extends StatefulWidget {
  const ReloadScreen({Key? key}) : super(key: key);

  @override
  State<ReloadScreen> createState() => _ReloadScreenState();
}

class _ReloadScreenState extends State<ReloadScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final TextEditingController _phoneController = TextEditingController();
  
  String selectedCountryCode = '+231';
  List<RecentRecharge> recentRecharges = [];
  bool isLoading = true;

  final List<String> countryCodes = [
    '+231', // Liberia
    '+234', // Nigeria
    '+1',   // USA
    '+44',  // UK
  ];

  @override
  void initState() {
    super.initState();
    _loadRecentRecharges();
  }

  Future<void> _loadRecentRecharges() async {
    // TODO: Load from API or local storage
    // Mock data for now
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      recentRecharges = [
        RecentRecharge(
          name: 'Tiana Saris',
          phone: '+231-7915447397',
          date: '18 Jul 2022',
          avatar: 'assets/avatars/tiana.png',
        ),
        RecentRecharge(
          name: 'Gabrielle Rese',
          phone: '+231-7915447397',
          date: '18 Jul 2022',
          avatar: 'assets/avatars/gabrielle.png',
        ),
        RecentRecharge(
          name: 'Tiana Saris',
          phone: '+231-7915447397',
          date: '18 Jul 2022',
          avatar: 'assets/avatars/tiana2.png',
        ),
        RecentRecharge(
          name: 'Safaron Tony',
          phone: '+231-7915447397',
          date: '18 Jul 2022',
          avatar: 'assets/avatars/safaron.png',
        ),
      ];
      isLoading = false;
    });
  }

  void _navigateToRecharge({String? name, String? phone}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RechargeScreen(
          selectedContactName: name,
          selectedContactPhone: phone,
        ),
      ),
    );
  }

  void _navigateToContacts() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ContactsScreen(),
      ),
    );
  }

  void _handleManualEntry() {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a phone number")),
      );
      return;
    }

    final fullPhone = selectedCountryCode + _phoneController.text;
    _navigateToRecharge(phone: fullPhone);
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
            // Phone Number Input
            const Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                // Country Code Dropdown
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCountryCode,
                      icon: const Icon(Icons.arrow_drop_down, size: 20),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedCountryCode = newValue;
                          });
                        }
                      },
                      items: countryCodes.map((String code) {
                        return DropdownMenuItem<String>(
                          value: code,
                          child: Text(
                            code,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Phone Number Input
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter phone number...',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Contacts Button
                InkWell(
                  onTap: _navigateToContacts,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.contacts_outlined,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Recent Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to see all recent recharges
                  },
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Recent Recharges List
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    )
                  : recentRecharges.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.history,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No recent recharges',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: recentRecharges.length,
                          itemBuilder: (context, index) {
                            final recharge = recentRecharges[index];
                            return ListTile(
                              onTap: () => _navigateToRecharge(
                                name: recharge.name,
                                phone: recharge.phone,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 0,
                              ),
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundColor: _getAvatarColor(index),
                                child: Text(
                                  recharge.name[0],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              title: Text(
                                'Send to ${recharge.name}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                'Last Recharge sent ${recharge.date}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                            );
                          },
                        ),
            ),

            const SizedBox(height: 20),

            // Next Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _handleManualEntry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAvatarColor(int index) {
    final colors = [
      Colors.orange,
      Colors.blue,
      Colors.purple,
      Colors.pink,
      Colors.green,
    ];
    return colors[index % colors.length];
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}

// Model class for recent recharges
class RecentRecharge {
  final String name;
  final String phone;
  final String date;
  final String avatar;

  RecentRecharge({
    required this.name,
    required this.phone,
    required this.date,
    required this.avatar,
  });
}