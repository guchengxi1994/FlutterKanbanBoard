import 'package:flutter/material.dart';
import 'package:kanban_board/functions.dart';
import 'board_list.dart';
import 'inputs.dart';

abstract class BaseDecoration {
  Decoration decoration;
  BaseDecoration(this.decoration);
}

class BoardState {
  List<BoardList> lists = [];
  ScrollController controller;
  VoidCallback? setstate;
  int? dragListIndex = 0;
  int? dragItemIndex = 0;
  int? previousDragListIndex = 0;
  int? dragItemOfListIndex = 0;
  int? prevItemOfListIndex = 0;
  double? displacementX;
  double? displacementY;
  final OnItemTap? onItemTap;
  final OnItemReorder? onItemReorder;
  final OnListReorder? onListReorder;
  final OnItemLongPress? onItemLongPress;
  final OnListTap? onListTap;
  final OnListLongPress? onListLongPress;
  final OnListRename? onListRename;
  final OnNewCardInsert? onNewCardInsert;
  Color? backgroundColor;
  Color? cardPlaceholderColor;
  Color? listPlaceholderColor;
  final ScrollConfig? boardScrollConfig;
  final ScrollConfig? listScrollConfig;
  TextStyle? textStyle;
  Decoration? listDecoration;
  Decoration? boardDecoration;
  TransitionHandler transitionHandler;

  BoardState({
    required this.lists,
    required this.controller,
    this.dragListIndex,
    this.onItemTap,
    this.onItemLongPress,
    this.boardScrollConfig,
    this.listScrollConfig,
    this.setstate,
    this.onListTap,
    this.onItemReorder,
    this.onListReorder,
    this.onListRename,
    this.onNewCardInsert,
    this.displacementX,
    this.displacementY,
    this.onListLongPress,
    this.dragItemIndex,
    this.textStyle,
    this.backgroundColor = Colors.white,
    this.cardPlaceholderColor,
    this.listPlaceholderColor,
    this.listDecoration,
    this.boardDecoration,
    this.dragItemOfListIndex,
    required this.transitionHandler,
  }) {
    textStyle = textStyle ??
        TextStyle(
            color: Colors.grey.shade800,
            fontSize: 19,
            fontWeight: FontWeight.w400);
  }
}

class TransitionHandler {
  final CardTransitionBuilder cardTransitionBuilder;
  final ListTransitionBuilder listTransitionBuilder;
  final Duration cardTransitionDuration;
  final Duration listTransitionDuration;

  TransitionHandler(
      {required this.cardTransitionBuilder,
      required this.listTransitionBuilder,
      required this.cardTransitionDuration,
      required this.listTransitionDuration});
}

class NewCardState {
  bool? isFocused;
  int? listIndex;
  int? cardIndex;
  late TextEditingController textController;

  NewCardState({
    this.isFocused,
    this.listIndex,
    this.cardIndex,
  }) {
    textController = TextEditingController();
  }
}
