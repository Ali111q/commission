import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

extension ImageCompression on File {
  Future<File?> compressImage({
    int minWidth = 800,
    int minHeight = 800,
    int quality = 80,
  }) async {
    // Check if file exists
    if (!await exists()) {
      print("File does not exist");
      return null;
    }

    // Load the image bytes
    final imageBytes = await readAsBytes();

    // Compress the image
    final compressedBytes = await FlutterImageCompress.compressWithList(
      imageBytes,
      minWidth: minWidth,
      minHeight: minHeight,
      quality: quality,
    );

    if (compressedBytes == null) {
      print("Compression failed");
      return null;
    }

    // Create a new file with compressed image data
    final compressedFile =
        File(path.replaceFirst(RegExp(r'\.\w+$'), '_compressed.jpg'));
    await compressedFile.writeAsBytes(compressedBytes);

    return compressedFile;
  }
}

Future<List<File?>> compressImages(List<ImageData> images) async {
  final List<Future<File?>> compressionTasks = images.map((imageData) async {
    final file = File(imageData.path);
    return await file.compressImage();
  }).toList();

  // Await all the compression tasks to complete
  final List<File?> compressedFiles = await Future.wait(compressionTasks);

  return compressedFiles;
}

// Define your ImageData class if not already defined
class ImageData {
  final String path;
  ImageData(this.path);
}
