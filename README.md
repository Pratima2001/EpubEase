# EpubEase

EpubEase is a Flutter package that allows users to open and read EPUB files easily. It provides features like opening EPUB files from assets or URLs, changing themes, adjusting font styles and sizes, accessing chapter contents, and more.

## Features

- Open EPUB files from assets or URLs
- Change themes with 5 options: Grey, Purple, White, Black, and Pink
- Customize font style and size
- Access table of contents and navigate to specific chapters
- Display current chapter name at the bottom of the screen
- Previous and next buttons to switch between chapters
- Adjust screen brightness




## Getting Started #

In your flutter project add the dependency:

   ```yaml
   dependencies:
     epubease: ^1.0.0
   ```  

Run the command:

   ```yaml
   flutter pub get
   ```    
For more information, check out the [documentation](https://flutter.dev/).
   
## Usage example
Import the package in your Dart code:

   ```yaml
   import 'package:epub_ease/epub_ease.dart';
   ```  
To open an EPUB file from the assets, use the openAsset method:

   ```yaml
   EpubEase().openAsset('path_to_asset.epub', context);
   ```  
To open an EPUB file from a URL, use the open method:

   ```yaml
  EpubEase().open('epub_url', context);
   ```  




