import 'package:flutter/material.dart';
import 'wave_clipper.dart';

class WelcomeWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Map<String, dynamic>> buttons;

  const WelcomeWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    double waveHeight = MediaQuery.of(context).size.height * 0.4;

    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: waveHeight,
              color: const Color(0xFF98BD89),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: MediaQuery.of(context).size.height * 0.2,
                        fit: BoxFit.contain,
                        color: const Color(0xFF98BD89),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...buttons.map(
                      (b) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ElevatedButton(
                          onPressed: b['onPressed'],
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(
                            b['text'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
