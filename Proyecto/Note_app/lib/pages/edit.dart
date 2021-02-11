import 'package:flutter/material.dart';
import 'package:Note_app/models/note.dart';
import 'package:Note_app/service/db.dart';
import 'package:Note_app/widgets/loading.dart';

class Edit extends StatefulWidget {
  final Note note;
  Edit({this.note});

  @override
  EditState createState() => EditState();
}

class EditState extends State<Edit> {
  TextEditingController title, content;
  bool loading = false, editmode = false;

  @override
  void initState() {
    super.initState();
    title = new TextEditingController(text: 'Titulo');
    content = new TextEditingController(text: 'Contenido');
    if (widget.note.id != null) {
      editmode = true;
      title.text = widget.note.title;
      content.text = widget.note.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editmode ? 'Editar' : 'Crear'),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              setState(() => loading = true);
              save();
            },
          ),
          if (editmode)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() => loading = true);
                delete();
              },
            ),
        ],
      ),
      body: loading
          ? Loading()
          : ListView(
              padding: EdgeInsets.all(13.0),
              children: <Widget>[
                TextField(controller: title),
                SizedBox(height: 10.0),
                TextField(
                  controller: content,
                  maxLines: 27,
                ),
              ],
            ),
    );
  }

  Future<void> save() async {
    if (title.text != '') {
      widget.note.title = title.text;
      widget.note.content = content.text;
      if (editmode)
        await DB().update(widget.note);
      else
        await DB().add(widget.note);
      Navigator.pop(context);
    }
    setState(() => loading = false);
  }

  Future<void> delete() async {
    await DB().delete(widget.note);
    Navigator.pop(context);
  }
}
