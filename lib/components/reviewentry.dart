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
    final _nameKey = GlobalKey<FormState>();
    return Container(
      margin: EdgeInsets.only(left: 5.0, right: 5.0),
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
//This section of code handles the Write Review portion of the popup box.     
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 150,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            padding: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(5),
                              shape: BoxShape.rectangle,
                            ),                                                 
                          ),
                          Positioned(
                            left: 50,
                            top: 12,
                            child: Container(
                              padding: EdgeInsets.only(bottom: 0, left: 0, right: 0),
                              color: Colors.orange,
                              child: Text(
                                "Write Review",
                                style: TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            )
                          ),
                          Positioned(
                            left: 21,
                            right: 21,
                            top: 21,
                            bottom: 0,
                            child: Form(
                              key: _formKey,
                              child: Center(
                                child: Container(
                                  child: TextFormField(
                                    autocorrect: true,
                                    autofocus: true,
                                    maxLength: 200,
                                    maxLines: 6,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0)
                                        ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: 17)
                                      ),
                                    )
                                  )
                                )
                              ),
                            ),
                          ],
                      )
                    )
                  ),
//This section of code handles the Reviewer Name input box
                  Center(
                    child: Padding(
                    padding: const EdgeInsets.all(1.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 42,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            padding: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(5),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          Positioned(
                            left: 50,
                            top: 12,
                            child: Container(
                              padding: EdgeInsets.only(bottom: 0, left: 0, right: 0),
                              color: Colors.orange,
                              child: Text(
                                "Reviewer Name",
                                style: TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            )
                          ),
                          Positioned(
                            left: 21,
                            right: 21,
                            top: 21,
                            bottom: 2,
                            child: Form(
                              key: _nameKey,
                              child: Center(
                                child: Container(
                                  child: TextFormField(
                                    autocorrect: true,
                                    autofocus: true,
                                    maxLength: 30,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0)
                                          ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: 17)
                                      ),
                                  )
                                )
                              )
                            )
                          )
                        ],
                      ),
                    )
                  ),
//This section of code manipulates the "Submit Review" portion of the popup
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


