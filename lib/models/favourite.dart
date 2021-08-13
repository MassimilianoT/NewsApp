import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Favourite extends Equatable{
  final int? id;
  final Color? color;

  Favourite({this.id, this.color});

  @override
  List<Object?> get props => [id, color];

}