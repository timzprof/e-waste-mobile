import 'package:flutter/material.dart';

extension IterableExt on Iterable<Widget> {
  Iterable<Widget> seperator(Widget element) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield element;
        yield iterator.current;
      }
    }
  }

  Iterable<Widget> appendWithSeperator(Widget seperator, Widget append) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield seperator;
        yield iterator.current;
      }
      yield seperator;
      yield append;
    }
  }
}

extension StringExt on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toPhoneNumber({required String countryCode}) {
    return "$countryCode${substring(1)}";
  }
}

extension InputValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPhoneNumber() {
    return length == 11 || (substring(0, 3) == '234' && length == 13);
  }
}
