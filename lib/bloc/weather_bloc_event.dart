part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherBlocEvent {
  final Position position;

  const FetchWeather(this.position);

  @override
  List<Object> get props => [position];
}
class FetchWeatherByCityName extends WeatherBlocEvent {
  final String cityName;

  FetchWeatherByCityName( this.cityName);

  @override
  List<Object> get props => [cityName];
}