import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated listz',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const ListScreen(),
    );
  }
}

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final Animation<double> _animationDropDown;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _animationDropDown = Tween(begin: 0.0, end: 0.5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Samsung smartphones"), centerTitle: true),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 200),
            child: Column(children: [
              Container(
                  child: Image.network(
                      'https://androidinsider.ru/wp-content/uploads/2021/05/samsung_galaxy_z_flip_3_01.jpg')),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text('Samsung Galaxy Z Flip 3', style: TextStyle(fontSize: 20)),
                SizedBox(
                    height: 50,
                    child: RotationTransition(
                      turns: _animationDropDown,
                      child: InkWell(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (show) {
                              _controller.forward();
                            } else {
                              _controller.reverse();
                            }
                            show = !show;
                          });
                        },
                        child: const Icon(Icons.arrow_drop_down, size: 40),
                      )),
                    ))
              ]),
              SizeTransition(
                  sizeFactor: _animation,
                  axis: Axis.vertical,
                  child: SizedBox(
                      height: 80,
                      child: Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: ListTile(
                          title: Text(
                            'Полноразмерный смартфон, размеры которого в сложенном виде всего 4,2 дюйма.. ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kurale',
                                height: 1.5),
                          ),
                        ),
                      )))
            ])));
  }
}
