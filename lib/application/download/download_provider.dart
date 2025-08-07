import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/application/download/download_state.dart';
import 'package:myapp/features/download/data/core/providers.dart';
import 'download_notifier.dart';

final downloadNotifierProvider = StateNotifierProvider<DownloadNotifier, DownloadState>((ref) {
  final startDownloadUseCase = ref.watch(startDownloadUseCaseProvider);
  final pauseDownloadUseCase = ref.watch(pauseDownloadUseCaseProvider);
  final resumeDownloadUseCase = ref.watch(resumeDownloadUseCaseProvider);
  final cancelDownloadUseCase = ref.watch(cancelDownloadeUseCaseProvider);
  final getAllDownloadsUseCase = ref.watch(getAllDownloadsprovider);
  return DownloadNotifier(
        startDownloadUseCase,
        pauseDownloadUseCase,
        resumeDownloadUseCase,
        cancelDownloadUseCase,
        getAllDownloadsUseCase,
  );
});
