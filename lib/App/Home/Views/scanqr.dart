import 'package:noblepay/App/widgets/appbar.dart';
import 'package:noblepay/App/widgets/gradienttext.dart';
import 'package:noblepay/App/widgets/pagewrapper.dart';
import 'package:noblepay/App/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';




class Scanqr extends StatefulWidget {
  const Scanqr({super.key});

  @override
  State<Scanqr> createState() => _ScanqrState();
}

class _ScanqrState extends State<Scanqr> {
  String? scannedResult;
  bool isScanning = false;
  final MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _startScanner() {
    setState(() {
      isScanning = true;
      scannedResult = null;
    });
  }

  void _stopScanner() {
    setState(() {
      isScanning = false;
      cameraController.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   title: "Scan Qrcode",
      //   onBack: () {
      //     if (isScanning) {
      //       _stopScanner(); 
      //     } else {
      //       Navigator.pop(context);
      //     }
      //   },
      //   onCaution: () {},
      // ),
      body: Center(
        child: isScanning
            ? Column(
                children: [
                  const SizedBox(height: 20),
      
                  // ✅ Scanner view
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: MobileScanner(
                        controller: cameraController,
                        onDetect: (barcodeCapture) {
                          final barcodes = barcodeCapture.barcodes;
                          if (barcodes.isNotEmpty) {
                            setState(() {
                              scannedResult =
                                  barcodes.first.rawValue ?? "No data";
                              isScanning = false; // Close scanner after success
                            });
                          }
                        },
                      ),
                    ),
                  ),
      
                  const SizedBox(height: 20),
      
                  // ✅ Flash & Camera switch buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.flash_on, size: 30),
                        onPressed: () => cameraController.toggleTorch(),
                      ),
                      const SizedBox(width: 40),
                      IconButton(
                        icon: const Icon(Icons.cameraswitch, size: 30),
                        onPressed: () => cameraController.switchCamera(),
                      ),
                    ],
                  ),
      
                  const SizedBox(height: 20),
      
                  TextButton(
                    onPressed: _stopScanner,
                    child: const CustomText(title: "Cancel")
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 120),
      
                    SvgPicture.asset(
                      "assets/svg/icons/qr.svg",
                      color: Colors.black,
                      width: 150,
                      height: 150,
                    ),
      
                    const SizedBox(height: 40),
      
                   
                    GestureDetector(
                      onTap: _startScanner,
                      child: const GradientText(text: "Scan to Pay"),
                    ),
      
                    const SizedBox(height: 20),
      
                    if (scannedResult != null)
                      Text(
                        "Scanned Result: $scannedResult",
                        style: const TextStyle(fontSize: 16),
                      ),
      
                    const SizedBox(height: 280),
      
                    SvgPicture.asset(
                      "assets/svg/logo.svg",
                      width: 15,
                      height: 15,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}