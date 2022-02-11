
import 'package:flutter/material.dart';
import 'package:tarea3/donativos.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Donaciones'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                title: Text('Es para una buena causa'),
                subtitle: Text('Elija modo de donativo'),
              ),
              
              MaterialButton(
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Donativos(
                        donativos:{
                          "paypal":0.0,
                          "tarjeta": 0.0,
                          "acomulado": 0.0,
                          "metaCumplida": false,
                        },
                        ),
                      )
              );
                },
                color: Colors.blue[900],
                height: 50.0,
                minWidth: double.infinity,
                child: Text(
                  "Donar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:14.0,
                    fontWeight: FontWeight.bold,
                  )
                )
              )
            ],
            ),
        )
      );
  }
}