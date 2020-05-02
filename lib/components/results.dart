
import 'package:flutter/material.dart';

class SearchList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return Column(       
      children: [     
        Container(
          height: 50,
          color: Colors.amber[600],
          child: const Center(child: Text('SOFTWARE ENGINEERING I (CS_361_400_S2020_Lara_Letaw)')),
        ),
        Container(
          height: 50,
          color: Colors.amber[500],
          child: const Center(child: Text('SOFTWARE ENGINEERING I (CS_361_401_S20200_Kevin_Lee)')),
        ),
        Container(
          height: 50,
          color: Colors.amber[100],
          child: const Center(child: Text('SOFTWARE ENGINEERING I (CS_361_402_S20200_Taka_Watanabe)')),
        ),
      ]             
    );
  }
}

// class SearchList extends StatefulWidget {
//   SearchList({ Key key }) : super(key: key);
//   @override
//   _SearchListState createState() => new _SearchListState();

// }

// class _SearchListState extends State<SearchList>
// {
//   Widget appBarTitle = new Text("OSU Course Review", style: new TextStyle(color: Colors.white),);
//   Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
//   final key = new GlobalKey<ScaffoldState>();
//   final TextEditingController _searchQuery = new TextEditingController();
//   List<String> _list;
//   bool _isSearching;
//   String _searchText = "";

//   _SearchListState() {
//     _searchQuery.addListener(() {
//       if (_searchQuery.text.isEmpty) {
//         setState(() {
//           _isSearching = false;
//           _searchText = "";
//         });
//       }
//       else {
//         setState(() {
//           _isSearching = true;
//           _searchText = _searchQuery.text;
//         });
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _isSearching = false;
//     init();

//   }

//   void init() {
//     _list = List();
//     _list.add("CS 161");
//     _list.add("CS 162");
//     _list.add("CS 225");
//     _list.add("CS 271");
//     _list.add("CS 261");
//     _list.add("CS 290");
//     _list.add("CS 340");
//     _list.add("CS 361");
//     _list.add("CS 325");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       key: key,
//       appBar: buildBar(context),
//       body: new ListView(
//         padding: new EdgeInsets.symmetric(vertical: 8.0),
//         children: _isSearching ? _buildSearchList() : _buildList(),
//       ),
//     );
//   }

//   List<ChildItem> _buildList() {
//     return _list.map((contact) => new ChildItem(contact)).toList();
//   }

//   List<ChildItem> _buildSearchList() {
//     if (_searchText.isEmpty) {
//       return _list.map((contact) => new ChildItem(contact))
//           .toList();
//     }
//     else {
//       List<String> _searchList = List();
//       for (int i = 0; i < _list.length; i++) {
//         String  name = _list.elementAt(i);
//         if (name.toLowerCase().contains(_searchText.toLowerCase())) {
//           _searchList.add(name);
//         }
//       }
//       return _searchList.map((contact) => new ChildItem(contact))
//           .toList();
//     }
//   }

//   Widget buildBar(BuildContext context) {
//     return new AppBar(
//         centerTitle: true,
//         title: appBarTitle,
//         actions: <Widget>[
//           new IconButton(icon: actionIcon, onPressed: () {
//             setState(() {
//               if (this.actionIcon.icon == Icons.search) {
//                 this.actionIcon = new Icon(Icons.close, color: Colors.white,);
//                 this.appBarTitle = new TextField(
//                   controller: _searchQuery,
//                   style: new TextStyle(
//                     color: Colors.white,

//                   ),
//                   decoration: new InputDecoration(
//                       prefixIcon: new Icon(Icons.search, color: Colors.white),
//                       hintText: "Course number or professor...",
//                       hintStyle: new TextStyle(color: Colors.white)
//                   ),
//                 );
//                 _handleSearchStart();
//               }
//               else {
//                 _handleSearchEnd();
//               }
//             });
//           },),
//         ]
//     );
//   }

// //Changes the state of the program to show the list of available courses while searching.
//   void _handleSearchStart() {
//     setState(() {
//       _isSearching = true;
//     });
//   }

// //Changes the state of the program to clear the screen body and revert to the standard header if there is no active search.
//   void _handleSearchEnd() {
//     setState(() {
//       this.actionIcon = new Icon(Icons.search, color: Colors.white,);
//       this.appBarTitle =
//       new Text("OSU Course Explorer", style: new TextStyle(color: Colors.white),);
//       _isSearching = false;
//       _searchQuery.clear();
//     });
//   }

// }

// class ChildItem extends StatelessWidget {
//   final String name;
//   ChildItem(this.name);
//   @override
//   Widget build(BuildContext context) {
//     return new ListTile(title: new Text(this.name));
//   }
// }