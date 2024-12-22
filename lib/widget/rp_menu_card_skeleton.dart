import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RPMenuCardSkeleton extends StatelessWidget {
  const RPMenuCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: Colors.grey[300]!,
          width: 1.0,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[200]!,
            child: Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4.0),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    width: 150,
                    height: 16.0,
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 10.0),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    width: 100,
                    height: 14.0,
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 10.0),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    width: 80,
                    height: 14.0,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
