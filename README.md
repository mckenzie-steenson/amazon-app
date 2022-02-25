# <div align="center"> Amazon Product Recommender Application </div>

<div align="center">
  
[![BUILD](https://img.shields.io/badge/Build-Passing-<COLOR>.svg)](https://github.com/vijayinyoutube/image_from_firebase_public)
[![Repo Status](https://img.shields.io/badge/RepoStatus-Active-blueviolet.svg)](https://github.com/mckenzie-steenson/amazon-app/)
[![MIT license](https://img.shields.io/badge/License-MIT-red.svg)](https://github.com/mckenzie-steenson/amazon-app/)
[![Flutter](https://img.shields.io/badge/_Flutter_-App-grey.svg?&logo=Flutter&logoColor=white&labelColor=blue)](https://github.com/mckenzie-steenson/amazon-app/)
  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/mckenzie-steenson/) 
[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/channel/UCnSOlBNWim68MYzcKbEswCA)
[![Discord](https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white)](https://discord.com/invite/F2c9b9v)
[![Medium](https://img.shields.io/badge/Medium-12100E?style=for-the-badge&logo=medium&logoColor=white)](https://mckenziesteenson.medium.com/utilizing-graph-technologies-to-connect-employees-57e0fef495d7)
  
</div>
  
<p align="center">
<img src="tg_flutter/assets/images/Email Banners (22).png" width="100%">
</p>

## Getting Started

Clone the repository into your local workspace to get started! 

Follow this guide to understand the App environment setup, build process, TigerGraph integration, and Flutter development 👉 : https://kristinezhengx.github.io/amazon-app-site/

Running into issues building the Flutter App?

Run the following commands:

```
flutter clean
flutter pub upgrade
```
  
**IMPORTANT NOTE: If you are building the Flutter Application with Firebase Storage implemented, you must run the below code to handle null safety**
```
flutter run -d chrome --no-sound-null-safety --web-renderer=html
```

## Flutter
[Flutter](https://flutter.dev/) is a crossplatfrom UI tool kit that helps in developing native Android and iOS app from a single code base.

## Dependencies
```pubspec.yaml
  http: ^0.13.4
  url_launcher: ^6.0.18
  firebase_core: ^1.6.3
  cloud_firestore: ^1.0.4
  firebase_storage: ^10.0.3
  file_picker: ^4.0.3
  flutter:
    sdk: flutter
```

