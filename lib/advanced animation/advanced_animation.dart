import 'package:flutter/material.dart';

class AdvancedAnimation extends StatefulWidget {
  const AdvancedAnimation({super.key});

  @override
  State<AdvancedAnimation> createState() => _AdvancedAnimationState();
}

class _AdvancedAnimationState extends State<AdvancedAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _opacityAnimations;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Create animations for 3 dots with sequential delays
    _scaleAnimations = List.generate(3, (index) {
      final startTime = index * 0.2; // 200ms delay between each dot
      final endTime = startTime + 0.4; // 400ms animation duration

      return Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(startTime, endTime, curve: Curves.easeInOut),
        ),
      );
    });

    _opacityAnimations = List.generate(3, (index) {
      final startTime = index * 0.2;
      final endTime = startTime + 0.4;

      return Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(startTime, endTime, curve: Curves.easeInOut),
        ),
      );
    });

    // Start the animation and loop it
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Loading Animation'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dots animation
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Transform.scale(
                          scale: _scaleAnimations[index].value,
                          child: Opacity(
                            opacity: _opacityAnimations[index].value,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Loading text
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
