import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(home: CreateAnnouncementSMPost()));

class CreateAnnouncementSMPost extends StatefulWidget {
  CreateAnnouncementSMPost({Key? key}) : super(key: key);

  @override
  State<CreateAnnouncementSMPost> createState() =>
      _CreateAnnouncementSMPostState();
}

class _CreateAnnouncementSMPostState extends State<CreateAnnouncementSMPost> {
  TextEditingController _textController = TextEditingController();
  Color _textColor = Colors.black; // Default text color
  bool _isItalic = false;
  bool _isBold = false;
  bool _hasShadow = false;
  double _blur = 0.0;
  img.Image? _backgroundImage;

  int _highlightStart = 0;
  int _highlightEnd = 0;

  // Color Picker Function
  void changeColor(Color color) {
    setState(() {
      _textColor = color;
    });
  }

  // Save Image Function
  Future<void> _saveImage() async {
    // Apply Blur Effect
    img.Image blurredImage = _applyBlurEffect(_backgroundImage!);

    // Parse text and apply styles based on the highlighted range
    String text = _textController.text;

    // Create a TextSpan with different styles for the highlighted portion
    TextSpan textSpan = TextSpan(
      style: TextStyle(
        color: _textColor,
        fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
        fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
        shadows: _hasShadow ? [Shadow(blurRadius: 4, color: Colors.black)] : null,
      ),
      children: <TextSpan>[
        TextSpan(text: text.substring(0, _highlightStart)), // Text before the highlighted portion
        TextSpan(
          text: text.substring(_highlightStart, _highlightEnd), // Highlighted portion
          style: TextStyle(
            // Apply styles specific to the highlighted portion
            color: Colors.green, // Example: Green color for the highlighted text
            fontStyle: FontStyle.normal,
          ),
        ),
        TextSpan(text: text.substring(_highlightEnd)), // Text after the highlighted portion
      ],
    );

    // Create a TextPainter to layout the TextSpan
    TextPainter textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Layout the TextPainter
    textPainter.layout(maxWidth: blurredImage.width.toDouble());

    // Draw the text on the image with the specified styles
    textPainter.paint(blurredImage as Canvas, Offset(50, 400));

    // Save Image to File
    final tempDir = await getTemporaryDirectory();
    final File imageFile = File('${tempDir.path}/announcement_image.png');
    imageFile.writeAsBytesSync(img.encodePng(blurredImage));

    // Share the created image
    Share.file('Announcement', 'announcement_image.png', img.encodePng(blurredImage).buffer.asUint8List(), 'image/png');
  }

  // Blurs the image
  img.Image _applyBlurEffect(img.Image image) {
    int radius = 5; // Set the blur radius based on your requirement
    if (radius <= 0) {
      return image;
    }
    // Apply blur effect using the image package's gaussianBlur function
    return img.gaussianBlur(image, radius: radius);
  }

  @override
  void initState() {
    super.initState();
    // Load the background image
    rootBundle.load('assets/cpfc_logo.jpeg').then((data) {
      final bytes = data.buffer.asUint8List();
      _backgroundImage = img.decodeImage(Uint8List.fromList(bytes));
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.openSans(
      color: _textColor,
      fontSize: 40,
      fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
      fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
      shadows: _hasShadow ? [Shadow(blurRadius: 4, color: Colors.black)] : null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Announcement'),
      ),
      body: Stack(
        children: [
          // Background Image
          if (_backgroundImage != null) Image.memory(Uint8List.fromList(img.encodePng(_backgroundImage!)), fit: BoxFit.cover),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text Input Field with Color Picker Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Pick a color'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: _textColor,
                                    onColorChanged: changeColor,
                                    showLabel: true,
                                    pickerAreaHeightPercent: 0.8,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Pick Color'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Enter your announcement text',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(),
                          ),
                          textAlign: TextAlign.center,
                          style: textStyle,
                          onChanged: (selection) {
                            setState(() {
                              _highlightStart = selection.length;
                              _highlightEnd = selection.length;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Toggle Buttons for Italic, Bold, and Shadow
                ToggleButtons(
                  children: [
                    Icon(Icons.format_italic),
                    Icon(Icons.format_bold),
                    Icon(Icons.photo_filter),
                  ],
                  isSelected: [_isItalic, _isBold, _hasShadow],
                  onPressed: (index) {
                    setState(() {
                      if (index == 0) {
                        _isItalic = !_isItalic;
                      } else if (index == 1) {
                        _isBold = !_isBold;
                      } else if (index == 2) {
                        _hasShadow = !_hasShadow;
                      }
                    });
                  },
                ),
                // Slider for Blur Effect
                Slider(
                  value: _blur,
                  min: 0,
                  max: 20,
                  onChanged: (value) {
                    setState(() {
                      _blur = value;
                    });
                  },
                ),
              ],
            ),
          ),

          // Save Button
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                _saveImage();
              },
              child: Text('Save and Share'),
            ),
          ),
        ],
      ),
    );
  }
}
