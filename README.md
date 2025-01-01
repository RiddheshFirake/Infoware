# Flutter Application - Audio Player and Data Display

This is a Flutter application that demonstrates various key concepts including **API data fetching**, **form validation**, and **audio playback** from assets. The app is designed with best practices such as **DRY**, **OOP**, and **Bloc** for state management.

## Features

- **Fetch Data from an API**: The app fetches data from a public API and displays it in a clean and beautiful UI.
- **Item/Product Detailed Screen**: Tapping on an item from the list opens a detailed screen showing more information about the selected item.
- **Form with Validation**: A form is created to accept user inputs like name, email, phone, gender, country, state, and city with proper validation for each field.
- **Audio Player**: An audio player that plays audio files from assets, with basic controls (play, pause, stop).

## Screenshots
![App Screenshot 1](https://github.com/user-attachments/assets/b2832b96-9ac4-4f46-a27b-52c5dd13498c)

![App Screenshot 2](https://github.com/user-attachments/assets/ba61e2a2-20d6-4c02-b4eb-967f3c6abaaf)

![App Screenshot 3](https://github.com/user-attachments/assets/c174370d-75ac-475c-bbbd-0e01c81a2dc4)

![App Screenshot 4](https://github.com/user-attachments/assets/bdac8816-6dca-493a-9ef7-3b793a1fdd39)

![App Screenshot 5](https://github.com/user-attachments/assets/4a926ab8-451d-4862-987e-ebfc83784912)

![App Screenshot 6](https://github.com/user-attachments/assets/803fd25d-ea2b-4d88-aaf9-ef65773ef3d7)

![App Screenshot 7](https://github.com/user-attachments/assets/89902185-c554-4705-af16-e4e0abbc09d5)





## Technologies Used

- **Flutter**: Used for building the mobile app.
- **Bloc**: For state management.
- **HTTP**: For making API requests.
- **Audioplayers**: For playing audio files from assets.

## Setup Instructions

### Prerequisites

- Install Flutter on your local machine: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- Clone this repository:
  ```bash
  git clone https://github.com/RiddheshFirake/Infoware.git

- Navigate to the project directory:
  ```bash
  cd Infoware

- Install dependencies:
  ```bash
  flutter pub get

### Running the Application

- Connect a device or start an emulator.
- Run the application:
  ```bash
  flutter run

## Features Overview
1. Fetch Data from an API and Display in UI
- The app fetches data from a public API and displays it in a ListView.
- Each item in the list is clickable and navigates to a detailed screen.
2. Detailed Screen for Each Item
- Once an item is clicked, a detailed screen displays additional information like the title, description, and a link to the full article.
3. User Form with Validation
- A form to accept inputs like name, email, phone, gender, country, state, and city.
- Proper validation is applied for each field, such as:
- Email field checks if the email format is valid.
- Phone number field checks the length and format.
4. Audio Player
- The audio player plays an audio file from the app's assets.
- It includes basic controls for play, pause, and stop.
5. State Management using Bloc
- The app follows Bloc for state management, ensuring predictable state changes.
- Events like FetchDataEvent, SubmitFormEvent, and PlayAudioEvent trigger state changes, which the UI reacts to accordingly.

### Code Structure
- lib/main.dart: The entry point of the application.
- lib/blocs/: Contains all the Bloc files for state management.
- lib/screens/: Contains the screens such as the main list, detailed screen, and user form.
- lib/models/: Contains the models used to represent the data (e.g., Article).
- assets/: Contains static assets like images and audio files.

## Contributing
Feel free to fork this project and create pull requests for any improvements. If you encounter any issues or have suggestions, please open an issue.

## License
This project is open source and available under the MIT License.

## Contact
For any inquiries, feel free to reach out to me at riddhesh.firake@gmail.com.
