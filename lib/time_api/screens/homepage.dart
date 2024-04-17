import 'package:apibatch04/time_api/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController zoneController = TextEditingController();

  String timeZone = 'Asia/Colombo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: zoneController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Time Zome")),
              ),
              const SizedBox(
                height: 5,
              ),
              FilledButton(
                  onPressed: () {
                    if (zoneController.text.isNotEmpty) {
                      setState(() {
                        timeZone = zoneController.text;
                      });
                    }
                  },
                  child: const Text('Get Data')),
              const SizedBox(
                height: 5,
              ),
              FutureBuilder (
                future: ApiServices().getTime(timeZone),
                builder: (BuildContext context , AsyncSnapshot<List<String>> snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children:
                        List.generate(snapshot.data!.length, (index) =>  Text(snapshot.data![index])),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
