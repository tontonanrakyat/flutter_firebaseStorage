import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/sv_firestore.dart';
import '../services/sv_storage.dart';

class GridX extends StatelessWidget {
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
      stream: SvFirestore().streamAllDoc('images'),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var _list = snapshot.data.documents;
          return GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(3.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3.0,
            ),
            itemCount: _list.length,
            itemBuilder: (context, index) {
              var _data = _list[index];
              return InkWell(
                child: GridTile(
                  child: Image.network(_data['fileUrl']),
                ),
                onTap: () {
                  delete('images', _data);
                },
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
