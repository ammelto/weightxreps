import 'package:flutter/material.dart';
import 'dart:collection';

class Logs extends StatefulWidget {
  Logs({Key key, this.color}) : super(key: key);
  final Color color;
  @override
  _Logs createState() => new _Logs();
}

class Day extends StatelessWidget{

  final bool selected;
  final bool parent;
  final String date;
  final bool sticky;

  Day({this.selected = false, this.date, this.parent = false, this.sticky = false});

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: getColor(),
      ),
      width: sticky ? 56.0 : 60.0,
      height: 60.0,
      child: new Center(
        child: new Container(
          padding: sticky ? new EdgeInsets.only(left: 4.0) : null,
          child: new Text(date, style:
            new TextStyle(
              color: getTextColor(),
            ),
          )
        ),
      ),
    );
  }

  Color getColor(){
    if(selected) return Colors.deepPurple;
    else if(parent) return Colors.greenAccent;
    else return null;
  }

  Color getTextColor(){
    if(selected) return Colors.white;
    else if(parent) return Colors.black87;
    else return null;
  }
}

enum CalendarStates {day, month, year}

class _Logs extends State<Logs> with TickerProviderStateMixin {

  final List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  CalendarStates calendarState = CalendarStates.day;
  DateTime today = new DateTime.now();
  DateTime selectedDay = new DateTime.now();
  DateTime yearToBrowse = new DateTime.now();
  DateTime dayLazyLoadForward = new DateTime.now();
  DateTime dayLazyLoadReverse = new DateTime.now();
  ScrollController controller = new ScrollController();
  LinkedHashMap<int, Queue<Widget>> scrollViewsLists = new LinkedHashMap<int, Queue<Widget>>();
  int currentYear = 0;
  double posTop;
  double posBot;
  double statusBarHeight;
  bool addDaysToStart = false;
  bool fixedHeader = false;
  bool skipRender = false;

