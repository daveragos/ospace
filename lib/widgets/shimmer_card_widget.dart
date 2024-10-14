import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNewsCard extends StatelessWidget {
  const ShimmerNewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Shimmer(
              gradient: LinearGradient(colors: [
                Colors.grey.shade400,
                Colors.grey.shade500,
                Colors.grey,
                Colors.grey.shade600,
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 20),

            // Wrap the Column in Flexible to prevent overflow
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: Shimmer(
                      gradient: LinearGradient(colors: [
                        Colors.grey.shade400,
                        Colors.grey.shade500,
                        Colors.grey,
                        Colors.grey.shade600,
                      ]),
                      child: Container(
                        color: Colors.white,
                        width: double.infinity, // Let it fill the available space
                        height: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ClipRRect(
                    child: Shimmer(
                      gradient: LinearGradient(colors: [
                        Colors.grey.shade400,
                        Colors.grey.shade500,
                        Colors.grey,
                        Colors.grey.shade600,
                      ]),
                      child: Container(
                        color: Colors.white,
                        width: double.infinity, // Let it fill the available space
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
