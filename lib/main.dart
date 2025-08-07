import 'package:dio/dio.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';
import 'package:myapp/features/download/presentation/pages/download_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(ProviderScope(child: const MainScreen()));
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DownloadPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double progress = 0.0;
  Future<void> download({
    required String fileUrl,
    required String fileName,
    required String folderName,
  }) async {
    try {
      final photos = await Permission.photos.request();
      if (!photos.isGranted) {
        debugPrint("Permission Denied");
        return;
      }
      final response = await Dio().get<List<int>>(
        fileUrl,
        options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              debugPrint(progress.toString());
              progress = received / total;
            });
          }
        },
      );
      if (response.data == null) {
        debugPrint('data in null');
        return;
      }
      final bytes = Uint8List.fromList(response.data!);
      final result = await MethodChannel(
        'media_store_channel',
      ).invokeMethod("saveFileToDownloads", {
        'bytes': bytes,
        'fileName': fileName,
        'mimeType': lookupMimeType(fileName) ?? 'application/octet-stream',
        'folder': folderName,
      });
      debugPrint(result);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      debugPrint(e.toString());
    }
  }

  Future<void> startDownload() async {
    debugPrint('start download method started');
    try {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        debugPrint('permission denied');
      }
      ;
      final dir = await getExternalStorageDirectory();
      final savePath = "${dir!.path}/test_file.zip";
      final url = 'https://speed.hetzner.de/100MB.bin';
      final dio = Dio();

      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              progress = received / total;
            });
          }
        },
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: const Text('download completed')));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).toStringAsFixed(0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('downloader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$percentage%'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                download(
                  fileUrl: "https://hel1-speed.hetzner.com/100MB.bin",
                  fileName: "test_file.bin",
                  folderName: 'MyDownloader',
                );
              },
              child: const Text('start download'),
            ),
          ],
        ),
      ),
    );
  }
}
