import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:kiuqi/app.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:kiuqi/providers/user_details_provider.dart';
import 'package:provider/provider.dart';

class CelebrationScreen extends StatefulWidget {
  const CelebrationScreen({Key? key}) : super(key: key);

  @override
  State<CelebrationScreen> createState() => _CelebrationScreenState();
}

class _CelebrationScreenState extends State<CelebrationScreen> {
  late ConfettiController _controller;
  late final AudioCache _audioCache;
  bool _buttonVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 10));
    _controller.play();
    AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    _audioCache = AudioCache(
      prefix: 'assets/sounds/',
      fixedPlayer: audioPlayer,
    );

    _audioCache.play('success.wav');
    Future.delayed(const Duration(milliseconds: 3500), (){
      setState(() {
        _buttonVisible = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _controller,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: true,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
            createParticlePath: drawStar,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 130,
                  width: 130,
                  child: Image(
                    image: AssetImage(ImageLinks.PROFILE_COMPLETE),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "You've Completed Your Profile!",
                  style: BaseStyles.primaryBlackLargeTitleTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                Text(
                  "You've completed your profile. Now you are ready to start finding your perfect cofounder.",
                  style: BaseStyles.blackSubtitleTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 90,
          child: Visibility(
            visible: _buttonVisible,
            child: ElevatedButton(
              onPressed: () {
            
                context.read<UserDetailsProvider>().disposeValues();
                Navigator.of(navigatorKey.currentContext!)
                  .pushReplacementNamed('/discover');
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(12),
                shadowColor:
                    MaterialStateProperty.all<Color>(AppColor.primaryColor),
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColor.primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                    side: const BorderSide(
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      size: 22,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
