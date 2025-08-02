import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/download/domain/entities/download_task.dart';
import 'download_state.dart';
import '../../features/download/domain/usecases/start_download.dart';

class DownloadNotifier extends StateNotifier<DownloadState> {
  final StartDownloadUseCase startDownloadUseCase;
  final Map<String, StreamSubscription<DownloadTask>> _subscriptions = {};

  DownloadNotifier(this.startDownloadUseCase) : super(DownloadState(tasks: []));

  Future<void> startDownload(String url, String fileName) async {
    final stream = startDownloadUseCase(url, fileName);
    final subscription = stream.listen((task) {
      final existingIndex = state.tasks.indexWhere((t) => t.id == task.id);
      final updatedTasks = [...state.tasks];
      if (existingIndex != -1) {
        updatedTasks[existingIndex] = task;
      } else {
        updatedTasks.add(task);
      }
      state = state.copyWith(tasks: updatedTasks);
    });
    _subscriptions[url] = subscription;
  }

  void cancelDownload(String id) {
    final subscription = _subscriptions[id];
    if (subscription != null) {
      subscription.cancel();
      _subscriptions.remove(id);
      final updatedTasks = state.tasks.where((task) => task.id != id).toList();
      state = state.copyWith(tasks: updatedTasks);
    }
  }

  @override
  void dispose() {
    for (var sub in _subscriptions.values) {
      sub.cancel();
    }
    super.dispose();
  }
}
