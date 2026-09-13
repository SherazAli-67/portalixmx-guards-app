import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageCompressionHelper {
  /// Compresses a single image file
  /// Returns the compressed file path, or null if compression fails
  static Future<File?> compressImage(File imageFile, {int maxWidth = 1920, int quality = 85}) async {
    try {
      // Read image to get dimensions for proper resizing
      final imageBytes = await imageFile.readAsBytes();
      final codec = await ui.instantiateImageCodec(imageBytes);
      final frame = await codec.getNextFrame();
      final originalWidth = frame.image.width;
      final originalHeight = frame.image.height;
      frame.image.dispose();
      
      // Calculate target dimensions maintaining aspect ratio
      int targetWidth = originalWidth;
      int targetHeight = originalHeight;
      
      if (originalWidth > maxWidth) {
        final ratio = maxWidth / originalWidth;
        targetWidth = maxWidth;
        targetHeight = (originalHeight * ratio).round();
      }
      
      final targetPath = await _getTargetPath(imageFile.path);
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        targetPath,
        minWidth: targetWidth,
        minHeight: targetHeight,
        quality: quality,
        format: CompressFormat.jpeg,
      );
      
      if (compressedFile != null) {
        return File(compressedFile.path);
      }
      return null;
    } catch (e) {
      // If compression fails, return null
      return null;
    }
  }

  /// Compresses multiple image files
  /// Returns a list of compressed files (skips files that fail to compress)
  static Future<List<File>> compressImages(List<File> imageFiles, {int maxWidth = 1920, int quality = 85}) async {
    List<File> compressedFiles = [];
    
    for (var imageFile in imageFiles) {
      final compressed = await compressImage(imageFile, maxWidth: maxWidth, quality: quality);
      if (compressed != null) {
        compressedFiles.add(compressed);
      } else {
        // If compression fails, use original file as fallback
        compressedFiles.add(imageFile);
      }
    }
    
    return compressedFiles;
  }

  /// Gets the target path for compressed image
  static Future<String> _getTargetPath(String originalPath) async {
    final directory = await getTemporaryDirectory();
    final fileName = path.basenameWithoutExtension(originalPath);
    final extension = path.extension(originalPath);
    return '${directory.path}/${fileName}_compressed$extension';
  }
}
