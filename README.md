# 🎬 Movie Time App

A modern Flutter-based movie browsing application that integrates a public REST API to fetch and display real-time movie data.

This project was developed as part of an academic assignment for Android Development Framework.

---

## 🚀 Features

* 🎞️ Hero Carousel with auto-scroll and indicators
* 🔥 Trending, Popular, and Upcoming Movies
* 🎥 Detailed Movie Information Screen
* 📺 Separate Movies and TV Shows Sections
* 🔍 Search Functionality (API-based)
* 📱 Responsive UI with modern design
* 🎨 Custom App Icon & Font Styling
* 🌐 REST API Integration (TMDb)

---

## 🛠️ Tech Stack

* **Framework:** Flutter
* **Language:** Dart
* **API:** TMDb (The Movie Database)
* **HTTP Requests:** http package
* **Architecture:** Stateful + API Service Layer

---

## 📸 Screenshots

<!-- Add your screenshots below -->

### 🏠 Home Screen

<img width="1918" height="1079" alt="Screenshot 2026-04-21 211854" src="https://github.com/user-attachments/assets/9fe691ea-7a47-4429-99f7-bf0b10d6d880" />


### 🎬 Movie Details Screen

<img width="1919" height="1079" alt="Screenshot 2026-04-21 211937" src="https://github.com/user-attachments/assets/c462d2b9-55d5-4bb6-961f-e17b0aecd147" />


### 🎥 Movies Page

<img width="1918" height="1079" alt="Screenshot 2026-04-21 211912" src="https://github.com/user-attachments/assets/daadc90f-aa9f-4c21-b6ab-bfb64e3248d9" />


### 📺 TV Shows Page

<img width="1919" height="1079" alt="Screenshot 2026-04-21 211926" src="https://github.com/user-attachments/assets/3d6c9435-3136-457b-89fa-99bb7fecd9fb" />


---

## 🎥 Demo Video

<!-- Paste your demo video link below -->

https://drive.google.com/file/d/1GtXHiJNymOZnt0JEurN0pskbrCHJdN6M/view?usp=sharing

---

## 📦 APK Download

<!-- Optional: Add your APK link if uploaded -->

[Download APK](#)

---

## ⚙️ How to Run the Project

```bash
git clone https://github.com/your-username/movie-time.git
cd movie-time
flutter pub get
flutter run
```

---

## 🔑 API Integration

This app uses TMDb API.

To run locally:

1. Get API key from TMDb
2. Add it in:

```dart
api_service.dart
```

```dart
static const String apiKey = "My_API_KEY_HERE";
```

---

## ⚠️ Known Issues

* API requests may be slower due to proxy usage (network restrictions)
* Search may take slightly longer on limited networks

---

## 🎯 Learning Outcomes

* Integration of REST APIs in Flutter
* JSON parsing and dynamic UI rendering
* Navigation between multiple screens
* State management using Stateful Widgets
* UI/UX design implementation

---

## 👨‍💻 Author

**Name:** Dave Nirmit
**Enrollment No:** 20230905090028
**College:** Gyanmanjari Innovative University
**Subject:** Android Development Framework

---

## 📄 License

This project is for academic purposes only.

---

⭐ If you found this project helpful, feel free to give it a star!
