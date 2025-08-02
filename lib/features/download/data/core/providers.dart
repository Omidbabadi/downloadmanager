import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/download/data/repositories/download_repository_impl.dart';
import 'package:myapp/features/download/domain/repositories/download_repository.dart';
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





