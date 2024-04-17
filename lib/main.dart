import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value;
            },
            decoration: InputDecoration(
              labelText: 'Почта',
            ),
          ),
          TextFormField(
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
            decoration: InputDecoration(
              labelText: 'Пароль',
            ),
          ),
          ElevatedButton(
            child: Text('Зарегестрироваться'),
            onPressed: () async {
              try {
                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
                            } catch (e) {
                print(e);
              }
            },
          ),
        ],
      ),
    );
  }
}
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value;
            },
            decoration: InputDecoration(
              labelText: 'Почта',
            ),
          ),
          TextFormField(
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
            decoration: InputDecoration(
              labelText: 'Пароль',
            ),
          ),
          ElevatedButton(
            child: Text('Войти'),
            onPressed: () async {
              try {
                final user = await _auth.signInWithEmailAndPassword(
                    email: email, password: password);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DatabaseScreen()),
                );
                            } catch (e) {
                print(e);
              }
            },
          ),
        ],
      ),
    );
  }
}





class DatabaseScreen extends StatefulWidget {
  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {

  final _firestore = FirebaseFirestore.instance;
  late String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление товара'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            onChanged: (value) {
              data = value;
            },
            decoration: InputDecoration(
              labelText: 'Введите данные',
            ),
          ),
          ElevatedButton(
            child: Text('Добавить'),
            onPressed: () {
              _firestore.collection('flower').add({
                'data': data,
              });
            },
          ),
          ElevatedButton(
            child: Text('firestorage'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirebaseStorageExample()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FirebaseStorageExample extends StatefulWidget {
  @override
  _FirebaseStorageExampleState createState() => _FirebaseStorageExampleState();
}

class _FirebaseStorageExampleState extends State<FirebaseStorageExample> {
  File _image = File('C:\\Users\\denmi\\OneDrive\\Desktop\\фцвыва.jpg');

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("toto/${DateTime.now()}.jpg");

      UploadTask uploadTask = ref.putFile(_image);

      await uploadTask.whenComplete(() => print('Файл загружен'));
    } else {
      print('Нет выбранных фотографий');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Storage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text('Нет выбранных фотографий.')
                : Image.network(_image.path),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Загрузить фото в папку "toto" в Firebase Storage'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final picker = ImagePicker();
          picker.pickImage(source: ImageSource.gallery);
        },
        tooltip: 'Выбрать фото',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
