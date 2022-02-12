
import 'package:flutter/material.dart';
import 'package:tarea3/donativos.dart';
import 'dart:async';
double value = 0;
var _value2;
var _value3;

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
  
  void downloadData(){
    String s = _value2.toString();
    if(s == "1"){
      sumPaypal += double.parse(dropdownvalue);
    }else{
      sumTarjeta += double.parse(dropdownvalue);
    }
     sum += double.parse(dropdownvalue);
     print("Total = $sum");
     print("Paypal = $sumPaypal");
     print("Tarjeta = $sumTarjeta");
     if(sum < 10000){
        value = value + ((1*double.parse(dropdownvalue))/10000.00);
        //print(value);
     }else{
       meta = true;
       value = 1;
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
            SizedBox(height: 15),
              LinearProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.green,
                minHeight: 18,
                value: value,
                
              ),
              SizedBox(height: 9),
              MaterialButton(
                onPressed: (){
                  //print('pressed $_value2');
                  downloadData();
                  setState(() {
                    
                  });
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
class RadioModel {
  bool isSelected;
  final IconData icon;
  final String text;
  final Color selectedColor;
  final Color defaultColor;

  RadioModel(this.isSelected, this.icon, this.text, this.selectedColor,
      this.defaultColor);
}