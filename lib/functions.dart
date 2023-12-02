import 'package:flutter/material.dart';

typedef OnItemReorder = void Function(
    int? oldCardIndex, int? newCardIndex, int? oldListIndex, int? newListIndex);
typedef OnListReorder = void Function(int? oldListIndex, int? newListIndex);

typedef OnItemTap = void Function(int? cardIndex, int? listIndex);
typedef OnItemLongPress = void Function(int? cardIndex, int? listIndex);
typedef OnListTap = void Function(int? listIndex);
typedef OnListLongPress = void Function(int? listIndex);

typedef OnListRename = void Function(String? oldName, String? newName);
typedef OnNewCardInsert = void Function(
    String? cardIndex, String? listIndex, String? text);
typedef CardTransitionBuilder = Widget Function(
    Widget child, Animation<double> animation);
typedef ListTransitionBuilder = Widget Function(
    Widget child, Animation<double> animation);
