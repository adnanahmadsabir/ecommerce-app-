import 'package:clothes_app/ui/providers/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRatingBar extends StatelessWidget {
  const MyRatingBar({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Selector<ItemProvider, double>(
        selector: (_, provider) => provider.rating,
        builder: (_, rating, __) {
          return Row(
              mainAxisSize: MainAxisSize.min,
              children: List<Widget>.generate(5, (index) {
                double currentRating = index + 1.0;
                final isActive = rating >= currentRating;
                return GestureDetector(
                    onTap: () =>
                        context.read<ItemProvider>().setRating(currentRating),
                    child: Icon(
                      isActive ? Icons.star : Icons.star_border,
                      color: isActive ? Colors.amber : Colors.grey,
                    ));
              }));
        });
  }
}
