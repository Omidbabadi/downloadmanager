
import '../repositories/download_repository.dart';
import '../entities/download_task.dart';

class GetAllDownloadsUseCase {
  final DownloadRepository repository;
  GetAllDownloadsUseCase(this.repository);

  Future<List<DownloadTask>> call() {
    return repository.getAllDownloads();
  }
}