  @override
  void initState() {
    super.initState();
    currentYear = today.year;
    controller.addListener((){
      if(controller.position.atEdge){
        if(controller.position.extentAfter < 10){
          if(calendarState == CalendarStates.day){
            setState(() {
              addDaysToStart = false;
              if(dayLazyLoadForward.month == 12){
                dayLazyLoadForward = new DateTime(dayLazyLoadForward.year + 1, 1, 1);
              }else{
                dayLazyLoadForward = new DateTime(dayLazyLoadForward.year, dayLazyLoadForward.month + 1, 1);
              }
            });
          }
        }else{
          if(calendarState == CalendarStates.day){
            setState(() {
              addDaysToStart = true;
              if(dayLazyLoadReverse.month == 1){
                dayLazyLoadReverse = new DateTime(dayLazyLoadReverse.year - 1, 12, 1);
              }else{
                dayLazyLoadReverse = new DateTime(dayLazyLoadReverse.year, dayLazyLoadReverse.month - 1, 1);
              }
              controller.jumpTo(60.0 * 30.0);
            });
          }
        }
      }

      if(fixedHeader){
        setState(() {
          fixedHeader = false;
          skipRender = true;
        });
      }

      if(posTop != null && controller.position.extentBefore - 120.0 - (statusBarHeight * 2) > posTop){
        setState(() {
          posBot = posTop;
          posTop = null;
          currentYear++;
        });
      }else if(posBot != null && controller.position.extentBefore - 120.0 - (statusBarHeight * 2) < posBot){
        setState(() {
          posBot = null;
          currentYear--;
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;

    return new Scaffold(
      body: new Container(
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: Container(
                decoration: new BoxDecoration(
                  border: new Border.all(
                    color: Colors.deepPurple,
                    width: 3.0
                  ),
                  color: Colors.deepPurple
                ),
              ),
            ),
            new Container(
              width: 60.0,
              child: generateDayScroller(),
            )
          ],
        )
      )
    );
  }

  Widget generateMonthScroller(){
    List<Widget> days = new List();
    DateTime dateToCompare = new DateTime(yearToBrowse.year,yearToBrowse.month,1);
    days.add(getTileForDate(yearToBrowse.year.toString(), false, true, yearToBrowse, CalendarStates.year));

    while(dateToCompare.month < 12){
      if(yearToBrowse.year == selectedDay.year && dateToCompare.month == selectedDay.month){
        days.add(getTileForDate(months[dateToCompare.month - 1], true, false, dateToCompare, CalendarStates.day));
      }else{
        days.add(getTileForDate(months[dateToCompare.month - 1], false, false, dateToCompare, CalendarStates.day));
      }
      dateToCompare = new DateTime(yearToBrowse.year, dateToCompare.month + 1, 1);
    }
    return new GridView.count(crossAxisCount: 1, children: days,);
  }

  Widget generateYearScroller(){

    List<Widget> days = new List();
    for(int i = today.year; i >= 1990; i--){
      if(i == selectedDay.year){
        days.add(getTileForDate(i.toString(), true, false, new DateTime(i), CalendarStates.month));
      }else{
        days.add(getTileForDate(i.toString(), false, false, new DateTime(i), CalendarStates.month));
      }
    }

    return new GridView.count(crossAxisCount: 1, children: days,);
  }

  Widget generateDayScroller(){

    if(addDaysToStart && !skipRender){
      scrollViewsLists.putIfAbsent(dayLazyLoadReverse.year, () => new Queue());
      Queue<Widget> days = scrollViewsLists.remove(dayLazyLoadReverse.year);

      DateTime dateToCompare = new DateTime(dayLazyLoadReverse.year,dayLazyLoadReverse.month + 1,1);
      dateToCompare = dateToCompare.add(new Duration(days: -1));
      double jumpTo = 120.0;

      while(dateToCompare.month == dayLazyLoadReverse.month){
        if(dateToCompare.day == selectedDay.day && dateToCompare.month == selectedDay.month && dateToCompare.year == selectedDay.year){
          days.addFirst(getTileForDate(dateToCompare.day.toString(), true, false, dateToCompare, CalendarStates.day));
        }else{
          days.addFirst(getTileForDate(dateToCompare.day.toString(), false, false, dateToCompare, CalendarStates.day));
        }
        jumpTo = jumpTo + 60.0;
        dateToCompare = dateToCompare.add(new Duration(days: -1));
      }

      fixedHeader = true;
      days.addFirst(getTileForDate(months[dayLazyLoadReverse.month - 1], false, true, yearToBrowse, CalendarStates.month));

      scrollViewsLists.putIfAbsent(dayLazyLoadReverse.year, () => days);
    }else if(!skipRender){
      scrollViewsLists.putIfAbsent(dayLazyLoadForward.year, () => new Queue());
      Queue<Widget> days = scrollViewsLists.remove(dayLazyLoadForward.year);

      days.addLast(getTileForDate(months[dayLazyLoadForward.month - 1], false, true, yearToBrowse, CalendarStates.month));
      DateTime dateToCompare = new DateTime(dayLazyLoadForward.year,dayLazyLoadForward.month,1);

      while(dateToCompare.month == dayLazyLoadForward.month){
        if(dateToCompare.day == selectedDay.day && dateToCompare.month == selectedDay.month && dateToCompare.year == selectedDay.year){
          days.addLast(getTileForDate(dateToCompare.day.toString(), true, false, dateToCompare, CalendarStates.day));
        }else{
          days.addLast(getTileForDate(dateToCompare.day.toString(), false, false, dateToCompare, CalendarStates.day));
        }
        dateToCompare = dateToCompare.add(new Duration(days: 1));
      }
      scrollViewsLists.putIfAbsent(dayLazyLoadForward.year, () => days);
    }else{
      skipRender = false;
    }

    return new CustomScrollView(
      slivers: squashList(),
      controller: controller,
    );
  }

  List<Widget> squashList(){
    List<Widget> scrollList = new List();
    scrollList.add(
        new SliverAppBar(
          actions: <Widget>[
            getTileForDate(currentYear.toString() , false, true, yearToBrowse, CalendarStates.year, true)
          ],
          floating: true,
          snap: true,
          pinned: fixedHeader,
          backgroundColor: Theme.of(context).accentColor,
        ));

    var sortedKeys = scrollViewsLists.keys.toList()..sort();

    sortedKeys.forEach( (year) {
      if(currentYear != year){
        if(year > currentYear) posTop = (scrollViewsLists[year - 1].length) * 60.0;
        scrollList.add(
        new SliverAppBar(
          actions: <Widget>[
            getTileForDate(year.toString(), false, true, yearToBrowse, CalendarStates.year, true)
          ],
          floating: false,
          backgroundColor: Theme.of(context).accentColor,
          ));
      }
        scrollList.add(
          new SliverGrid.count(
          crossAxisCount: 1,
          children: scrollViewsLists[year].toList(),
      ));
    });


    return scrollList;
  }

  GridTile getTileForDate(String text, bool selected, bool parent, DateTime date, CalendarStates state, [bool sticky = false]){
    return new GridTile(
        child: new InkResponse(
          child: new Day(selected: selected, date: text, parent: parent, sticky: sticky,),
          onTap: (){
            setState(() {
              if(calendarState == CalendarStates.day && !parent) selectedDay = date;
              if(state == CalendarStates.month && !parent || state == CalendarStates.day) yearToBrowse = new DateTime(date.year, date.month, 1);
              calendarState = state;
            });
          },
        )
    );
  }

}