import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:portalixmx_guards_app/features/main_menu/visitors/guest_verified_page.dart';
import 'package:portalixmx_guards_app/widgets/bg_gradient_screen.dart';
import '../../../res/app_textstyles.dart';
import '../../../widgets/primary_btn.dart';

class ScanQRCodePage extends StatefulWidget{
  const ScanQRCodePage({super.key});

  @override
  State<ScanQRCodePage> createState() => _ScanQRCodePageState();
}

class _ScanQRCodePageState extends State<ScanQRCodePage> with WidgetsBindingObserver{
  late MobileScannerController cameraController;
  bool _isControllerInitialized = false;
  bool _hasScanned = false; // Add this to your state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeController();
  }

  // Separate controller initialization
  void _initializeController() async{
    cameraController = MobileScannerController(
      facing: CameraFacing.back,
      torchEnabled: false,
      detectionSpeed: DetectionSpeed.normal,
    );
    await _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      await cameraController.start();
      if (mounted) {
        setState(() => _isControllerInitialized = true);
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        _reinitializeController();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _disposeController();
        break;
      default:
        break;
    }
  }

  // Add method to handle hot reload
  void _reinitializeController() {
    _disposeController();
    _initializeController();
  }

  void _disposeController() {
    if (_isControllerInitialized) {
      cameraController.dispose();
      _isControllerInitialized = false;
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    _reinitializeController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposeController();
    super.dispose();
  }

  void _foundQRCode(Barcode barcode) async {
    if (_hasScanned) return;
    _hasScanned = true;
    debugPrint("Barcode found:  ${barcode.displayValue}");
    _disposeController();

    if (barcode.format == BarcodeFormat.qrCode) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GuestVerifiedPage(barcode: barcode,)),
      );
      _hasScanned = false;
      _initializeController(); // restart scanner after returning
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BgGradientScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Padding(padding: EdgeInsets.only(top: 65),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(color: Colors.white,),
                Text("Scan QR Code", style: AppTextStyles.regularTextStyle,),
                const SizedBox(width: 40,)
                // IconButton(onPressed: ()=> _showEditBottomSheet(context), icon: Icon(Icons.more_vert_rounded, color: Colors.white,))
              ],
            ),
          ),

          Expanded(child: Card(
            margin: EdgeInsets.zero,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 27),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 60,
                children: [
                  Text("Scanning will start automatically", style: AppTextStyles.regularTextStyle.copyWith(color: Color(0xff596774), fontWeight: FontWeight.w400),),
                  SizedBox(
                    height: size.height*0.4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:  // 1. Camera Scanner at the bottom
                      MobileScanner(
                        controller: cameraController,
                        onDetect: (capture) {
                          if (!_hasScanned && capture.barcodes.isNotEmpty) {
                            _foundQRCode(capture.barcodes.first);
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: PrimaryBtn(onTap: (){
                      // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> VisitorAddedSummaryPage()));
                    }, btnText: "Submit"),
                  )
                ],
              ),
            ),
          ))


        ],
      ),
    );
  }
}

