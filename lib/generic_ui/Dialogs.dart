import 'package:dixapp/generic_ui/cancel.dart';
import 'package:dixapp/generic_ui/confirm.dart';
import 'package:dixapp/generic_ui/success.dart';
import 'package:flutter/material.dart';
import 'package:dixapp/util/Constants.dart';

class Dialogs{


  static displayList(BuildContext context, String title, List<String> list, Function onItemSelected){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text(title, style: new TextStyle(fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold),),
            content: Container(
              width: MediaQuery.of(context).size.width,
              height: 110.0,
              child: ListView(
                children: list.map((e)=>
                   new Column(
                     children: <Widget>[
                       ListTile(
                         title: Text(e, style: new TextStyle(fontFamily: "${Constants.MAIN_FONT_FAMILY}"),),
                        onTap: (){
                          Navigator.pop(context);
                          onItemSelected(list.indexOf(e));
                        },
                       ),
                       Divider()
                    ],
                   )

                ).toList(),

              ),
            ),
            actions: <Widget>[
            ],
          );
        }
    );
  }

  static info(BuildContext context, String title, String description){
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: new Text(title, style: new TextStyle(fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description==null?'':description, style: new TextStyle(fontFamily: "${Constants.MAIN_FONT_FAMILY}"),)
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: ()=> Navigator.pop(context),
              child: new Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0)),
                child: new Text("OK", style: new TextStyle(color: Colors.white, fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold),),
              ),
            )
          ],
        );
      }
    );
  }

  static infoWithAction(BuildContext context, String title, String description, Function onAction){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text(title, style: new TextStyle(fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold),),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description==null?'':description, style: new TextStyle(fontFamily: "${Constants.MAIN_FONT_FAMILY}"),)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  onAction();
                },
                child: new Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0)),
                  child: new Text("OK", style: new TextStyle(color: Colors.white, fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold),),
                ),
              )
            ],
          );
        }
    );
  }

  static error(BuildContext context, String title, String description,Function retry, Function okeyAction  ){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text(title, style: new TextStyle(fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold),),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description==null?'':description, style: new TextStyle(fontFamily: "${Constants.MAIN_FONT_FAMILY}"),)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                      Navigator.pop(context);
                      okeyAction();
                },
                child: new Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0)),
                  child: new Text("OK", style: new TextStyle(color: Colors.white, fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold),),
                ),
              ),

              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  retry();
                },
                child: new Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(5.0)),
                  child: new Text("Réessayer", style: new TextStyle(color: Colors.white, fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold),),
                ),
              )
            ],
          );
        }
    );
  }

  static confirm(BuildContext context, String title, String description,Function cancel, Function okeyAction  ){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text(title, style: new TextStyle(fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold, fontSize: 18.0),),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description==null?'':description, style: new TextStyle(fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontSize: 16.0),)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  okeyAction();
                },
                child: new Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0)),
                  child: new Text('Confirmer', style: new TextStyle(color: Colors.white, fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold),),
                ),
              ),

              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  cancel();
                },
                child: new Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(5.0)),
                  child: new Text("Annuler", style: new TextStyle(color: Colors.white, fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold),),
                ),
              )
            ],
          );
        }
    );
  }



  static simpleError(BuildContext context, String title, String description, Function okeyAction  ){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text(title, style: new TextStyle(fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold),),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description==null?'':description, style: new TextStyle(fontFamily: "${Constants.MAIN_FONT_FAMILY}"),)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  okeyAction();
                },
                child: new Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0)),
                  child: new Text("OK", style: new TextStyle(color: Colors.white, fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold),),
                ),
              ),


            ],
          );
        }
    );
  }

  static prompt(BuildContext context, String title, Function okeyAction  ){

    TextEditingController _textFieldController = TextEditingController();

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text(title, style: new TextStyle(fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold),),
            content:  TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Montant",hintStyle:new TextStyle(fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold) ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  okeyAction(_textFieldController.text.toString()
                  );
                },
                child: new Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0)),
                  child: new Text("Ok", style: new TextStyle(color: Colors.white, fontFamily: "${Constants.MAIN_FONT_FAMILY}", fontWeight: FontWeight.bold),),
                ),
              ),


            ],
          );
        }
    );
  }


  static showSuccess(BuildContext context, String title, String description, Function okeyAction  ){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            color: Colors.transparent,
            child: new Padding(
              padding: new EdgeInsets.all(40.0),
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                body: new Center(
                    child: new ClipRRect(
                      borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                      child: new Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: new Padding(
                            padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new SizedBox(
                                  width: 64.0,
                                  height: 64.0,
                                  child: new SuccessView(),
                                ),

                                new Text(
                                  title,
                                  style: new TextStyle(fontSize: 25.0, color: Colors.black, fontFamily: "${Constants.MAIN_FONT_FAMILY}",),
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(top: 10.0),
                                  child: new Text(
                                    description==null?'':description,
                                    style: new TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: "${Constants.MAIN_FONT_FAMILY}",),textAlign: TextAlign.center,
                                  ),
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(top: 10.0),
                                  child: new RaisedButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                      okeyAction();
                                    },
                                    color: Colors.green,
                                    child: new Text(
                                      "Ok",
                                      style: new TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "${Constants.MAIN_FONT_FAMILY}",),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          )
                      ),
                    )),
              ),
            ),
          );
        }
    );
  }

  static showCancel(BuildContext context, String title, String description, Function okeyAction  ){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            color: Colors.transparent,
            child: new Padding(
              padding: new EdgeInsets.all(40.0),
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                body: new Center(
                    child: new ClipRRect(
                      borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                      child: new Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: new Padding(
                            padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new SizedBox(
                                  width: 64.0,
                                  height: 64.0,
                                  child: new CancelView(),
                                ),

                                new Text(
                                  title,
                                  style: new TextStyle(fontSize: 25.0, color: Colors.black, fontFamily: "${Constants.MAIN_FONT_FAMILY}",),
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(top: 10.0),
                                  child: new Text(
                                    description==null?'':description,
                                    style: new TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: "${Constants.MAIN_FONT_FAMILY}",),textAlign: TextAlign.center,
                                  ),
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(top: 10.0),
                                  child: new RaisedButton(
                                    onPressed: okeyAction,
                                    color: Colors.green,
                                    child: new Text(
                                      "Ok",
                                      style: new TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "${Constants.MAIN_FONT_FAMILY}",),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          )
                      ),
                    )),
              ),
            ),
          );
        }
    );
  }

  static showConfirm(BuildContext context, String title, String description, Function positiveAction , Function negativeAction ){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            color: Colors.transparent,
            child: new Padding(
              padding: new EdgeInsets.all(40.0),
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                body: new Center(
                    child: new ClipRRect(
                      borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                      child: new Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: new Padding(
                            padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new SizedBox(
                                  width: 64.0,
                                  height: 64.0,
                                  child: new ConfirmView(),
                                ),

                                new Text(
                                  title,
                                  style: new TextStyle(fontSize: 25.0, color: Colors.black, fontFamily: "${Constants.MAIN_FONT_FAMILY}",),
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(top: 10.0),
                                  child: new Text(
                                    description==null?'':description,
                                    style: new TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: "${Constants.MAIN_FONT_FAMILY}",),textAlign: TextAlign.center,
                                  ),
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(top: 10.0, left: 20, right: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new RaisedButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                          positiveAction();
                                        },
                                        color: Colors.green,
                                        child: new Text(
                                          "Confirmer",
                                          style: new TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "${Constants.MAIN_FONT_FAMILY}",),
                                        ),
                                      ),
                                      new RaisedButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                          negativeAction();
                                        },
                                        color: Colors.orange,
                                        child: new Text(
                                          "Annuler",
                                          style: new TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "${Constants.MAIN_FONT_FAMILY}",),
                                        ),
                                      )
                                    ],
                                  ),
                                )

                              ],
                            ),
                          )
                      ),
                    )),
              ),
            ),
          );
        }
    );
  }

  static customViewDialog(BuildContext context, {String title = '', String message = '', String negativeButtonLabel = 'BACK', String positiveButtonLabel = 'DONE', Function onNegative , Function onPositive, Widget customWidget}){


    return showDialog(
        context:context,
        barrierDismissible: false,
        builder: (BuildContext ctx){
          return new Container(

              padding: EdgeInsets.all(20.0),
              color: Colors.transparent,

              child: new Scaffold(
                backgroundColor: Colors.transparent,
                body:  new Center(
                    child: SingleChildScrollView(
                      child: new ClipRRect(
                        borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
                        child: new Container(
                          padding: EdgeInsets.only(top: 40.0, bottom: 40.0 , left: 20.0, right: 20.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white
                          ),
                          child: new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[

                              new Container(
                                child:  new Text(title, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(ctx).primaryColor, fontWeight: FontWeight.bold, fontSize: 18.0, fontFamily: Constants.MAIN_FONT_FAMILY),),
                              ),

                              new SizedBox(height: 30.0,),

                              message.isEmpty ? new Container() :  new Container(
                                child:new Text(message, textAlign: TextAlign.center, style: TextStyle( fontSize: 16.0, fontFamily: Constants.MAIN_FONT_FAMILY),),
                              ),

                              message.isEmpty ? new Container() : new SizedBox(height: 10.0,),



                              customWidget == null ? new Container() : customWidget,

                              new SizedBox(height: 30.0,),

                              new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  new Container(
                                    child: RaisedButton(
                                      onPressed: (){

                                        Navigator.pop(ctx);

                                        onNegative();

                                      },
                                      shape: OutlineInputBorder(
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                          borderRadius: BorderRadius.circular(30.0)
                                      ),
                                      color: Colors.white,
                                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 25.0, right: 25.0),
                                      child: Text(negativeButtonLabel, style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: Constants.MAIN_FONT_FAMILY, fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                  new Container(
                                    child: RaisedButton(
                                      onPressed: (){
                                        Navigator.pop(ctx);

                                        onPositive();


                                      },
                                      shape: OutlineInputBorder(
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                          borderRadius: BorderRadius.circular(30.0)
                                      ),
                                      color: Theme.of(context).primaryColor,
                                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 25.0, right: 25.0),
                                      child: Text(positiveButtonLabel, style: TextStyle(color: Colors.white, fontFamily: Constants.MAIN_FONT_FAMILY, fontWeight: FontWeight.bold),),
                                    ),
                                  ),


                                ],
                              ),

                              new SizedBox(height: 10.0,),


                            ],
                          ),
                        ),
                      ),
                    )
                ),
              )
          );
        }

    );
  }


}