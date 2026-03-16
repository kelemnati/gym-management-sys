import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../attendance/presentation/bloc/attendance_bloc.dart';
import '../../../attendance/presentation/bloc/attendance_event.dart';
import '../../../attendance/domain/entities/attendance.dart';
import '../../../payments/presentation/bloc/payment_bloc.dart';
import '../../../payments/presentation/bloc/payment_event.dart';
import '../../../payments/presentation/bloc/payment_state.dart';

class QrCheckInPage extends StatefulWidget {
  const QrCheckInPage({super.key});

  @override
  State<QrCheckInPage> createState() => _QrCheckInPageState();
}

class _QrCheckInPageState extends State<QrCheckInPage>
    with SingleTickerProviderStateMixin {
  final MobileScannerController _controller = MobileScannerController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  String? scannedCode;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _processScan(String? code) {
    if (_isProcessing) return;
    if (code == null || code.isEmpty) return;

    setState(() {
      scannedCode = code;
      _isProcessing = true;
    });

    _processCheckIn(code);
  }

  Future<void> _processCheckIn(String qrCode) async {
    // Assume QR contains memberId:classId
    final parts = qrCode.split(':');
    if (parts.length != 2) {
      _showErrorSnackBar('Invalid QR code format');
      setState(() => _isProcessing = false);
      return;
    }

    final memberId = parts[0];
    final classId = parts[1];

    // First, check payment status
    context.read<PaymentBloc>().add(LoadPaymentsByMember(memberId));

    // Listen for payment state changes
    final paymentBloc = context.read<PaymentBloc>();
    final subscription = paymentBloc.stream.listen((state) {
      if (state is PaymentLoaded) {
        _handlePaymentCheck(state.payments, memberId, classId);
      } else if (state is PaymentError) {
        _showErrorSnackBar('Error checking payment status: ${state.message}');
        setState(() => _isProcessing = false);
      }
    });

    // Clean up subscription after a delay
    Future.delayed(const Duration(seconds: 3), () {
      subscription.cancel();
      if (_isProcessing) {
        _showErrorSnackBar('Payment check timeout');
        setState(() => _isProcessing = false);
      }
    });
  }

  void _handlePaymentCheck(
      List<dynamic> payments, String memberId, String classId) {
    // Check if member has any active (paid) payments
    final hasActivePayment =
        payments.any((payment) => payment.status == 'paid');

    if (!hasActivePayment) {
      _showErrorSnackBar('Access denied: Membership payment required');
      setState(() => _isProcessing = false);
      return;
    }

    // Payment is active, proceed with attendance
    final attendance = Attendance(
      id: DateTime.now().toString(),
      memberId: memberId,
      classId: classId,
      date: DateTime.now(),
      status: 'present',
    );

    context.read<AttendanceBloc>().add(MarkAttendanceEvent(attendance));

    _showSuccessSnackBar('Checked in member $memberId for class $classId');

    // Reset processing flag after successful check-in
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isProcessing = false);
    });
  }

  void _showSuccessSnackBar(String message) {
    // We'll rely on the UI state update, but you can keep the snackbar or replace it with a nice dialog
    // For now, let's keep it subtle but styled
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [
        const Icon(Icons.check_circle, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(child: Text(message)),
      ]),
      backgroundColor: Colors.green.shade700,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [
        const Icon(Icons.error_outline, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(child: Text(message)),
      ]),
      backgroundColor: Theme.of(context).colorScheme.error,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final scanWindowSize = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('QR Check-In',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 1. Full Screen Scanner
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isEmpty) return;
              _processScan(barcodes.first.rawValue);
            },
          ),

          // 2. Dark Overlay with Cutout
          CustomPaint(
            painter: ScannerOverlayPainter(
              borderColor: Theme.of(context).colorScheme.primary,
              borderRadius: 20,
              borderLength: 40,
              borderWidth: 8,
              cutOutSize: scanWindowSize,
            ),
            child: Container(),
          ),

          // 3. Animated Scanning Line
          if (!_isProcessing)
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: scanWindowSize,
                height: scanWindowSize,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        Positioned(
                          top: _animation.value * (scanWindowSize - 10),
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

          // 4. Processing Indicator (Centered in scan area)
          if (_isProcessing)
            Align(
              alignment: Alignment.center,
              child: Container(
                width: scanWindowSize,
                height: scanWindowSize,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      'Verifying...',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

          // 5. Bottom Status Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isProcessing
                        ? 'Verifying payment and checking in...'
                        : scannedCode ?? 'Scan a QR code to check in',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: _isProcessing
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (!_isProcessing)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code_scanner,
                            size: 16,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                        const SizedBox(width: 8),
                        Text(
                          'Align code within the frame',
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  final Color borderColor;
  final double borderRadius;
  final double borderLength;
  final double borderWidth;
  final double cutOutSize;

  ScannerOverlayPainter({
    required this.borderColor,
    required this.borderRadius,
    required this.borderLength,
    required this.borderWidth,
    required this.cutOutSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double halfSize = cutOutSize / 2;

    // 1. Draw dark background with cutout
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final cutoutPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset(centerX, centerY),
            width: cutOutSize,
            height: cutOutSize),
        Radius.circular(borderRadius),
      ));

    final backgroundPaint = Paint()..color = Colors.black.withOpacity(0.6);

    canvas.drawPath(
      Path.combine(PathOperation.difference, backgroundPath, cutoutPath),
      backgroundPaint,
    );

    // 2. Draw Corner Borders
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;

    // Top Left
    canvas.drawPath(
        Path()
          ..moveTo(centerX - halfSize, centerY - halfSize + borderLength)
          ..lineTo(centerX - halfSize, centerY - halfSize)
          ..lineTo(centerX - halfSize + borderLength, centerY - halfSize),
        borderPaint);

    // Top Right
    canvas.drawPath(
        Path()
          ..moveTo(centerX + halfSize - borderLength, centerY - halfSize)
          ..lineTo(centerX + halfSize, centerY - halfSize)
          ..lineTo(centerX + halfSize, centerY - halfSize + borderLength),
        borderPaint);

    // Bottom Right
    canvas.drawPath(
        Path()
          ..moveTo(centerX + halfSize, centerY + halfSize - borderLength)
          ..lineTo(centerX + halfSize, centerY + halfSize)
          ..lineTo(centerX + halfSize - borderLength, centerY + halfSize),
        borderPaint);

    // Bottom Left
    canvas.drawPath(
        Path()
          ..moveTo(centerX - halfSize + borderLength, centerY + halfSize)
          ..lineTo(centerX - halfSize, centerY + halfSize)
          ..lineTo(centerX - halfSize, centerY + halfSize - borderLength),
        borderPaint);
  }

  @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
