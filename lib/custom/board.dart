import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanban_board/constants.dart';
import 'package:kanban_board/draggable/draggable_state.dart';
import 'package:kanban_board/draggable/presentation/dragged_card.dart';
import 'package:kanban_board/functions.dart';
import '../Provider/provider_list.dart';
import '../models/board_list.dart' as board_list;
import '../models/inputs.dart';
import 'board_list.dart';
import 'text_field.dart';

class KanbanBoard extends StatefulWidget {
  const KanbanBoard(
    this.list, {
    this.backgroundColor = Colors.white,
    this.cardPlaceHolderColor,
    this.boardScrollConfig,
    this.listScrollConfig,
    this.listPlaceHolderColor,
    this.boardDecoration,
    this.cardTransitionBuilder,
    this.listTransitionBuilder,
    this.cardTransitionDuration = const Duration(milliseconds: 150),
    this.listTransitionDuration = const Duration(milliseconds: 150),
    this.listDecoration,
    this.textStyle,
    this.onItemTap,
    this.displacementX = 0.0,
    this.displacementY = 0.0,
    this.onItemReorder,
    this.onListReorder,
    this.onListRename,
    this.onNewCardInsert,
    this.onItemLongPress,
    this.onListTap,
    this.onListLongPress,
    this.addListHint = "Add List",
    super.key,
  });
  final List<BoardListsData> list;
  final Color backgroundColor;
  final ScrollConfig? boardScrollConfig;
  final ScrollConfig? listScrollConfig;
  final Color? cardPlaceHolderColor;
  final Color? listPlaceHolderColor;
  final TextStyle? textStyle;
  final Decoration? listDecoration;
  final Decoration? boardDecoration;
  final OnItemTap? onItemTap;
  final OnItemReorder? onItemReorder;
  final OnListReorder? onListReorder;
  final OnItemLongPress? onItemLongPress;
  final OnListTap? onListTap;
  final OnListLongPress? onListLongPress;
  final OnListRename? onListRename;
  final OnNewCardInsert? onNewCardInsert;
  final CardTransitionBuilder? cardTransitionBuilder;
  final ListTransitionBuilder? listTransitionBuilder;

  final double displacementX;
  final double displacementY;
  final Duration cardTransitionDuration;
  final Duration listTransitionDuration;
  final String addListHint;

  @override
  State<KanbanBoard> createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Board(
        widget.list,
        displacementX: widget.displacementX,
        displacementY: widget.displacementY,
        backgroundColor: widget.backgroundColor,
        boardDecoration: widget.boardDecoration,
        cardPlaceHolderColor: widget.cardPlaceHolderColor,
        listPlaceHolderColor: widget.listPlaceHolderColor,
        listDecoration: widget.listDecoration,
        boardScrollConfig: widget.boardScrollConfig,
        listScrollConfig: widget.listScrollConfig,
        textStyle: widget.textStyle,
        onItemTap: widget.onItemTap,
        onItemLongPress: widget.onItemLongPress,
        onListTap: widget.onListTap,
        onListLongPress: widget.onListLongPress,
        onItemReorder: widget.onItemReorder,
        onListReorder: widget.onListReorder,
        onListRename: widget.onListRename,
        onNewCardInsert: widget.onNewCardInsert,
        cardTransitionBuilder: widget.cardTransitionBuilder,
        listTransitionBuilder: widget.listTransitionBuilder,
        cardTransitionDuration: widget.cardTransitionDuration,
        listTransitionDuration: widget.listTransitionDuration,
        addListHint: widget.addListHint,
      ),
    );
  }
}

class Board extends ConsumerStatefulWidget {
  const Board(
    this.list, {
    this.backgroundColor = Colors.white,
    this.cardPlaceHolderColor,
    this.listPlaceHolderColor,
    this.boardDecoration,
    this.boardScrollConfig,
    this.listScrollConfig,
    this.cardTransitionBuilder,
    this.listTransitionBuilder,
    this.cardTransitionDuration = const Duration(milliseconds: 150),
    this.listTransitionDuration = const Duration(milliseconds: 150),
    this.listDecoration,
    this.textStyle,
    this.onItemTap,
    this.displacementX = 0.0,
    this.displacementY = 0.0,
    this.onItemReorder,
    this.onListReorder,
    this.onListRename,
    this.onNewCardInsert,
    this.onItemLongPress,
    this.onListTap,
    this.onListLongPress,
    super.key,
    required this.addListHint,
  });
  final List<BoardListsData> list;
  final Color backgroundColor;
  final Color? cardPlaceHolderColor;
  final Color? listPlaceHolderColor;
  final TextStyle? textStyle;
  final Decoration? listDecoration;
  final Decoration? boardDecoration;
  final ScrollConfig? boardScrollConfig;
  final ScrollConfig? listScrollConfig;
  final OnItemTap? onItemTap;
  final OnItemReorder? onItemReorder;
  final OnListReorder? onListReorder;
  final OnItemLongPress? onItemLongPress;
  final OnListTap? onListTap;
  final OnListLongPress? onListLongPress;
  final OnListRename? onListRename;
  final OnNewCardInsert? onNewCardInsert;
  final CardTransitionBuilder? cardTransitionBuilder;
  final ListTransitionBuilder? listTransitionBuilder;
  final double displacementX;
  final double displacementY;
  final Duration cardTransitionDuration;
  final Duration listTransitionDuration;
  final String addListHint;

