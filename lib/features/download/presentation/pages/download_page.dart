import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/application/download/download_provider.dart';

class DownloadPage extends ConsumerWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(downloadNotifierProvider);
    final notifier = ref.read(downloadNotifierProvider.notifier);
    final controller = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: 'Paste Download Link'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final url = controller.text.trim();

                if (url.isNotEmpty) {
                  final fileName = Uri.parse(url).pathSegments.last;
                  notifier.startDownload(url, fileName);
                }
              },
              child: const Text('Start Download'),
            ),
          ],
        ),
      ),
    );
  }
}
