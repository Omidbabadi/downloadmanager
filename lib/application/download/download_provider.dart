import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/download/data/core/providers.dart';

import '../../features/download/domain/usecases/start_download.dart';
import 'download_notifier.dart';
import 'download_state.dart';

final startDownloadUseCaseProvider = Provider<StartDownloadUseCase>((ref) {
  final remote = ref.watch(downloadRemoteDatasourceProvider);
  return StartDownloadUseCase(remote);
});

final downloadNotifierProvider =
    StateNotifierProvider<DownloadNotifier, DownloadState>((ref) {
      final usecase = ref.watch(startDownloadUseCaseProvider);
      return DownloadNotifier(usecase);
    });
