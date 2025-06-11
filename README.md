# Mood Matcher
*Entertainment recommendation chatbot for :* 

 - Music 🎶
 - Movies 🎥
 - TV Shows 📺
 - Anime 🎌
 - Books 📚
 - Games 🎮

## Approach

![approach](https://github.com/user-attachments/assets/6bdf549f-9055-4772-ab45-9377b277f9a6)


## App UI 
[Figma design](https://www.figma.com/design/jaFsMAT8PH92iNnGBiome1/MoodMatcher?node-id=136-9&t=cvStVs0720i4ZS5X-1)

Splash Page             |  Auth Page
:-------------------------:|:-------------------------:
![screen1](https://github.com/user-attachments/assets/3ce0f885-f0aa-4b11-a38b-ee582b216a94) |  ![screen2](https://github.com/user-attachments/assets/28628af0-6222-4fdb-8c53-2b9656eff1ae)
Login Page             |  Register Page
![screen3](https://github.com/user-attachments/assets/174a2b54-ed55-49cc-bea1-58bcbfc43839) |  ![screen4](https://github.com/user-attachments/assets/b287de31-d868-40ac-8abd-be106b32e117)
Upload Avatar Page            |  Home Page
![screen5](https://github.com/user-attachments/assets/91d24103-32f9-4ee0-a020-6b3f60781c41) |  ![screen6](https://github.com/user-attachments/assets/d41ef4c6-80e0-412c-95d3-6de5290a0f50)
Quote Page             |  Profile Page
![screen7](https://github.com/user-attachments/assets/c45e5d0e-e3a3-4e2d-b2c1-53eed1078a9a) |  ![screen8](https://github.com/user-attachments/assets/b53c4fb8-6b13-4d63-917d-0ea1bbe3f2b0)
Contact US             | Update username 
![screen9](https://github.com/user-attachments/assets/750b4153-4aea-42b1-be82-a804d7af9501) | ![screen11](https://github.com/user-attachments/assets/b6175e9d-28b7-47db-ace5-77b4fc8ba460)
Movie Chatbot Page             | Music Chatbot Page
![screen10](https://github.com/user-attachments/assets/c0ecff5c-aaa9-400c-aa2b-d85db57d7c88) | ![screen12](https://github.com/user-attachments/assets/dbc9cb0f-5039-4d79-befa-1bea756a3402)




## Documentation
[Google docs link](https://docs.google.com/document/d/1V-b2pXGfZhhGXiO36j0VJ1cJt2Nq7QrS/edit?usp=sharing&ouid=105267528258841737377&rtpof=true&sd=true)

## Presentation
[Google slides link](https://docs.google.com/presentation/d/1o2PvASFygkDGI2EbykSm7P5tOBm8actPPWLwMkZ2HD8/edit?usp=sharing)

# How to run the project

## Prerequisites

Before you begin, make sure you have the following installed on your machine:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart) (comes with Flutter SDK)
- [Python](https://www.python.org/downloads/)
- [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/) 
## Setup for Flutter

1. **Clone the repository:**
```bash
   git clone https://github.com/patrickmasry195/mood_matcher.git
   cd mood_matcher 
   ```
2. **Install dependencies:**  
```bash
   flutter pub get
   ```
3. **Run the application:**  
```bash
   flutter run
   ```

## Setup for Supabase
Create a `supabase_config.dart` file and put it in `core/utils` folder

File should look like this :
```dart
const kSupabaseURL = "Your supabase url";  
const kSupabaseAnonKey =  "Your supabase Anonymous key";
   ```

## Setup for Flask (in VS code)

 - You have to download embeddings and model profiles for each model
 - You can find it here at [Google Drive](https://drive.google.com/drive/folders/1yyzgySFoMsvg5kzaOt4Z4dVAQBraz_nI)
 - After that clone the repos and put embeddings and profiles in the
   folder of their model

 - ***Clone Music model repository:***
```bash
   git clone https://github.com/patrickmasry195/music_chatbot.git 
   ```
 - **Run the application:**  
```bash
   .\setup-env.bat
   ```

 - ***Clone TV shows model repository:***
```bash
   git clone https://github.com/patrickmasry195/tvshows_chatbot.git 
   ```
 - **Run the application:**  
```bash
   .\setup_pro.bat
   ```

 - ***Clone Movies model repository:***
```bash
   git clone https://github.com/menashenouda/movie_model.git
   ```
 - **Run the application:**  
```bash
   .\run-project.bat
   ```

 - ***Clone Anime model repository:***
```bash
   git clone https://github.com/menashenouda/anime_model.git
   ```
 - **Run the application:**  
```bash
   .\setup.bat
   ```

- ***Clone Games model repository:***
```bash
   git clone https://github.com/menashenouda/games_model.git
   ```
 - **Run the application:**  
```bash
   .\setup.bat
   ```

- ***Clone Books model repository:***
```bash
   git clone https://github.com/menashenouda/books_model.git
   ```
 - **Run the application:**  
```bash
   .\setup.bat
   ```
