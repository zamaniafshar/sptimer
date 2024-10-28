import 'package:flutter/material.dart';

const _paginationScrollThreshold = 250.0;

class PaginationListView<T> extends StatefulWidget {
  const PaginationListView({
    super.key,
    required this.items,
    required this.isLoadingMore,
    required this.loadMore,
    required this.builder,
    this.padding = const EdgeInsets.symmetric(vertical: 15),
  })  : _sliver = false,
        scrollController = null;

  const PaginationListView.sliver({
    super.key,
    required this.scrollController,
    required this.items,
    required this.isLoadingMore,
    required this.loadMore,
    required this.builder,
    this.padding = const EdgeInsets.symmetric(vertical: 15),
  }) : _sliver = true;

  final List<T> items;
  final Widget Function(int index, T item) builder;
  final void Function() loadMore;
  final bool isLoadingMore;
  final bool _sliver;
  final ScrollController? scrollController;
  final EdgeInsets padding;

  @override
  State<PaginationListView<T>> createState() => _PaginationListViewState<T>();
}

class _PaginationListViewState<T> extends State<PaginationListView<T>> {
  late final scrollController = widget.scrollController ?? ScrollController();

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final isAtTheEnd = maxScroll - currentScroll <= _paginationScrollThreshold;

    if (isAtTheEnd) {
      widget.loadMore();
    }
  }

  @override
  void dispose() {
    // dispose if this widget created the controller
    if (widget.scrollController == null) {
      scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemsCount = widget.items.length;

    final sliver = SliverPadding(
      padding: widget.padding,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index < itemsCount) {
              final item = widget.items[index];

              return widget.builder(index, item);
            }

            return widget.isLoadingMore ? const CircularProgressIndicator() : const SizedBox();
          },
          childCount: itemsCount + 1,
        ),
      ),
    );

    if (widget._sliver) return sliver;

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        sliver,
      ],
    );
  }
}
