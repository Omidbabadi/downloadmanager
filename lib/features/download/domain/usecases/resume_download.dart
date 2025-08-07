import '../repositories/download_repository.dart';

class ResumeDownloadUseCase {
  final DownloadRepository repository;
  ResumeDownloadUseCase(this.repository);
  Future<void> call(String taskId) {
    return repository.resumeDownload(taskId);
  }
}
