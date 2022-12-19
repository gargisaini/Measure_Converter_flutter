import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late double _numberFrom;
  String ? _convertedMeasure;
  String ? _resultMessage;

  final List<String> _measures = [
    'meters',
    'kilometer',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds' ,
    'ounces' ,

  ];

  final Map<String, int> _measuresmap = {
    'meters': 0,
    'kilometer': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds': 6,
    'ounces': 7,
  };
  final dynamic _formulas ={
    '0':[1,0.001,0,0,3.28084,0.000621371,0,0],
    '1':[1000,1,0,0,3280.84,0.621371,0,0],
    '2':[0,0,1,0.0001,0,0,0.00220462,0.035274],
    '3':[0,0,1000,1,0,0,2.20462,35.274],
    '4':[0.3048,0.0003048,0,0,1,0.000189394,0,0],
    '5':[1609.34, 1.60934,0,0,5280,1,0,0],
    '6':[0,0,453.592,0.453592,0,0,1,16],
    '7':[0,0,28.3495,0.0283495,3.28084,0,0.0625, 1],
  };
  String ? _startMeasure;

  @override
  void initState() {
    _numberFrom = 0;
    super.initState();
  }

  @override
  final TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color:  Colors.blue[900],
  );

  final TextStyle lableStyle = TextStyle(
    fontSize: 24,
    color: Colors.grey[700],
  );
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Measures Converter'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children:[
                  SizedBox(height: 20,),
                  Text(
                    'Value',
                    style: lableStyle,
                  ),
                  SizedBox(height: 25,),
                  TextField(
                    style: inputStyle,
                    decoration: InputDecoration(
                      hintText: 'Please enter the measure to be converted'
                    ),
                    onChanged: (text){
                      var rv = double.tryParse(text);
                      if(rv != null){
                        setState(() {
                          _numberFrom = rv;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 25,),
                  Text(
                    'From',
                    style: lableStyle,
                  ),
                  DropdownButton(
                    isExpanded: true,
                      items: _measures.map((String value){
                        return DropdownMenuItem<String>(value: value,child: Text(value),);
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          _startMeasure = value!;
                        });
                      },
                    value: _startMeasure,
                  ),
                  SizedBox(height: 25,),
                  Text(
                    'To',
                    style: lableStyle,
                  ),
                  SizedBox(height: 25,),
                  DropdownButton(
                    isExpanded: true,
                    style: inputStyle,
                    items: _measures.map((String value){
                      return DropdownMenuItem<String>(value: value,child: Text(value),);
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        _convertedMeasure = value!;
                      });
                    },
                    value: _convertedMeasure,
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(
                      onPressed: (){
                        if(_startMeasure!.isEmpty || _convertedMeasure!.isEmpty || _numberFrom==0){
                          return;
                        }else{
                          convert(_numberFrom, _startMeasure.toString(), _convertedMeasure.toString());
                        }
                      },
                      child: Text('Convert',
                      style: TextStyle(
                        fontSize: 20,
                      ),),
                  ),
                  SizedBox(height: 25,),
                  Text((_numberFrom == null)? ' ': _resultMessage.toString(),
                  style: lableStyle
                  ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void convert(double value, String from , String to){
    int? nFrom = _measuresmap[from];
    int? nTo = _measuresmap[to];
     var multiplier = _formulas[nFrom.toString()][nTo];
     var result = value *  multiplier;

     if(result == 0){
       _resultMessage = 'This conversion cannot be performed';
     }else{
       _resultMessage = '${_numberFrom.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
       setState(() {
         _resultMessage = _resultMessage;
       });
     }
  }
}