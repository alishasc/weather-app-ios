# 🌤️ Native iOS Real-Time Weather App

This is an iOS weather app built in Swift as part of my university coursework. The app fetches and displays weather and air quality data using the OpenWeather API, as well as top tourist attractions for any location using Apple's `MapKit` framework.

## ✨ Key Features

- Retrieves current weather and air quality data based on geographic coordinates (latitude & longitude)
- Displays the top tourist attractions in specified locations
- Visualises air quality values on a custom graph
- Stores previously searched locations locally

## 🛠️ Technologies Used

- **Swift** — Built using Swift and the MVVM architecture pattern
- **OpenWeather One Call API** — For weather and air quality data
- **SwiftData** — Local database to store previously searched locations
- **MapKit** — To display tourist attractoins on an interactive map
- **CoreGraphics** — For drawing the air quality graph

## 📱 Screenshots

### Home Screen
Displays the current location's current weather data (London by default). Air quality information is shown both numerically and graphically—tapping the air quality icons displays further defintions of these.
<br>
<img width="330" alt="london home" src="https://github.com/user-attachments/assets/39c0cc01-cd2a-49b8-aa9a-721166d950eb" />
<img width="330" alt="london air quality info" src="https://github.com/user-attachments/assets/3a54e2c0-6a5a-424a-90c8-da91cc4d37c4" />
<img width="330" alt="london graph" src="https://github.com/user-attachments/assets/0146a26b-0ad4-460d-bcbe-354fdd03e1f2" />

### Weather Forecast
Hourly and daily weather forecast available for up to five days in advance.
<br>
<img width="330" alt="london forecast" src="https://github.com/user-attachments/assets/ebc8231d-2871-454e-b6b6-ca1e5cd2e6a8" />

### Tourist Attractions Map
Displays the top five tourist attractions for a selected location, shown as a list and on a map.
<br>
<img width="330" alt="london attractions" src="https://github.com/user-attachments/assets/ff4a9004-cc07-4d34-bebd-b7acd5c5dc51" />

### Stored Locations
Previously searched locations are saved using SwiftData and shown with name and coordinates.
<br>
<img width="330" alt="stored places" src="https://github.com/user-attachments/assets/97b5f852-d523-4920-9c2f-1de1b478651c" />

## 🚧 Extra Information

- Developed for the iPhone 15 Pro Max iOS 17.5
- The OpenWeather API key has been removed from the public version of this project.
- To enable data fetching, add your own API key to the ViewModel where the request URL is constructed:
```swift
private var openWeatherAPIKey: String = "YOUR_OPEN_WEATHER_API_KEY_HERE"
```
