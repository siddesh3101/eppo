import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../movie_provider.dart';

class TrendingListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie List'),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final movieListAsyncValue = ref.watch(movieListProvider);

          return movieListAsyncValue.when(
            data: (movies) {
              return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return ListTile(
                    title: Text(movie.title),
                    subtitle: Text('${movie.year} - ${movie.director}'),
                  );
                },
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Text('Error: $error'),
          );
        },
      ),
    );
  }
}
