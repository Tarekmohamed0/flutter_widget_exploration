import 'package:flutter/material.dart';
import 'package:flutter_widget_exploration/dragabble/model/color_ball.dart';

class Dragabble extends StatefulWidget {
  const Dragabble({super.key});

  @override
  State<Dragabble> createState() => _DragabbleState();
}

class _DragabbleState extends State<Dragabble> with TickerProviderStateMixin {
  late AnimationController _successController;

  List<Color> targetColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
  ];

  String feedback = '';
  int matchedCount = 0;

  @override
  void initState() {
    super.initState();
    _successController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _successController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Color Match'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header with progress
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Drag ColorBall.balls to matching',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$matchedCount/${ColorBall.balls.length}',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Draggable ColorBall.balls section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Drag from here',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: ColorBall.balls
                          .map((ball) => _buildDraggableBall(ball))
                          .toList(),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Drop targets section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Drop here',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: targetColors
                          .map((color) => _buildDropTarget(color))
                          .toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Feedback message
              if (feedback.isNotEmpty)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: feedback.contains('Correct')
                        ? Colors.green[50]
                        : Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: feedback.contains('Correct')
                          ? Colors.green
                          : Colors.red,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    feedback,
                    style: TextStyle(
                      color: feedback.contains('Correct')
                          ? Colors.green[700]
                          : Colors.red[700],
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableBall(ColorBall ball) {
    if (ball.isMatched) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey[300]!, width: 2),
        ),
        child: Icon(Icons.check, color: Colors.grey[500], size: 24),
      );
    }

    return Draggable<ColorBall>(
      data: ball,
      feedback: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ball.color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
      ),
      childWhenDragging: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ball.color.withOpacity(0.3),
          border: Border.all(color: ball.color.withOpacity(0.5), width: 2),
        ),
      ),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ball.color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropTarget(Color targetColor) {
    final isMatched = ColorBall.balls.any(
      (ball) => ball.color == targetColor && ball.isMatched,
    );

    return DragTarget<ColorBall>(
      onAcceptWithDetails: (details) {
        _handleDrop(details.data, targetColor, true);
      },
      onWillAcceptWithDetails: (ball) {
        return ball.data.color == targetColor && !ball.data.isMatched;
      },
      builder: (context, candidateData, rejectedData) {
        final isHighlighted = candidateData.isNotEmpty;

        return AnimatedScale(
          scale: isHighlighted ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isMatched ? targetColor : targetColor.withOpacity(0.2),
              border: Border.all(
                color: isHighlighted
                    ? targetColor
                    : targetColor.withOpacity(0.5),
                width: isHighlighted ? 3 : 2,
              ),
              boxShadow: [
                if (isHighlighted)
                  BoxShadow(
                    color: targetColor.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
              ],
            ),
            child: isMatched
                ? const Icon(Icons.check_circle, color: Colors.white, size: 30)
                : null,
          ),
        );
      },
    );
  }

  void _handleDrop(ColorBall ball, Color targetColor, bool isCorrect) {
    setState(() {
      if (isCorrect) {
        ball.isMatched = true;
        matchedCount++;
        feedback = 'Correct! ${ball.name} matches!';
        _successController.forward().then((_) {
          _successController.reverse();
        });
      } else {
        feedback = 'Try again! ${ball.name} doesn\'t match here.';
      }
    });

    // Clear feedback after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          feedback = '';
        });
      }
    });

    // Check if all ColorBall.balls are matched
    if (matchedCount == ColorBall.balls.length) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _showCompletionDialog();
        }
      });
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.celebration, color: Colors.amber, size: 28),
            SizedBox(width: 8),
            Text('Congratulations!'),
          ],
        ),
        content: const Text('You matched all the colors correctly!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetGame();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    setState(() {
      for (var ball in ColorBall.balls) {
        ball.isMatched = false;
      }
      matchedCount = 0;
      feedback = '';
    });
  }
}
