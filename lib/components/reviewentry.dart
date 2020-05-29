import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomDialog extends StatefulWidget {
  
  final String courseId;
  CustomDialog({Key key, this.courseId}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormState>();
  String name = '';
  String review = '';

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
    return Container(
      margin: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Stack(
        children: [
          buildFormContainer(context),
          closePopup(context),
        ],
      ),
    );
  }

  Container buildFormContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0,),
      margin: EdgeInsets.only(top: 5.0, right: 5.0),
      decoration: providePopupDecoration(),
      child: buildSingleChildScrollView(context),
    );
  }

  BoxDecoration providePopupDecoration() {
    return BoxDecoration(
      color: Colors.orange,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 0.0, offset: Offset(0.0, 0.0),),],
    );
  }

  Widget buildSingleChildScrollView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildInputForm(true),
          buildInputForm(false),
          buildSubmitButton(context)
        ],
      ),
    );
  }

  Widget buildInputForm(bool isCommentField) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Stack(
          children: <Widget>[
            buildInputFieldContainer(isCommentField ? 150 : 42),
            buildInputFieldHint(isCommentField ? "Write Review" : "Reviewer Name"),
            buildInputField(isCommentField),
          ],
        )
      )
    );
  }

  Widget buildInputFieldContainer(double height) {
    return Container(
      width: double.infinity,
      height: height,
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(5),
        shape: BoxShape.rectangle,
      ),
    );
  }

  Widget buildInputFieldHint(String inputFieldHint) {
    return Positioned(
      left: 50, top: 12,
      child: Container(
        padding: EdgeInsets.only(bottom: 0, left: 0, right: 0),
        color: Colors.orange,
        child: Text(inputFieldHint, style: TextStyle(color: Colors.black, fontSize: 10),
        ),
      )
    );
  }

  Widget buildInputField(bool isCommentField) {
    return Positioned(
      left: 21, right: 21, top: 21, bottom: isCommentField ? 0 : 2,
      child: Form(
        key: isCommentField ? _formKey : _nameKey,
        child: Center(
          child: Container(
            child: buildTextFormField(isCommentField)
          )
        )
      )
    );
  }

  Widget buildTextFormField(bool isCommentField) {
    return TextFormField(
      validator: (val) => val.isEmpty ? (isCommentField ? 'Enter a review' : 'Enter a name') : null,
      onChanged: (String val) { isCommentField ? review = val : name = val; },
      autocorrect: true,
      autofocus: true,
      maxLength: isCommentField ? 200 : 30,
      maxLines: isCommentField ? 6 : 1,
      decoration: InputDecoration(
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 17)
      ),
    );
  }

  //This section of code manipulates the "Submit Review" portion of the popup
  Widget buildSubmitButton(BuildContext context) {
    final CollectionReference reviewCollection = Firestore.instance.collection('reviews');
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
        ),
        child: Text("Submit Review", style: TextStyle(color: Colors.blue, fontSize: 25.0), textAlign: TextAlign.center,),
      ),
      onTap: () {
        if(_formKey.currentState.validate() && _nameKey.currentState.validate()) {
          reviewCollection.document().setData({
            'comment': review,
            'dateTime': DateTime.now(),
            'id': widget.courseId,
            'name': name,
          });
          Navigator.pop(context);
        }
      },
    );
  }
  
  //Code below creates the X icon in the corner of the text input box.
  Widget closePopup(BuildContext context) {
    return Positioned(
      right: 0.0,
      child: GestureDetector(
      onTap: () { Navigator.of(context).pop(); },
        child: Align(
          alignment: Alignment.topRight,
          child: CircleAvatar(radius: 14.0, backgroundColor: Colors.white, child: Icon(Icons.close, color: Colors.red),),
        ),
      ),
    );
  }
}