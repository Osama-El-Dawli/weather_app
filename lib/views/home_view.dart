import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubit/get_weather_cubit/get_weather_state.dart';
import 'package:weather_app/views/search_view.dart';
import 'package:weather_app/widgets/no_weather_body.dart';
import 'package:weather_app/widgets/weather_info_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: BlocBuilder<GetWeatherCubit, WeatherState>(
            builder: (context, state) {
              Color appBarColor = Colors.transparent;

              if (state is WeatherLoadedState) {
                appBarColor = getThemeColor(state.weatherModel.weatherConditon);
              } else if (state is WeatherFailureState) {
                appBarColor = Colors.red;
              }

              return AppBar(
                title: const Text('Weather App'),
                backgroundColor: appBarColor,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const SearchView();
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.search),
                  )
                ],
              );
            },
          ),
        ),
        body: BlocBuilder<GetWeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitialState) {
              return const NoWeatherBody();
            } else if (state is WeatherLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.grey),
              );
            } else if (state is WeatherLoadedState) {
              return WeatherInfoBody(
                weather: state.weatherModel,
              );
            } else {
              return const Center(
                child: Text(
                  'Oops there is an error',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          },
        ));
  }
}

// Function to get theme color based on weather condition
Color getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue; // Default color
  }
  switch (condition) {
    case 'Sunny':
    case 'Clear':
      return Colors.orange;
    case 'Partly cloudy':
      return Colors.blueGrey;
    case 'Cloudy':
    case 'Overcast':
      return Colors.grey;
    case 'Mist':
      return Colors.lightBlue;
    case 'Rain':
      return Colors.blue;
    case 'Snow':
      return Colors.blueGrey;
    default:
      return Colors.blueGrey;
  }
}
