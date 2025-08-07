import 'dart:io';
import 'package:flutter_media_store/flutter_media_store.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../domain/entities/download_task.dart';

class DownloadRemoteDatasource {
  final Dio dio;
  DownloadRemoteDatasource({Dio? dio}) : dio = dio ?? Dio();

  Stream<DownloadTask> startDownload(String url, String fileName) async* {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      debugPrint('Permission Denied');
      return;
    }
    debugPrint('start download started @ download remote datasource');
    final flutterMediaStorePlugin = FlutterMediaStore();
    final id = const Uuid().v4();
    debugPrint('download id: $id');
    int downloadedBytes = 0;
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    debugPrint("Path: $tempDir/$fileName");

    yield DownloadTask(
      id: id,
      url: url,
      fileName: fileName,
      progress: 0,
      downloadedBytes: 0,
      status: DownloadStatus.downloading,
    );

    try {
      final response = await dio.download(
        url,
        file.path,
        onReceiveProgress: (received, total) {
          downloadedBytes = received;
        },
        deleteOnError: true,
      );
      if (response.statusCode == 200) {
        final bytes = await file.readAsBytes();
        final mime = lookupMimeType(fileName) ?? 'application/octet-stream';
        await flutterMediaStorePlugin.saveFile(
          fileData: bytes,
          folderName: "myDownloader",
          rootFolderName: "Download",
          fileName: fileName,
          mimeType: mime,
          onSuccess: (uri, filePath) {
            debugPrint('File Saved Succsessfully: $uri : $filePath');
          },
          onError: (error) {
            debugPrint('Failed To Save: $error');
          },
        );

        yield DownloadTask(
          id: id,
          url: url,
          fileName: fileName,
          progress: 1,
          downloadedBytes: downloadedBytes,
          status: DownloadStatus.completed,
        );
      } else {
        debugPrint('Download Failed');
        throw Exception('Download Failed');
      }
    } catch (e) {
      yield DownloadTask(
        id: id,
        url: url,
        fileName: fileName,
        progress: 0,
        downloadedBytes: downloadedBytes,
        status: DownloadStatus.failed,
      );
    }
  }
}
