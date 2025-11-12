Dev Gallery – Machine Test
A Flutter application that displays developer data from the public GitHub API.
The project follows a simple and modular structure suitable for production and evaluation use.
Overview
The application loads data from a local Hive database if available.
If the local storage is empty, it fetches developer data from the GitHub REST API and stores it for offline access.
Data is displayed in a list view with a consistent user interface and a detailed profile view.
A favorites section will be added later.
Features
Offline-first data loading
Automatic online fetch when offline cache is empty
Pull-to-refresh for latest data
Skeleton loading effect during fetch
Detailed developer view with WebView for external links
Consistent list card UI design
Planned: Favorites module with local Hive box
Project Structure
lib/
├── core/
│   └── hive_support.dart
├── features/
│   └── developers/
│       ├── model/
│       ├── repository/
│       ├── presentation/
│       │   ├── bloc/
│       │   ├── screens/
│       │   └── widgets/
└── resources/
├── styles/
└── widgets/
Technical Stack
Category	Tool
Flutter SDK	3.35.7 (stable)
State Management	BLoC
Networking	Dio
Local Database	Hive
Routing	GoRouter
Image Caching	CachedNetworkImage
Loading Animation	Skeletonizer
API Information
Endpoint:
https://api.github.com/users
Rate Limits:
Unauthenticated: 60 requests/hour per IP
Authenticated (with token): 5000 requests/hour
To increase request capacity:
add a github token here currently removed token
dio.options.headers['Authorization'] = 'token';
Data Handling
Condition	Action
Local Hive has data	Load from Hive
Local Hive empty	Fetch from GitHub API
Pull-to-refresh	Update Hive with new data
Notes
Works fully offline after first successful fetch
Automatically manages transition between offline and online states
Uses clean modular structure for clarity and maintainability
Designed and implemented for the Dev Gallery machine test