<div align="center">

# 📅 TimeTablePlus

**A simple, cross-platform Flutter application for creating, editing, and viewing class timetables.**
<br>
*An educational project by students from Rangsee Vittaya School.*

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Google Sheets](https://img.shields.io/badge/Google%20Sheets-34A853?style=for-the-badge&logo=google-sheets&logoColor=white)](https://www.google.com/sheets/about/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=for-the-badge)](http://makeapullrequest.com)

[Features](#-features) • [Installation](#-quick-setup) • [Configuration](#-google-sheets-configuration) • [Project Info](#-project-information)

</div>

---

## 📖 About The Project

TimeTablePlus is a cross-platform mobile and web application built with Flutter. It allows users to manage class schedules efficiently using **Google Sheets** as a real-time backend database.

### 🇹🇭 สรุปโปรเจกต์ (Thai)
* **ประเภท:** โครงงานจบ ม.6 โรงเรียนรังษีวิทยา (Rangsee Vittaya School)
* **ฐานข้อมูล:** ใช้ Google Sheets ในการเก็บข้อมูลตารางเรียน
* **API:** เชื่อมต่อผ่าน `lib/api/sheet/class_sheets_api.dart`
* **สถานะ:** อยู่ในช่วงพัฒนา (ยังไม่มี Unit Test ในโฟลเดอร์ `test/`)

### 🇬🇧 Project Summary (English)
* **Type:** Grade-12 graduation project (Capstone)
* **Database:** Google Sheets is used as the primary database.
* **API:** Integration logic is located in `lib/api/sheet/class_sheets_api.dart`.
* **Status:** Development phase (No tests currently in `test/`).

---

## ✨ Features

- 📱 **Cross-Platform:** Works on Android, iOS, Web, and Desktop.
- ☁️ **Cloud Sync:** Uses Google Sheets for easy data management and synchronization.
- 🗓️ **Timetable Management:** Create, View, and Edit class entries easily.
- 👥 **Collaborative:** Built for team usage and easy sharing.

---

## 📸 Screenshots

| Light Mode | Dark Mode |
|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/833e8ec0-22f5-4764-bc01-4c8cdbb5d83e" width="200"> | <img src="https://github.com/user-attachments/assets/216b978a-97c3-46e2-b637-c73f75b73810" width="200"> |

---

## 🚀 Quick Setup

Follow these steps to get the project up and running on your local machine.

### 1. Clone the repository
```bash
git clone [https://github.com/AutCraft/TimeTablePlus.git](https://github.com/AutCraft/TimeTablePlus.git)
cd TimeTablePlus
````

### 2\. Install dependencies

```bash
flutter pub get
```

### 3\. Run the app

You can run the app on a connected device, emulator, or web browser.

```bash
# Run on default device
flutter run

# Run specifically on Chrome
flutter run -d chrome
```

-----

## ⚙️ Google Sheets Configuration

⚠️ **Important:** This project relies on Google Sheets API. You must configure the API connection for the app to work.

**Location:** `lib/api/sheet/class_sheets_api.dart`

### Setup Steps:

1.  **Google Cloud Console:** Create a project and enable the **Google Sheets API**.
2.  **Service Account:** Create a Service Account and download the JSON credentials.
3.  **Share Sheet:** Create a Google Sheet and share it with the Service Account email (Editor access).
4.  **Implementation:**
      * Do **NOT** commit the JSON key to GitHub. Add it to `.gitignore`.
      * Implement the API logic in `class_sheets_api.dart`.
      * Use packages like `googleapis` or `googleapis_auth`.

**Conceptual Example (`class_sheets_api.dart`):**

```dart
// lib/api/sheet/class_sheets_api.dart

class ClassSheetsApi {
  // TODO: Add your Google Sheets API initialization here
  
  static Future<void> init() async {
    // Load credentials and scopes
  }

  static Future<List<ClassEntry>> fetchEntries() async {
    // Fetch data from the sheet
    return []; 
  }
}
```

-----

## 📂 Project Structure

A quick look at the top-level directory structure:

```text
TimeTablePlus/
├── lib/
│   ├── api/
│   │   └── sheet/
│   │       └── class_sheets_api.dart  <-- API Logic Here
│   ├── main.dart
│   └── ...
├── test/             <-- (Currently empty)
├── assets/           <-- Fonts and Images
├── android/
├── ios/
├── web/
└── pubspec.yaml
```

-----

## 🤝 Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

-----

<div align="center"\>

Made with ❤️ by the **TimeTablePlus Team** (Rangsee Vittaya School)


</div\>
