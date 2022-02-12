
import 'package:flutter/material.dart';
import 'package:tarea3/donativos.dart';
import 'dart:async';
double value = 0;
var _value2;
String imgPayPal = "assets/paypal.png";
String imgTarjeta = "assets/tarjeta-de-credito.png";

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class GroupModel {
  String text;
  int index;
  bool selected;

  GroupModel({required this.text, required this.index, required this.selected});
}

 
  List<GroupModel> _group = [
    GroupModel(text: "Paypal", index: 1, selected: false),
    GroupModel(text: "Tarjeta", index: 2, selected: false),
  ];

  

class _HomePageState extends State<HomePage> {
  
   Widget makeRadioTiles() {
     
    List<Widget> list = <Widget>[];

    for (int i = 0; i < _group.length; i++) {
      list.add(Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: _group[i].selected ? Colors.white : Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(10.0) //         <--- border radius here
                )),
        child: RadioListTile(
          value: _group[i].index,
          groupValue: _value2,
          selected: _group[i].selected,
          onChanged: (val) {
            setState(() {
              for (int i = 0; i < _group.length; i++) {
                _group[i].selected = false;
              }
              _value2 = val;
              
              _group[i].selected = true;
              //print(_group[i].selected);
            });
          },
          activeColor: Colors.blue,
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text(
            ' ${_group[i].text}',
            style: TextStyle(
                color: _group[i].selected ? Colors.black : Colors.black,
                fontWeight:
                    _group[i].selected ? FontWeight.bold : FontWeight.normal),
          ),
        ),
      ));
    }

    Column column = Column(
      children: list,
    );
    return column;
  }
  String dropdownvalue = '100';   
  
  // List of items in our dropdown menu
  var items = [    
    '100',
    '350',
    '850',
    '1050',
    '9999',
  ];
  
  double sum = 0;
  double sumPaypal = 0;
  double sumTarjeta = 0;
  bool meta = false;
  double porcentage = 0.0;
  
  void downloadData(){
    String s = _value2.toString();
    if(s == "1"){
      sumPaypal += double.parse(dropdownvalue);
    }else if(s == "2"){
      sumTarjeta += double.parse(dropdownvalue);
    }
     sum += double.parse(dropdownvalue);
     print("Total = $sum");
     print("Paypal = $sumPaypal");
     print("Tarjeta = $sumTarjeta");
     if(sum < 10000){
        value +=  ((1*double.parse(dropdownvalue))/10000.00);
        porcentage += ((100*double.parse(dropdownvalue))/10000.00);
        print(porcentage);
     }else{
       meta = true;
       value = 1;
       porcentage = 100.00;
     }
  }
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
                title: Text(
                  'Es para una buena causa', 
                  style: TextStyle(
                    fontSize: 20,
                    
                    )
                  ),
                subtitle: Text('Elija modo de donativo'),
              ),
              makeRadioTiles(),
              SizedBox(height: 15),
              ListTile(
                leading:  Text(
                  "Cantidad a donar",
                  style: TextStyle(fontSize: 18),
                  ),
                trailing: DropdownButton(
              // Initial Value
              value: dropdownvalue,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
              ),
            ),
            ///SizedBox(height: 15),
            Stack(
              children: <Widget>[
                SizedBox(
                height: 20,
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                ),
              ),
               Align(child: Text("$porcentage %"), alignment: Alignment.topCenter,),
            ],
           ),
              
              SizedBox(height: 9),
              MaterialButton(
                onPressed: (){
                  //print('pressed $_value2');
                  downloadData();
                  setState(() {
                    
                  });
                },
                color: Colors.purple[900],
                height: 50.0,
                minWidth: double.infinity,
                child: Text(
                  "Donar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 298),
              FloatingActionButton(
              child: Icon(Icons.remove_red_eye),
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Donativos(
                      donativos:{
                        "paypal":sumPaypal,
                        "tarjeta": sumTarjeta,
                        "acomulado": sum,
                        "metaCumplida": meta,
                      },         
                      ),
                    )
                  );
                },
              ),
            ],
            ),
        )
      );
  }
}
