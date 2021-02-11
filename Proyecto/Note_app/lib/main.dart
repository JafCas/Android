  
import 'package:flutter/material.dart';
import 'package:Note_app/pages/home.dart';


void main() => runApp(NoteUp());

class NoteUp extends StatelessWidget {
		@override
		Widget build(BuildContext context) {
				return MaterialApp(
						title: 'NoteUp',
						debugShowCheckedModeBanner: false,
						home: Home(),
				);
		}
}