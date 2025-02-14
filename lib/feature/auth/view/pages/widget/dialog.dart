import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_weather_ai/core/botton/custom_botton.dart';
import 'package:flutter_weather_ai/core/color/color.dart';
import 'package:flutter_weather_ai/feature/auth/view/pages/signin.dart';

class CustomCelebrationDialog extends StatefulWidget {
  final String fullName;
  const CustomCelebrationDialog({Key? key, required this.fullName})
      : super(key: key);

  @override
  _CustomCelebrationDialogState createState() =>
      _CustomCelebrationDialogState();
}

class _CustomCelebrationDialogState extends State<CustomCelebrationDialog>
    with TickerProviderStateMixin {
  List<AnimationController> _controllers = [];
  List<Animation<double>> _animations = [];
  final double _fallDuration = 9.0; // Duration of fall animation in seconds
  List<Widget> _celebrationScraps = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _generateCelebrationScraps();
  }

  void _generateCelebrationScraps() {
    final random = Random();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    for (int i = 0; i < 70; i++) {
      int imageIndex = random.nextInt(4) + 1;
      double size;
      Widget scrap;

      switch (imageIndex) {
        case 1: // Blue Circle
          size = random.nextDouble() * 10;
          scrap = Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          );
          break;

        case 2:
          size = random.nextDouble() * 10 + 5;
          scrap = CustomPaint(
            size: Size(size, size),
            painter: TrianglePainter(),
          );
          break;

        case 3:
        case 4:
          size = imageIndex == 3
              ? random.nextDouble() * 7 + 15
              : random.nextDouble() * 10 + 20;
          scrap = Image.asset(
            'assets/scarab/scrap$imageIndex.png',
            width: size,
            height: size,
            fit: BoxFit.contain,
          );
          break;

        default:
          size = random.nextDouble() * 5 + 5;
          scrap = Container();
      }

      double rotation = random.nextDouble() * 2 * pi;
      double left = random.nextDouble() * 0.75;
      double top = -random.nextDouble() * screenHeight;

      AnimationController controller = AnimationController(
        duration: Duration(seconds: _fallDuration.toInt()),
        vsync: this,
      );

      Animation<double> animation = Tween<double>(
        begin: top,
        end: screenHeight,
      ).animate(
        CurvedAnimation(parent: controller, curve: Curves.linear),
      );

      controller.forward();

      _controllers.add(controller);
      _animations.add(animation);

      _celebrationScraps.add(
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Positioned(
              left: left * screenWidth,
              top: animation.value,
              child: Transform.rotate(angle: rotation, child: scrap),
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.all(0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.60,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Stack(
                  children: _celebrationScraps,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Congratulations!",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                            fontFamily: 'Inter'),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.fullName,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary),
                      ),
                      Spacer(),
                      ReusableButton(
                        text: 'SIGN IN',
                        height: 50,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInView()),
                            (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.yellow;
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

showCustomCelebrationDialog(BuildContext context, String fullName) {
  showDialog(
    context: Navigator.of(context, rootNavigator: true).overlay!.context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.1),
    builder: (_) => CustomCelebrationDialog(
      fullName: fullName,
    ),
  );
}
