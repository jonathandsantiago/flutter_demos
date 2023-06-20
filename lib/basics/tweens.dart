// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class TweenDemo extends StatefulWidget {
  const TweenDemo({super.key});
  static const String routeName = 'basics/tweens';

  @override
  State<TweenDemo> createState() => _TweenDemoState();
}

class _TweenDemoState extends State<TweenDemo>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(seconds: 1);
  static const double accountBalance = 1000000;
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: _duration)
      ..addListener(() {
        // Marks the widget tree as dirty
        setState(() {});
      });
    animation = Tween(begin: 0.0, end: accountBalance).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tweens'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Text('\$${animation.value.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24)),
            ),
            ElevatedButton(
              child: Text(getStatus(controller)),
              onPressed: () {
                switch (controller.status) {
                  case AnimationStatus.completed:
                    controller.reverse();
                    break;
                  default:
                    controller.forward();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  String getStatus(controller) {
    switch (controller.status) {
      case AnimationStatus.completed:
        return 'Buy a Mansion';
      case AnimationStatus.forward:
        return 'Accruing...';
      case AnimationStatus.reverse:
        return 'Spending...';
      default:
        return 'Win the lottery';
    }
  }
}
