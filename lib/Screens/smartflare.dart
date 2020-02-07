import 'package:flutter/material.dart';
import 'package:smart_flare/smart_flare.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Container(
        child: Align(
          alignment: Alignment.centerRight,
          child: PanFlareActor(
            width: 135.0,
            height: screenSize.height,
            filename: 'assets/slideout-menu.flr',
            openAnimation: 'open',
            closeAnimation: 'close',
            direction: ActorAdvancingDirection.LeftToRight,
            threshold: 20.0,
            reverseOnRelease:
            true, // reverse's current animation when released and threshold not reaced
            completeOnThresholdReached:
            false, // plays the animation till the end when we reach threshold
            activeAreas: [
              RelativePanArea(
                  area: Rect.fromLTWH(0, 0.7, 1.0, 0.3), debugArea: true)
            ],
          ),
        ),
      ),
    );
  }
}