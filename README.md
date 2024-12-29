# CryptoTracker

CryptoTracker is a SwiftUI-based cryptocurrency tracking app designed to display real-time cryptocurrency prices, allow users to search and filter cryptocurrencies, and manage favorites. Built using Combine and the MVVM architecture, this app leverages modern iOS development practices for a seamless user experience.

## Features

1. **Search Cryptocurrencies**  
   - Users can search for cryptocurrencies by name or symbol.  
   - Powered by a debounced search bar using Combine.  

2. **Real-Time Prices**  
   - Fetch and display a list of real-time cryptocurrency prices with auto-refresh every 30 seconds.  

3. **Favorites Management**  
   - Mark cryptocurrencies as "favorites" for quick access.  
   - Filter to display only favorite cryptocurrencies.  
   - Favorites are persisted using UserDefaults.  

4. **Details Screen**  
   - Navigate to a details screen for each cryptocurrency to view:  
     - Name and symbol.  
     - Current price.  
     - Price change percentage (if available).  

5. **Error Handling**  
   - Gracefully handle API errors and display user-friendly error messages.  

6. **Architecture**  
   - MVVM architecture ensures a clean separation of concerns.  
   - Combine is used for managing asynchronous calls and binding data to the UI.  

7. **Optional Features**  
   - Unit tests for ViewModels and API services.  

---

## Technical Stack

- **SwiftUI**: For building all UI components.  
- **Combine**: For asynchronous programming and data binding.  
- **MVVM Architecture**: To ensure maintainability and scalability.  
- **Coin Gecko API**: For fetching cryptocurrency data.  

---

## Installation and Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/CryptoTracker.git
   cd CryptoTracker
   ```

2. **Open the Project**
   - Open `CryptoTracker.xcodeproj` in Xcode (minimum version 14.0).  

3. **API Configuration**
   - The app integrates with the [Coin Gecko API](https://www.coingecko.com/en/api).  
   - No API key is required for basic usage.  

4. **Run the App**
   - Select your target device or simulator.  
   - Build and run the project in Xcode.

---

## Screenshots

1. **Search and Real-Time Prices**
   - A list of cryptocurrencies with a search bar and real-time auto-refresh.
![listOfCryptoCurrencies](https://github.com/user-attachments/assets/3a1a957b-0310-4f91-822a-8578f63035bb)

2. **Favorites Management**
   - Easily mark and filter your favorite cryptocurrencies.
![favoritesCryptoCurrencies](https://github.com/user-attachments/assets/595b952e-435d-489c-b40a-cc3322a4c9f1)

3. **Details Screen**
   - View comprehensive details about a specific cryptocurrency.
![cryptoCurrencyDetails](https://github.com/user-attachments/assets/868dc004-3d20-42fe-a4a8-b2e840004376)

3. **Search**
   - Users can search in the cryptocurrencies list  and favorites list.
![searchCryptoCurrencies](https://github.com/user-attachments/assets/7ab2da0e-e599-4cf5-bf4a-a7cfcc8eda38)

---

## Future Enhancements

- Add Core Data for more robust persistence.  
- Extend the details screen with historical price charts.  
- Implement more unit tests to increase code coverage.

---

## Repository Structure

```plaintext
CryptoTracker/
├── Models/             # Data models
├── Views/              # SwiftUI views
├── ViewModels/         # ViewModels implementing business logic
├── Services/           # API service layer
├── Resources/          # Assets and localization files
├── Tests/              # Unit tests
└── README.md           # Project documentation
```

---

## Unit Tests
MARK: - will be in the incoming release 

Unit tests are available for:  
- **ViewModels**: Ensuring correct filtering, searching, and state management logic.  
- **API Services**: Validating correct API responses and error handling.  

To run the tests:  
1. Select `Product > Test` from the Xcode menu.  
2. Ensure all tests pass successfully.  

---
