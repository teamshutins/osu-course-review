import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 5.0,
            ),
            margin: EdgeInsets.only(top: 5.0, right: 5.0),
            decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: SingleChildScrollView(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                    child: Padding(
                    padding: const EdgeInsets.all(5.0),
                      child: Form(
                        key: _formKey,
                        child: Center(
                          child: Container(
                            child: TextFormField(
                              autofocus: true,
                              autocorrect: true,
                              maxLength: 200,
                              maxLines: 8,
                              decoration: InputDecoration(
                                labelText: "Write Review",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                ),
                              )
                            )
                          )
                        ),
                      )
                    ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0)),
                    ),
                    child: Text(
                      "Submit Review",
                      style: TextStyle(color: Colors.blue, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context); //This event handler should be used to submit the actual review.
                  },
                )
              ],
            ),
          ),
        ),
//Code below creates the X icon in the corner of the text input box.
          Positioned(
            right: 0.0,
            child: GestureDetector(
            onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}