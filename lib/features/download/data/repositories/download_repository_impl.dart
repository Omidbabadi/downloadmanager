import '../../domain/repositories/download_repository.dart';
import '../datasources/download_remote_datasources.dart';
import '../../domain/entities/download_task.dart';

class DownloadRepositoryImpl implements DownloadRepository {
  final DownloadRemoteDatasource remoteDatasource;

  DownloadRepositoryImpl(this.remoteDatasource);

  @override
  Stream<DownloadTask> startDownload(String url, String fileName) {
    return remoteDatasource.startDownload(url, fileName);
  }

  @override
  Future<void> pauseDownload(String taskId) async {
    throw UnimplementedError();
  }

  @override
  Future<void> resumeDownload(String taskId) async {
    throw UnimplementedError();
  }

  @override
  Future<void> cancelDownload(String taskId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<DownloadTask>> getAllDownloads() async {
    throw UnimplementedError();
  }
}
