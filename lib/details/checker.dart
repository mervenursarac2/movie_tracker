import 'package:flutter/material.dart';
import 'package:movie_tracker/details/moviedetails.dart';
import 'package:movie_tracker/details/tvseriesdetails.dart';

class descriptioncheckui extends StatefulWidget {
  var newid;
  var newtype;
  descriptioncheckui({this.newid, this.newtype});

  @override
  State<descriptioncheckui> createState() => _descriptioncheckuiState();
}

class _descriptioncheckuiState extends State<descriptioncheckui> {
  checktype() {
    if (widget.newtype == 'movie') {
      return MovieDetails(id: widget.newid);
    } else if (widget.newtype == 'tv') {
      return TvDetails( id: widget.newid);
    }else{
      return errorui(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return checktype();
  }
}

Widget errorui(context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Error'),
    ),
    body: Center(
      child: Text('no Such page found'),
    ),
  );
}
