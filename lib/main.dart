import 'dart:math';

import 'package:flutter/material.dart';

import 'game2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  var _controller = TextEditingController();
  var random = Random();
  var answer = 0;
  var count = 0;

  @override
  Widget build(BuildContext context) {
    answer = random.nextInt(100) + 1;

    return Scaffold(
      appBar: AppBar(title: Text('GUESS THE NUMBER')),
      body: Container(
        margin: EdgeInsets.all(30.0),
        //padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            border: Border.all(
              width: 10,
              color: Color(0xF5A0AFDC),
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xF57FA0FA).withOpacity(1.0),
                offset: const Offset(8.0, 5.0),
                blurRadius: 7.0,
                spreadRadius: 3.0,
              ),
            ]),
        // color: Colors.lightGreenAccent,
        /*decoration: BoxDecoration(
              color: Colors.lightGreenAccent,
              border: Border.all(width: 20.0, color: Colors.greenAccent)),*/
        // alignment: Alignment.center,
        child: Container(
          color: Color(0xF5A0AFDC),
          child: Center(
            child: Column(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/guess_logo.png',
                        width: 150.0,
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'GUESS',
                                style: TextStyle(
                                    fontSize: 60.0, color: Colors.deepPurple),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'THE NUMBER',
                                style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.deepPurpleAccent),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                /*Expanded(child: Container()

                    //ElevatedButton(onPressed: () {}, child: Text('RANDOM')),
                      //mainAxisAlignment: MainAxisAlignment.center,
                  ),*/
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'ทายเลขตั้งแต่ 1 ถึง 100',
                    ),
                  ),
                ),
                //  Text('',style: TextStyle(fontSize: 100.0, ), textAlign: TextAlign.center,),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      onPressed: () {
                        var game = game2(answer);
                        var r = answer.toString();
                        var input = _controller.text;
                        print('เฉลย: ' + r.toString());
                        ///////
                        var guess = int.tryParse(input);
                        if (guess == null) {
                          print(
                              "กรอกข้อมูลไม่ถูกต้อง ให้กรอกเฉพาะตัวเลขเท่านั้น");
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('ERROR',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                  content: Text(
                                      'กรอกข้อมูลไม่ถูกต้อง\nให้กรอกเฉพาะตัวเลขเท่านั้น'),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'))
                                  ],
                                );
                              });
                        } else {
                          var result = game.doGuess(guess);
                          if (result == 1) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('RESULT',style:TextStyle(fontWeight: FontWeight.bold)),
                                    content:
                                    Text('$guess มากเกินไป กรุณาลองใหม่!'),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'))
                                    ],
                                  );
                                });
                            print('$guess มากเกินไป กรุณาลองใหม่!');
                            count++;
                          } else if (result == -1) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('RESULT',style:TextStyle(fontWeight: FontWeight.bold)),
                                    content:
                                    Text('$guess น้อยเกินไป กรุณาลองใหม่!'),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'))
                                    ],
                                  );
                                });
                            print('$guess น้อยเกินไป กรุณาลองใหม่!');
                            count++;
                          } else if (result == 0) {
                            count++;
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('RESULT',style:TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                                    content: Text(
                                        'ถูกต้องแล้วครับ🎉\nคุณทายทั้งหมด $count ครั้ง'),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'))
                                    ],
                                  );
                                });
                            print(
                                '$guess ถูกต้องแล้วครับ \n คุยทายทั้งหมด $count ครั้ง');
                          }
                        }
                      },
                      child: Text('GUESS')),
                ),
                /* TextButton(


             child: Text('TEST'),
              onPressed: () {  },
              ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
