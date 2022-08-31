import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Chew', style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.of(context).pushNamed('/login');
              }, child: Text('Firebase Login', style: TextStyle(color: Colors.black),)),
              SizedBox(height: 20*size.height/896,),
              ElevatedButton(onPressed: (){
                Navigator.of(context).pushNamed('/');
              }, child: Text('Firebase profile', style: TextStyle(color: Colors.black),)),
            ],
          ),
        ),
      ),
    );
  }
}