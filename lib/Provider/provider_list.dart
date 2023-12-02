import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanban_board/Provider/draggable_provider.dart';
import 'package:kanban_board/functions.dart';

import 'list_item_provider.dart';

import 'board_list_provider.dart';
import 'board_provider.dart';

class ProviderList {
  ProviderList({this.onItemReorder, this.onListReorder});

  final OnItemReorder? onItemReorder;
  final OnListReorder? onListReorder;

  static final boardProvider = ChangeNotifierProvider<BoardProvider>(
    (ref) => BoardProvider(ref),
  );
  late final cardProvider = ChangeNotifierProvider<ListItemProvider>(
    (ref) => ListItemProvider(ref, onItemReorder),
  );

  late final boardListProvider = ChangeNotifierProvider<BoardListProvider>(
    (ref) => BoardListProvider(ref, onListReorder),
  );

  static final draggableNotifier =
      StateNotifierProvider<DraggableNotfier, DraggableProviderState>(
          (_) => DraggableNotfier());
}
