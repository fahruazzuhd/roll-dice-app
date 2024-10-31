import 'dart:math';

import 'package:flutter/material.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> with SingleTickerProviderStateMixin {
  var currentDiceRoll = 1;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    // Inisialisasi AnimationController dan Animation di sini
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Pastikan Tween diinisialisasi setelah _controller dibuat
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic
      ),
    );
  }

  void rollDice() {
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1;
      _controller.forward(from: 0); // Reset dan mulai animasi
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,
              child: Image.asset(
                'assets/images/dice-$currentDiceRoll.png',
                width: 200,
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: rollDice, 
          child: const Text(
            'Roll Dice', 
            style: TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }
}
