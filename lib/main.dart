import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Edit',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'My profile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<TextEditingController> controllers;
  String? secret;
  late bool fem;
  late double height;
  late List<bool> hobbies;
  late String hobbiesString;
  int? favoriteLanguage;
  late List<String> languages;
  String? picUrl;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, (controller) => TextEditingController());
    fem = true;
    height = 170;
    hobbies = List.filled(5, false);
    languages = ['Dart', 'C', 'R', 'Java', 'Python'];
  }

  @override
  void dispose() {
    super.dispose();
    for (TextEditingController controller in controllers) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    hobbiesString = '';
    for (int i = 0; i < hobbies.length; i++) {
      if (hobbies[i]) {
        switch (i) {
          case 0:
            hobbiesString += ' Football';
            break;
          case 1:
            hobbiesString += ' Rugby';
            break;
          case 2:
            hobbiesString += ' Running';
            break;
          case 3:
            hobbiesString += ' Tennis';
            break;
          case 4:
            hobbiesString += ' Swimming';
            break;
          default:
            break;
        }
      }
    }
    picUrl = '';
    if (controllers[2].text.isEmpty) {
    } else if (int.parse(controllers[2].text) == 25 && fem && hobbies[0]) {
      picUrl =
          'https://images.unsplash.com/photo-1542680283-b96aadf08a09?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80';
    } else if (int.parse(controllers[2].text) == 12 && !fem && hobbies[1]) {
      picUrl =
          'https://images.unsplash.com/flagged/photo-1552803516-06cc17c06ab3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80';
    } else if (int.parse(controllers[2].text) == 35 && fem && hobbies[2]) {
      picUrl =
          'https://images.unsplash.com/photo-1541252260730-0412e8e2108e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1948&q=80';
    } else if (int.parse(controllers[2].text) == 40 && !fem && hobbies[3]) {
      picUrl =
          'https://images.unsplash.com/photo-1583275478661-1c31970669fa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80';
    } else if (int.parse(controllers[2].text) == 15 && !fem && hobbies[4]) {
      picUrl =
          'https://images.unsplash.com/photo-1600965962361-9035dbfd1c50?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: (picUrl == null || picUrl == '') ? null : 300,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  image: (picUrl == null || picUrl == '')
                      ? null
                      : DecorationImage(
                          image: NetworkImage(picUrl!), fit: BoxFit.cover),
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [BoxShadow(blurRadius: 10, spreadRadius: -3)]),
              child: (!(picUrl == null || picUrl == ''))
                  ? null
                  : Column(
                      children: [
                        Text('${controllers[0].text} ${controllers[1].text}'),
                        Text(
                            'Age : ${(controllers[2].text.isNotEmpty) ? int.parse(controllers[2].text) : ''}'),
                        Text('Height : ${height.toInt()} cm'),
                        Text('Gender : ${(fem) ? 'Female' : 'Male'}'),
                        Text('Hobbies :$hobbiesString'),
                        Text(
                            'Favorite Language : ${(favoriteLanguage != null) ? languages[favoriteLanguage!] : ''}'),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              secret =
                                  (secret != null) ? null : controllers[3].text;
                            });
                          },
                          child: Text('Show secret'),
                        ),
                        Container(
                          child: (secret != null) ? Text(secret!) : null,
                        )
                      ],
                    ),
            ),
            newSection('Edit info'),
            TextField(
              controller: controllers[0],
              decoration: InputDecoration(hintText: 'First name'),
            ),
            TextField(
              controller: controllers[1],
              decoration: InputDecoration(hintText: 'Last name'),
            ),
            TextField(
              controller: controllers[2],
              decoration: InputDecoration(hintText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: controllers[3],
              decoration: InputDecoration(hintText: 'Secret'),
              obscureText: true,
            ),
            spacedRow(
                'Gender: ${(fem) ? 'Female' : 'Male'}',
                Switch(
                    value: fem,
                    onChanged: (newVal) {
                      setState(() {
                        fem = newVal;
                      });
                    })),
            spacedRow(
                'Height : ${height.toInt()} cm',
                Slider(
                    value: height,
                    min: 100,
                    max: 240,
                    onChanged: (newVal) {
                      setState(() {
                        height = newVal;
                      });
                    })),
            newSection('My Hobbies'),
            spacedRow(
                'Football',
                Checkbox(
                    value: hobbies[0],
                    onChanged: (newVal) {
                      setState(() {
                        hobbies[0] = newVal ?? false;
                      });
                    })),
            spacedRow(
                'Rugby',
                Checkbox(
                    value: hobbies[1],
                    onChanged: (newVal) {
                      setState(() {
                        hobbies[1] = newVal ?? false;
                      });
                    })),
            spacedRow(
                'Running',
                Checkbox(
                    value: hobbies[2],
                    onChanged: (newVal) {
                      setState(() {
                        hobbies[2] = newVal ?? false;
                      });
                    })),
            spacedRow(
                'Tennis',
                Checkbox(
                    value: hobbies[3],
                    onChanged: (newVal) {
                      setState(() {
                        hobbies[3] = newVal ?? false;
                      });
                    })),
            spacedRow(
                'Swimming',
                Checkbox(
                    value: hobbies[4],
                    onChanged: (newVal) {
                      setState(() {
                        hobbies[4] = newVal ?? false;
                      });
                    })),
            newSection('Favorite language'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('Dart'),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Radio(
                        value: 0,
                        groupValue: favoriteLanguage,
                        onChanged: (newVal) {
                          setState(() {
                            favoriteLanguage = newVal as int;
                          });
                        })
                  ],
                ),
                Column(
                  children: [
                    Text('C'),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Radio(
                        value: 1,
                        groupValue: favoriteLanguage,
                        onChanged: (newVal) {
                          setState(() {
                            favoriteLanguage = newVal as int;
                          });
                        })
                  ],
                ),
                Column(
                  children: [
                    Text('R'),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Radio(
                        value: 2,
                        groupValue: favoriteLanguage,
                        onChanged: (newVal) {
                          setState(() {
                            favoriteLanguage = newVal as int;
                          });
                        })
                  ],
                ),
                Column(
                  children: [
                    Text('Java'),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Radio(
                        value: 3,
                        groupValue: favoriteLanguage,
                        onChanged: (newVal) {
                          setState(() {
                            favoriteLanguage = newVal as int;
                          });
                        })
                  ],
                ),
                Column(
                  children: [
                    Text('Python'),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Radio(
                        value: 4,
                        groupValue: favoriteLanguage,
                        onChanged: (newVal) {
                          setState(() {
                            favoriteLanguage = newVal as int;
                          });
                        })
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column newSection(String title) {
    return Column(
      children: [
        Divider(
          color: Colors.purple,
          thickness: 3,
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 18),
        )
      ],
    );
  }

  Row spacedRow(String text, Widget widget) {
    return Row(
      children: [Text(text), Spacer(), widget],
    );
  }

  /*Column radioColumn(String text, int val, int groupVal, void fct(bool newVal)) {
    return Column(
      children: [
        Text(text),
        Padding(padding: EdgeInsets.only(top: 5)),
        Radio(value: val, groupValue: groupVal, onChanged: fct)
      ],
    );
  }*/
}
