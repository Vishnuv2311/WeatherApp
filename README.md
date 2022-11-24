
# Weather Application

Get realtime Weather from your curret location and from your favorate city


## Demo

Screenshoot


![Home Screenshoot 1](https://raw.githubusercontent.com/Vishnuv2311/WeatherApp/main/screenshoot/1.png "Home Screeshoot")



![City Screenshoot 2](https://raw.githubusercontent.com/Vishnuv2311/WeatherApp/main/screenshoot/2.png "City Screeshoot")

## Application Usage

On clicking left navigation item Application will show weather of current location.

On clicking right navigation item Application will show weather of specific city.

## API Reference

#### Get weather of specific City

```http
  GET https://api.openweathermap.org/data/2.5/weather
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `appid` | `string` | **Required**. Your API key |
| `q` | `string` | **Required**. Your City Name|
| `units` | `string` | metric|

#### Get from current location

```http
  GET https://api.openweathermap.org/data/2.5/weather
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `appid`      | `string` | **Required**. Your API key |
| `lat`      | `string` | **Required**. Your location latitude |
| `lon`      | `string` | **Required**. Your location longitude|
| `units`      | `string` |  metric |




## Deployment

For Deployment need xcode


## Authors

- [@Vishnuv2311](https://www.github.com/vishnuv2311)


## 🚀 About Me
I'm a mobile application developer...


## 🛠 Skills
Java, Kotlin, Swift, Dart...


## Support

For support, email emailvishnuv@gmail.com.


