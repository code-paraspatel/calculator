import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 // double firstNum = 0.0;
  //double secondNum = 0.0;
  var inputValue = '';
  var outputValue = '';
 // var operation = '';
  var hidevalue = false;
  var outputSize = 30.0;


  onButtonTap(value) {
    if (value == 'AC') {
      inputValue = '';
      outputValue = '';
    } else if(value=='CE'){
      inputValue='';
      outputValue='';
    }
    else if (value == '<') {
      if (inputValue.isNotEmpty) {
        inputValue = inputValue.substring(0, inputValue.length - 1);
      }else if(inputValue.isEmpty){
        outputValue='';
      }

    } else if (value == '=') {
      if (inputValue.isNotEmpty) {
        outputValue = calculation().toString();
       inputValue = calculation().toString();
       // hidevalue=true;
        outputSize=40.0;
      }
    }
    else {
      inputValue = inputValue + value;
      hidevalue=false;
      outputSize=30.0;
    }

    setState(() {});
  }
 double calculation(){
    var userInput = inputValue;
    Parser p = Parser();
    Expression expression = p.parse(userInput);
    ContextModel cm = ContextModel();
    return expression.evaluate(EvaluationType.VECTOR, ContextModel());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hidevalue? '' :inputValue.toString(),
                  style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  outputValue.toString(),
                  style: TextStyle(fontSize: outputSize, color: Colors.white),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          )),
          Row(
            children: [
              button(
                  text: 'AC', txcolor: Colors.orange, bgcolor: Colors.black12),
              button(
                  text: '<', txcolor: Colors.orange, bgcolor: Colors.black12),
              const Spacer(),
              button(text: '/', bgcolor: Colors.black12)
            ],
          ),
          Row(
            children: [
              button(text: '7'),
              button(text: '8'),
              button(text: '9'),
              button(text: '*', bgcolor: Colors.black12)
            ],
          ),
          Row(
            children: [
              button(text: '4'),
              button(text: '5'),
              button(text: '6'),
              button(text: '-', bgcolor: Colors.black12)
            ],
          ),
          Row(
            children: [
              button(text: '1'),
              button(text: '2'),
              button(text: '3'),
              button(text: '+', bgcolor: Colors.black12)
            ],
          ),
          Row(
            children: [
              button(text: 'CE', txcolor:Colors.orange, bgcolor: Colors.black12),
              button(text: '0'),
              button(text: '.', bgcolor: Colors.black12),
              button(text: '=', bgcolor: Colors.orange)
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, txcolor = Colors.white, bgcolor = Colors.black87}) {

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: bgcolor,
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              onButtonTap(text);
              outputValue=calculation().toString();
            },
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 20, color: txcolor, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
