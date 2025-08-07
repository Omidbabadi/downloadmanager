import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/download_repository_impl.dart';
import '../../domain/repositories/download_repository.dart';
import '../../domain/usecases/cancel_download.dart';
import '../../domain/usecases/get_all_downloads.dart';
import '../../domain/usecases/pause_download.dart';
import '../../domain/usecases/resume_download.dart';
import '../../domain/usecases/start_download.dart';
import '../datasources/download_remote_datasources.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final downloadRemoteDatasourceProvider = Provider<DownloadRemoteDatasource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return DownloadRemoteDatasource(dio: dio);
});

final downloadRepositoryProvider = Provider<DownloadRepository>((ref) {
  final remote = ref.watch(downloadRemoteDatasourceProvider);
  return DownloadRepositoryImpl(remote);
});

final startDownloadUseCaseProvider = Provider<StartDownloadUseCase>((ref) {
  final repository = ref.watch(downloadRepositoryProvider);
  return StartDownloadUseCase(repository);
});

final pauseDownloadUseCaseProvider = Provider<PauseDownloadUseCase>((ref) {
  final repository = ref.watch(downloadRepositoryProvider);
  return PauseDownloadUseCase(repository);
});

final resumeDownloadUseCaseProvider = Provider<ResumeDownloadUseCase>(
  (ref) {
    final repository = ref.watch(downloadRepositoryProvider);
    return ResumeDownloadUseCase(repository);
  },
);

final cancelDownloadeUseCaseProvider = Provider<CancelDownloadUseCase>(
  (ref) {
    final repository = ref.watch(downloadRepositoryProvider);
    return CancelDownloadUseCase(repository);
  },
);
 
 final getAllDownloadsprovider = Provider<GetAllDownloadsUseCase>((ref) {
  final repository = ref.watch(downloadRepositoryProvider);
  return GetAllDownloadsUseCase(repository);
});

