import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:portalixmx_guards_app/features/main_menu/visitors/guest_verified_page.dart';
import 'package:portalixmx_guards_app/res/app_colors.dart';
import 'package:portalixmx_guards_app/res/app_icons.dart';

import '../../../res/app_textstyles.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> with WidgetsBindingObserver {
  late MobileScannerController cameraController;
  bool _isScanning = false;
  StreamSubscription? _scanSubscription;
  Timer? _instructionTimer;
  bool _showInstruction = false;

  bool _isControllerInitialized = false;
  double _zoomFactor = 0.0;

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
    _startInstructionTimer();
  }

  Future<void> _initializeCamera() async {
    try {
      await cameraController.start();
      if (mounted) {
        setState(() => _isControllerInitialized = true);
        _startScanning();
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
    _startScanning();
  }

  void _disposeController() {
    _stopScanning();
    _instructionTimer?.cancel();
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

  void _startInstructionTimer() {
    _instructionTimer?.cancel();
    _instructionTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => _showInstruction = true);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposeController();
    super.dispose();
  }

  void _startScanning() {
    if (_isScanning) return;
    _isScanning = true;
    _scanSubscription = cameraController.barcodes.listen((capture) {
      if (capture.barcodes.isNotEmpty) {
        debugPrint('Barcode: ${ capture.barcodes.first.displayValue}');
        _foundBarcode(capture.barcodes.first);
      }
    });
  }

  void _stopScanning() {
    if (!_isScanning) return;
    _isScanning = false;
    _scanSubscription?.cancel();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // 1. Camera Scanner at the bottom
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              setState(() => _showInstruction = false);
              _startInstructionTimer();
              if (capture.barcodes.isNotEmpty) {
                _foundBarcode(capture.barcodes.first);
              }
            },
          ),



          // 3. UI elements on top without opacity
          Padding(
            padding: const EdgeInsets.only(top: 65.0),
            child: Column(
              children: [
                // Top section with trial banner
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      GestureDetector(
                        // onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> const PremiumPage())),
                        child: Container(
                          // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: const Alignment(-1.0, 0.0), // Maps x1, y1 from SVG
                                        end: const Alignment(1.0, 0.0), // Maps x2, y2 from SVG
                                        colors: [
                                          const Color(0xFF1877F2), // First color stop
                                          const Color(0x9494C2FF).withValues(alpha: 0.6), // Second color stop with 60% opacity
                                        ],
                                      ),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          topRight: Radius.circular(18),
                                          bottomRight: Radius.circular(18))),
                                  child: SvgPicture.asset(AppIcons.icLogsOut)
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    "Trial Not claimed",
                                    style: const TextStyle(fontSize: 14, color: Color(0xff48484A), fontWeight: FontWeight.w400,),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle Pro button tap
                                    // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> const PremiumPage()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    backgroundColor: AppColors.primaryColor,
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                  ),
                                  child: Text("Pro", style: AppTextStyles.btnTextStyle.copyWith(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


                      // Show scanning instruction after 5s of no detection
                      if (_showInstruction) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0x00000000)..withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:  Text(
                            "Instructions",
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Add Spacer to push controls to bottom
                const Spacer(),


                // Zoom slider with improved handling
                Container(
                  padding: const EdgeInsets.only(bottom: 32),
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Minus icon
                      IconButton(
                        icon: const Icon(Icons.remove_rounded,
                            color: Colors.white, size: 30),
                        onPressed: () {
                          final newZoom = (_zoomFactor - 0.1).clamp(0.0, 1.0);
                          setState(() {
                            _zoomFactor = newZoom;
                            cameraController.setZoomScale(newZoom);
                          });
                        },
                      ),

                      // Slider
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: cameraController,
                          builder: (context, state, child) {
                            if (!_isControllerInitialized) {
                              return const SizedBox.shrink();
                            }

                            return SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 5,
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: const Color(0xffA4A7AE),
                                thumbColor: Colors.white,
                                overlayColor:
                                Colors.white..withValues(alpha: 0.2),
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6,
                                ),
                                overlayShape:
                                const RoundSliderOverlayShape(
                                  overlayRadius: 12,
                                ),
                              ),
                              child: Slider(
                                value: _zoomFactor,
                                min: 0.0,
                                max: 1.0,
                                onChanged: (value) {
                                  setState(() {
                                    _zoomFactor = value;
                                    cameraController
                                        .setZoomScale(value);
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      // Plus icon
                      GestureDetector(
                        child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
                        onTap: () {
                          final newZoom = (_zoomFactor + 0.1).clamp(0.0, 1.0);
                          setState(() {
                            _zoomFactor = newZoom;
                            cameraController.setZoomScale(newZoom);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _foundBarcode(Barcode barcode) async {
    if (!_isScanning) return; // Ignore if we're not supposed to be scanning

    _stopScanning();
/*    if(_appSettingsService.vibrationEnabled){
      await HapticFeedback.vibrate();
    }
    if(_appSettingsService.soundEnabled){
      playAudio();
    }
    if(_appSettingsService.autoCopyEnabled){
      Clipboard.setData(ClipboardData(text: barcode.displayValue ?? ''));
      Fluttertoast.showToast(msg: 'Text Copied to Clipboard');
    }*/

    _saveAndGoToResultScreen(barcode);

  }


  void _saveAndGoToResultScreen(Barcode barcode) {
    debugPrint("Type: ${barcode.type}, DisplayValue: ${barcode.displayValue}, RawValue: ${barcode.rawValue}");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GuestVerifiedPage()),
      ).then((_) {
        _startScanning();
      });
    }

}
