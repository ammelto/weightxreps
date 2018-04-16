import 'package:flutter/material.dart';
import 'package:kinoweights/data/api/weightxreps.dart';
import 'package:kinoweights/data/entities/summary.dart';
import 'package:kinoweights/data/entities/workout.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kinoweights/ui/widget/barbell.dart';

class Feed extends StatefulWidget {
  Feed({Key key, this.color}) : super(key: key);
  final Color color;
  @override
  _Feed createState() => new _Feed();
}

class _Feed extends State<Feed> with TickerProviderStateMixin {

  var communityApi = new CommunityApi();

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new FutureBuilder<List<Summary>>(
          future: communityApi.fetchSummary(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new StaggeredGridView.countBuilder(
                crossAxisCount: 100,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) => createCardFromSummary(snapshot.data[index]),
                staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(50, calculateSize(snapshot.data[index])),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              );
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return new CircularProgressIndicator();
          },
        ),
      ),
    );
  }
  
  int calculateSize(Summary summary){
    int size = 50;
    if(summary.comment != " " && summary.comment != "") size+= (summary.comment.length / 25).floor() * 5;
    size += summary.workouts.length * 12;
    return size;
  }

  Card createCardFromSummary(Summary summary){
    return new Card(
      child: new Container(
        child: new Column(
          children: [
            new Row(
              children: <Widget>[
                new Expanded(child:
                  new Image.network(
                    summary.avatar,
                    height: 120.0,
                    fit: BoxFit.cover,
                  )
                )
              ],
            ),
            new Row(
              children: <Widget>[
                new Expanded(child:
                  new Container(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(summary.name,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          getCountryFlag(summary.country)
                        ],
                      )
                  ),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Expanded(child:
                  new Container(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(summary.age != null ? summary.age + " years" : "?",
                          textAlign: TextAlign.end,
                          style: new TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                        new Text(summary.bodyweight != null ? summary.bodyweight + " kg" : "?",
                          textAlign: TextAlign.end,
                          style: new TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ],
            ),
            new Column(
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: new Text(
                      summary.comment,
                      softWrap: true,
                      style: new TextStyle(
                        fontStyle: FontStyle.italic
                      ),
                    ),
                ),
              ],
            ),
            generateBarbells(summary.workouts)
          ],
        ),
      ),
    );
  }
  
  Widget getCountryFlag(String code){
    if(code != null){
      return new Image.network(
        "http://www.countryflags.io/" + code + "/flat/64.png", 
        height: 16.0,
        alignment: Alignment.topRight,
      );
    }else{
      return new Text("?",
        style: new TextStyle(
          color: Colors.grey[500],
        ),
      );
    }
  }

  Widget generateBarbells(List<Workout> workouts){
    List<Widget> widgets = new List();

    for(var workout in workouts){
      widgets.add(new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Align(
            child:
              new Container(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                child: new Text(
                  workout.name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            alignment: Alignment.centerLeft,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                  child: new Container(
                      padding: const EdgeInsets.only(bottom: 12.0, left: 16.0, right: 16.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(workout.weight.toString() + " kg",
                            textAlign: TextAlign.start,
                            style: new TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                          new Text("x" + workout.quantity.toString(),
                            textAlign: TextAlign.end,
                            style: new TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      )
                  ),
              )
            ],
          ),
        ],
      ));
    }
    
    return new Column(
      children: widgets,
    );
  }


}