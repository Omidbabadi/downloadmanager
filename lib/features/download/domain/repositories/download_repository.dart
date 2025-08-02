import '../entities/download_task.dart';

abstract class DownloadRepository {
  Stream<DownloadTask> startDownload(String url, String fileName);
  Future<void> pauseDownload(String taskId);
  Future<void> resumeDownload(String taskId);
  Future<void> cancelDownload(String taskId);
  Future<List<DownloadTask>> getAllDownloads();
}
