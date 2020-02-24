import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/sv_firestore.dart';
import '../services/sv_storage.dart';

class AudioX extends StatelessWidget {
  delete(String folder, DocumentSnapshot data) async {
    try {
      await SvFirestore().delete(folder, data.documentID);
      print('deleted from firestore');
      await SvStorage().delete(folder, data['fileName']);
      print('deleted from storage');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: SvFirestore().streamAllDoc('audios'),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var _data = snapshot.data.documents;
          if (_data.length == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('no audio file'),
              ],
            );
          }
          return ListView.builder(
            itemCount: _data.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(3.0),
                color: Colors.grey[300],
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                  leading: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      delete('audios', _data[index]);
                    },
                  ),
                  title: Text(_data[index]['fileName']),
                ),
              );
            },
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 40.0,
              height: 40.0,
              child: Container(child: CircularProgressIndicator()),
            ),
          ],
        );
      },
    );
  }
}
