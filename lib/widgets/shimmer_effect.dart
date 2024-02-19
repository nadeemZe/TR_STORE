import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffects {

  static final Color _shimmerColor = Colors.grey[200]!;
  static final Color _shimmerColorDark = Colors.grey[500]!;

  static loadShimmer({required BuildContext context}) {
    return Shimmer.fromColors(
      baseColor: _shimmerColor,
      highlightColor: _shimmerColorDark,
      child: ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 171,
            width: 200,
            margin: const EdgeInsets.only(left: 12.0, right: 12.0,bottom:20.0 ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              color: Colors.white70,
            ),
          );
        },
      ),
    );
  }


}


