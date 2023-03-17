import 'package:eppo/controller/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Current Location'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ref.watch(locationControllerProvider).when(
                  data: (location) {
                    if (location != null) {
                      return Text(
                        'Latitude: ${location.latitude}',
                        style: TextStyle(fontSize: 24),
                      );
                    }
                    return Container();
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                ),
          ],
        ));
  }
}
