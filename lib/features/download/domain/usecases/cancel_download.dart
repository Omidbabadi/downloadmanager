import '../repositories/download_repository.dart';

class CancelDownloadUseCase {
  final DownloadRepository repository;
  CancelDownloadUseCase(this.repository);

  Future<void> call(String taskId) {
    return repository.cancelDownload(taskId);
  }
}