  @override
  ConsumerState<Board> createState() => _BoardState();
}

class _BoardState extends ConsumerState<Board> {
  late ProviderList providerList = ProviderList(
      onItemReorder: widget.onItemReorder, onListReorder: widget.onListReorder);

  @override
  void initState() {
    var boardProv = ref.read(ProviderList.boardProvider);
    final draggableProv = ref.read(ProviderList.draggableNotifier);
    var boardListProv = ref.read(providerList.boardListProvider);
    boardProv.initializeBoard(
        data: widget.list,
        boardScrollConfig: widget.boardScrollConfig,
        listScrollConfig: widget.listScrollConfig,
        displacementX: widget.displacementX,
        displacementY: widget.displacementY,
        backgroundColor: widget.backgroundColor,
        boardDecoration: widget.boardDecoration,
        cardPlaceHolderColor: widget.cardPlaceHolderColor,
        listPlaceHolderColor: widget.listPlaceHolderColor,
        listDecoration: widget.listDecoration,
        textStyle: widget.textStyle,
        onItemTap: widget.onItemTap,
        onItemLongPress: widget.onItemLongPress,
        onListTap: widget.onListTap,
        onListLongPress: widget.onListLongPress,
        onItemReorder: widget.onItemReorder,
        onListReorder: widget.onListReorder,
        onListRename: widget.onListRename,
        onNewCardInsert: widget.onNewCardInsert,
        cardTransitionBuilder: widget.cardTransitionBuilder,
        listTransitionBuilder: widget.listTransitionBuilder,
        cardTransitionDuration: widget.cardTransitionDuration,
        listTransitionDuration: widget.listTransitionDuration);

    for (var element in boardProv.board.lists) {
      // List Scroll Listener
      element.scrollController.addListener(() {
        if (boardListProv.scrolling) {
          if (boardListProv.scrollingDown) {
            boardProv.valueNotifier.value = Offset(
                boardProv.valueNotifier.value.dx,
                boardProv.valueNotifier.value.dy + 0.00001);
          } else {
            boardProv.valueNotifier.value = Offset(
                boardProv.valueNotifier.value.dx,
                boardProv.valueNotifier.value.dy + 0.00001);
          }
        }
      });
    }

    // Board Scroll Listener
    boardProv.board.controller.addListener(() {
      if (boardProv.scrolling) {
        if (boardProv.scrollingLeft && draggableProv.isListDragged) {
          for (var element in boardProv.board.lists) {
            if (element.context == null) break;
            var of = (element.context!.findRenderObject() as RenderBox)
                .localToGlobal(Offset.zero);
            element.x = of.dx - boardProv.board.displacementX! - 10;
            element.width = element.context!.size!.width - 30;
            element.y = of.dy - widget.displacementY + 24;
          }

          boardListProv.moveListLeft();
        } else if (boardProv.scrollingRight && draggableProv.isListDragged) {
          for (var element in boardProv.board.lists) {
            if (element.context == null) break;
            var of = (element.context!.findRenderObject() as RenderBox)
                .localToGlobal(Offset.zero);
            element.x = of.dx - boardProv.board.displacementX! - 10;
            element.width = element.context!.size!.width - 30;
            element.y = of.dy - widget.displacementY + 24;
          }
          boardListProv.moveListRight();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var boardProv = ref.read(ProviderList.boardProvider);
    var boardListProv = ref.read(providerList.boardListProvider);
    final draggableProv = ref.watch(ProviderList.draggableNotifier);
    final draggableNotifier = ref.read(ProviderList.draggableNotifier.notifier);
    double statusBarHeight = MediaQuery.of(context).padding.top;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      boardProv.board.setstate = () => setState(() {});
      var box = context.findRenderObject() as RenderBox;
      boardProv.board.displacementX =
          box.localToGlobal(Offset.zero).dx + BOARD_PADDING; //- margin
      boardProv.board.displacementY = box.localToGlobal(Offset.zero).dy -
          statusBarHeight +
          BOARD_PADDING; // statusbar
    });
    return Listener(
      onPointerUp: (event) {
        if (draggableProv.draggableType != DraggableType.none) {
          if (draggableProv.isCardDragged) {
            ref.read(providerList.cardProvider).reorderCard();
          }
          boardProv.move = "";
          draggableNotifier.stopDragging();
          setState(() {});
        }
      },
      onPointerMove: (event) {
        if (draggableProv.isCardDragged) {
          if (event.delta.dx > 0) {
            boardProv.boardScroll();
          } else {
            boardProv.boardScroll();
          }
        } else if (draggableProv.isListDragged) {
          if (event.delta.dx > 0) {
            boardProv.boardScroll();
            boardListProv.moveListRight();
          } else {
            boardProv.boardScroll();
            boardListProv.moveListLeft();
          }
        }
        boardProv.delta = event.delta;
        boardProv.valueNotifier.value = Offset(
            event.delta.dx + boardProv.valueNotifier.value.dx,
            event.delta.dy + boardProv.valueNotifier.value.dy);
      },
      child: GestureDetector(
        onTap: () {
          if (boardProv.newCardState.isFocused == true) {
            ref.read(providerList.cardProvider).saveNewCard();
          }
        },
        child: Container(
          padding: const EdgeInsets.only(
              top: BOARD_PADDING, left: BOARD_PADDING, right: BOARD_PADDING),
          decoration: widget.boardDecoration ??
              BoxDecoration(color: widget.backgroundColor),
          child: Stack(
            fit: StackFit.passthrough,
            clipBehavior: Clip.none,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 1200,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.mouse,
                            PointerDeviceKind.touch,
                          },
                        ),
                        child: SingleChildScrollView(
                          controller: boardProv.board.controller,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: boardProv.board.lists
                                  .map((e) => boardProv.board.lists
                                              .indexOf(e) !=
                                          boardProv.board.lists.length - 1
                                      ? BoardList(
                                          index:
                                              boardProv.board.lists.indexOf(e),
                                        )
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BoardList(
                                              index: boardProv.board.lists
                                                  .indexOf(e),
                                            ),
                                            boardListProv.newList
                                                ? Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      top: 20,
                                                      left: 30,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.only(
                                                      bottom: 20,
                                                    ),
                                                    width: 300,
                                                    color: const Color.fromARGB(
                                                      255,
                                                      247,
                                                      248,
                                                      252,
                                                    ),
                                                    child: Wrap(
                                                      children: [
                                                        SizedBox(
                                                          height: 50,
                                                          width: 300,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    boardListProv
                                                                            .newList =
                                                                        false;
                                                                    boardProv
                                                                        .newCardState
                                                                        .textController
                                                                        .clear();
                                                                  });
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .close),
                                                              ),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      boardListProv
                                                                              .newList =
                                                                          false;
                                                                      boardProv
                                                                          .board
                                                                          .lists
                                                                          .add(board_list
                                                                              .BoardList(
                                                                        width:
                                                                            300,
                                                                        scrollController:
                                                                            ScrollController(),
                                                                        items: [],
                                                                        title: boardProv
                                                                            .newCardState
                                                                            .textController
                                                                            .text,
                                                                      ));
                                                                      boardProv
                                                                          .newCardState
                                                                          .textController
                                                                          .clear();
                                                                    });
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .done))
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                            width: 300,
                                                            color: Colors.white,
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 20,
                                                                    right: 10,
                                                                    left: 10),
                                                            child:
                                                                const TField()),
                                                      ],
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      if (boardProv.newCardState
                                                              .isFocused ==
                                                          true) {
                                                        ref
                                                            .read(providerList
                                                                .cardProvider)
                                                            .saveNewCard();
                                                      }
                                                      boardListProv.newList =
                                                          true;
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                        height: 50,
                                                        width: 300,
                                                        margin: const EdgeInsets
                                                            .only(
                                                            top: 10, left: 20),
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6)),
                                                        child: DottedBorder(
                                                          child: Center(
                                                              child: Text(
                                                                  widget
                                                                      .addListHint,
                                                                  style: widget
                                                                      .textStyle)),
                                                        )),
                                                  )
                                          ],
                                        ))
                                  .toList()),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const DraggedCard()
            ],
          ),
        ),
      ),
    );
  }
}
