import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RPBalasanCardSkeleton extends StatelessWidget {
  const RPBalasanCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          Row(
            children: [
              ClipOval(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 16.0,
                      width: 120.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 14.0,
                      width: 80.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 24.0,
              width: 200.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 16.0,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 16.0,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 16.0,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerRight,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 24.0,
                width: 100.0,
                color: Colors.white,
              ),
            ),
          ),
          const Divider(),
          const SizedBox(height: 4.0),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 16.0,
              width: 120.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
