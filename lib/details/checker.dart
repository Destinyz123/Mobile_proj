import 'package:flutter/material.dart';
import 'package:review888/details/moviedetail.dart';
import 'package:review888/details/tvseriesdetail.dart';

class descriptioncheckui extends StatefulWidget {
  var newid;
  var newtype;

  descriptioncheckui(this.newid, this.newtype);

  @override
  State<descriptioncheckui> createState() => _descriptioncheckuiState();
}

Widget errorUI() {
  return Scaffold(
    body: Center(
      child: Text("Error"),
    ),
  );
}

class _descriptioncheckuiState extends State<descriptioncheckui> {
  checktype() {
    if (widget.newtype == 'movie') {
      return Moviedetail(widget.newid);
    } else if (widget.newtype == 'tv') {
      return TvSeriesDetails(id: widget.newid);
    } else {
      return errorUI();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: checktype(),
    );
  }
}
