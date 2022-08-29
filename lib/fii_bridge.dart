import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

typedef TemperatureFunction = Double Function();
typedef TemperatureFunctionDart = double Function();

typedef ForecastFunction = Pointer<Utf8> Function();
typedef ForecastFunctionDart = Pointer<Utf8> Function();

typedef ThreeDayForecastFunction = ThreeDayForecast Function(Uint8 useCelcius);
typedef ThreeDayForecastFunctionDart = ThreeDayForecast Function(
    int useCelcius);

class FFIBridge {
  TemperatureFunctionDart _getTemperature;
  ForecastFunctionDart _getForecast;
  ThreeDayForecastFunctionDart _getThreeDayForecast;

  FFIBridge() {
    final dl = Platform.isAndroid
        ? DynamicLibrary.open('libweather.so')
        : DynamicLibrary.process();

    _getTemperature =
        dl.lookupFunction<TemperatureFunction, TemperatureFunctionDart>(
            'get_temperature');

    _getForecast = dl
        .lookupFunction<ForecastFunction, ForecastFunctionDart>('get_forecast');

    _getThreeDayForecast = dl.lookupFunction<ThreeDayForecastFunction,
        ThreeDayForecastFunctionDart>('get_three_day_forecast');
  }

  double getTemperature() => _getTemperature();

  String getForecast() {
    final ptr = _getForecast();
    final forecast = ptr.toDartString();
    calloc.free(ptr);
    return forecast;
  }

  ThreeDayForecast getThreeDayForecast(bool useCelsius) {
    return _getThreeDayForecast(useCelsius ? 1 : 0);
  }
}

class ThreeDayForecast extends Struct {
  @Double()
  external double get today;
  external set today(double value);

  @Double()
  external double get tomorrow;
  external set tomorrow(double value);

  @Double()
  external double get day_after;
  external set day_after(double value);

  @override
  String toString() {
    return 'Today : ${today.toStringAsFixed(1)}\n'
        'Tomorrow : ${tomorrow.toStringAsFixed(1)}\n'
        'Day After ${day_after.toStringAsFixed(1)}';
  }
}
