import 'package:boredapi/home/bloc/home_bloc.dart';
import 'package:boredapi/home/services/BoredServices.dart';
import 'package:boredapi/home/services/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
          RepositoryProvider.of<BoredService>(context),
          RepositoryProvider.of<ConnectivityService>(context))
        ..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Activity for bored people"),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeLoadingState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Load More Activity for You",
                    style: TextStyle(color: Colors.blue, fontSize: 25),
                  )
                ],
              ),
            );
          }
          if (state is HomeLoadedState) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.activityName,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    state.activityType,
                    style: const TextStyle(fontSize: 25, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Atleast " + state.participants.toString() + " Person",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<HomeBloc>(context).add(LoadApiEvent()),
                    child: const Text(
                      "Next Activity",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is HomeNoInternetState) {
            const Text("No Internet :(");
          }
          return Container();
        }),
      ),
    );
  }
}
