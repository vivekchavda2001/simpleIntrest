import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Intrest Calculator",
    home: SIForm(),
    theme: ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.indigo,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIForm();
  }
}

class _SIForm extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pounds', 'others'];
  var _curruntIteamSelected = 'Rupees';
  var status = '1';
  final _minimumPadding = 5.0;
  TextEditingController pTextEditingController = TextEditingController();
  TextEditingController rTextEditingController = TextEditingController();
  TextEditingController nTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Intrest Calculator"),
      ),
      body: Form(
        //margin: EdgeInsets.all(_minimumPadding * 2),
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
          children: <Widget>[
            getImage(),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: pTextEditingController,
                    validator: (String value){
                      if (value.isEmpty){
                        return 'Please Enter Principal';
                      }
                    },
                  decoration: InputDecoration(
                      hintText: 'Enter Principal e.g.12000',
                      labelText: 'Principal',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: rTextEditingController,
                  validator: (String value){
                    if (value.isEmpty){
                      return 'Please Enter Rate in Percentage';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'In Percentage',
                      labelText: 'Rate',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Row(
              children: <Widget>[
                Expanded(
                    child: TextFormField(
                  style: textStyle,
                  controller: nTextEditingController,
                      validator: (String value){
                        if (value.isEmpty){
                          return 'Please Enter Time Period';
                        }
                      },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Term',
                      labelText: 'Time In Years',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
                Container(
                  width: _minimumPadding * 5,
                ),
                Expanded(
                    child: DropdownButton<String>(
                  items: _currencies.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: _curruntIteamSelected,
                  onChanged: (String newValueSelected) {
                    // Your code to execute, when a menu item is selected from dropdown
                    setState(() {
                      this._curruntIteamSelected = newValueSelected;
                    });
                  },
                ))
              ],
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text(
                        'Calculate',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            this.status = finalResult();
                          }
                        });
                      },
                    )),
                    Container(
                      width: _minimumPadding * 5,
                    ),
                    Expanded(
                        child: RaisedButton(
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      child: Text(
                        'Reset',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ))
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(_minimumPadding * 5),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Times New Roman',
                  color: Colors.indigo,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  String finalResult() {
    double principal = double.parse(pTextEditingController.text);
    double roi = double.parse(rTextEditingController.text);
    double term = double.parse(nTextEditingController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_curruntIteamSelected';
    return result;
  }

  Widget getImage() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 5),
    );
  }

  void _reset() {
    pTextEditingController.text = '';
    rTextEditingController.text = '';
    nTextEditingController.text = '';
    _curruntIteamSelected = _currencies[0];
  }
}
