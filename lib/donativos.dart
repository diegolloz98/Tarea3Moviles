import 'package:flutter/material.dart';

class Donativos extends StatefulWidget {
  final donativos;
  
  Donativos({Key? key, this.donativos}) : super(key: key);

  @override
  State<Donativos> createState() => _DonativosState();
  
}


class _DonativosState extends State<Donativos> {
  
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Donativos Obtenidos'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                leading:  Image.asset("assets/paypal.png"),
                trailing: Text(
                  "${widget.donativos["paypal"] ?? 0.0}",
                  style: TextStyle(fontSize: 32),
                  ),
              ),
              SizedBox(height: 24),
              ListTile(
                leading:  Image.asset("assets/tarjeta-de-credito.png"),
                trailing: Text(
                  "${widget.donativos["tarjeta"] ?? 0.0}",
                  style: TextStyle(fontSize: 32),
                  ),
              ),
              SizedBox(height: 24),
              Divider(),
              ListTile(
                leading:  Icon(Icons.attach_money, size: 64),
                trailing: Text(
                  "${widget.donativos["acomulado"] ?? 0.0}",
                  style: TextStyle(fontSize: 32),
                  ),
              ),
              Image.asset("assets/gracias.png")
            ],),
        )
      );
  }
}