import 'package:meals/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  final Meal meal;

  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouriteMealsProvider);
    final isFavorite = favouriteMeals.contains(meal);
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                final wasAdded = ref
                    .read(favouriteMealsProvider.notifier)
                    .toggleFavoriteStatus(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(wasAdded
                        ? 'Meal added to favorites!'
                        : 'Meal removed from favorites!'),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
              ),
              const SizedBox(height: 16),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              const SizedBox(height: 16),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              for (final step in meal.steps)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(
                    textAlign: TextAlign.center,
                    step,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
            ],
          ),
        ));
  }
}
