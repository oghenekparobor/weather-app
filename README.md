
## Weatger App


### How It Works
- On first launch user grants app permission
- On launch it get weather of device current location
- User can opening list of cities and add to Carousel at the center left side of the screen
- On selecting any of the choosen cities the weaher forecast of that city is loaded

### Project Setup
- Click on the code button to see the repo link
- Open your terminal and run ``` git clone  https://github.com/oghenekparobor/weather-app.git ```
- Change to the flutter project ```cd weather-app ```
- Install the flutter plugins ```flutter pub get```
- Install the flutter plugins ```echo "baseUrl=https://api.openweathermap.org" > .env```
- Replace ```******apikey******``` with your apikey before run the next command
- Install the flutter plugins ```echo "apiKey=******apikey******" > .env```
- Get all generated classes ```dart run build_runner build --delete-conflicting-outputs```
- Install the flutter plugins ```flutter test```
- We either you physical device connected or an emulator run the project ```flutter run```