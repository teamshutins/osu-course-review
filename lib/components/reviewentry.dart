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
      color: Colors.orange[300],
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
          buildReviewField(),
          buildNameField(),
          buildSubmitButton(context)
        ],
      ),
    );
  }

  Widget buildReviewField() {
    return Form(
      autovalidate: true,
      key: _formKey,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: buildReviewTextFormField(),
        )
      )
    );
  }

  Widget buildReviewTextFormField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? 'Enter a review' : null,
      onChanged: (String val) { review = val; },
      autocorrect: true,
      autofocus: true,
      maxLength: 200,
      maxLines: 5,
      decoration: InputDecoration(
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        fillColor: Colors.white,
        filled: true,
//        contentPadding: EdgeInsets.only(top: 10, bottom: 5),//symmetric(vertical: 10),
        labelText: 'Write Review',
      ),
    );
  }

  Widget buildNameField() {
    return Form(
      autovalidate: true,
      key: _nameKey,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: buildNameTextFormField(),
        )
      )
    );
  }

  Widget buildNameTextFormField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? 'Enter a name' : null,
      onChanged: (String val) { name = val; },
      autocorrect: true,
//      autofocus: true,
      maxLength: 30,
      maxLines: 1,
      decoration: InputDecoration(
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        fillColor: Colors.white,
        filled: true,
//        contentPadding: EdgeInsets.only(top: 10, bottom: 5),//symmetric(vertical: 10),
        labelText: 'Your Name',
      ),
    ); 
  }

  //This section of code manipulates the "Submit Review" portion of the popup
  Widget buildSubmitButton(BuildContext context) {
    final CollectionReference reviewCollection = Firestore.instance.collection('reviews');
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
        ),
        child: Text("Submit Review", style: TextStyle(color: Colors.blue, fontSize: 25.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
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