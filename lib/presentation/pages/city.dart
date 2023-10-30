import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_test_foodcourt/core/extension/context.dart';
import 'package:weather_app_test_foodcourt/core/extension/widget.dart';
import 'package:weather_app_test_foodcourt/presentation/notifier/my_vm.dart';

class CitiesPage extends StatefulWidget {
  const CitiesPage({super.key});

  @override
  State<CitiesPage> createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vm = context.read<MyViewModel>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder(
        future: vm.getCities(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              )
            : Consumer<MyViewModel>(
                builder: (context, value, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    30.verticalSpace,
                    Text(
                      'Select cities to\nmonitor',
                      style: context.textTheme.headlineMedium,
                    ).padHorizontal,
                    30.verticalSpace,
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < value.allCities.length; i++)
                              ListTile(
                                // contentPadding: EdgeInsets.zero,
                                onTap: () {
                                  value.addRemoveCities(value.allCities[i]);
                                },
                                title: Text(
                                  value.allCities[i].city,
                                  style: context.textTheme.bodyMedium,
                                ),
                                subtitle: Text(
                                  value.allCities[i].country,
                                  style: context.textTheme.bodySmall,
                                ),
                                trailing:
                                    !value.isCityStored(value.allCities[i].city)
                                        ? Text(
                                            value.allCities[i].iso2,
                                            style: context.textTheme.bodySmall,
                                          )
                                        : const Icon(Icons.check),
                              ),
                          ],
                        ),
                      ).padHorizontal,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
