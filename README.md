
# Wordy Client

This game consists of finding a common name (A2 level) chosen at random each day, all in a minimum of tries! The similarity index tells you if you are on the right track!
This repositery contains the client part of Wordy made with the Flutter framework and Dart.


## Screenshots

![App Screenshot](https://user-images.githubusercontent.com/53568832/174501843-d7c4d245-008d-4292-906d-d069298b6312.png)


## Demo

You can try the complete game by following this link: http://wordy.cf 
to obtain this result it is necessary to realize your API yourself


## Installation

Make sure you have the complete Flutter SDK installed

```bash
  flutter doctor

  git clone https://github.com/baptistelsp/Wordy.git
  cd Wordy
```
Add config.dart in /utils subdir

```dart
class Config {

  static String API_URL = "http://your_api_url/";
  static String API_SEND_WORD = "send/word/";
  static String API_GET_WORD = "get/word/";

}
```
    
## Deployment

Thanks to Flutter, this project can be executed on a large number of platforms

```bash
  flutter run -d chrome
  flutter run -d windows
  flutter run -d macos
  flutter run -d linux
  ...
```


## Authors

- [@baptistelsp](https://www.github.com/baptistelsp)
See the blog post about this project [(in French)](https://bales.ml/wordy/) 
