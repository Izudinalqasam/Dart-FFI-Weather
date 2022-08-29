#include <string.h>
#include <stddef.h>
#include <stdbool.h>
#include <stdlib.h>

double get_temperature() {
    return 86.0f;
}

char* get_forecast() {
    char* forecast = "sunny";
    char* forecast_m = malloc(strlen(forecast));
    strcpy(forecast_m, forecast);
    return forecast_m;
}

struct ThreeDayForecast {
    double today;
    double tomorrow;
    double day_after;
};

double fahrenheit_to_calculus(double temperature) {
    return (5.0f / 9.0f) * (temperature -32);
}

struct ThreeDayForecast get_three_day_forecast(bool useCelsius) {
    struct ThreeDayForecast forecast;
    forecast.today = 87.0f;
    forecast.tomorrow = 88.0f;
    forecast.day_after = 89.0f;

    if (useCelsius) {
        forecast.today =  fahrenheit_to_calculus(forecast.today);
        forecast.tomorrow = fahrenheit_to_calculus(forecast.tomorrow);
        forecast.day_after = fahrenheit_to_calculus(forecast.day_after);
    }

    return forecast;
}