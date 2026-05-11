import 'package:flutter/material.dart';
import '../../models/result.dart';
import 'empty_widget.dart';
import 'error_widget.dart';
import 'loading_widget.dart';
import 'sliver_marker.dart';

class ResultImplementer<T> extends StatelessWidget {
  final Result<T> requestState;
  final Widget loadingWidget;
  final Widget Function(T result) successWidget;
  final Widget Function(String message)? errorWidget;
  final Widget? emptyWidget;
  final Widget initialWidget;
  final bool isSliver;

  const ResultImplementer({
    super.key,
    required this.requestState,
    required this.successWidget,
    this.loadingWidget = const AppLoadingWidget(),
    this.errorWidget,
    this.emptyWidget,
    this.initialWidget = const SizedBox(),
    this.isSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    return () {
      if(isSliver) {
        Widget widgetToSliver(Widget widget) {
          if (widget is SliverMarker) {
            return widget.sliver;
          }
          return SliverToBoxAdapter(
            child: widget
          );
        }
        return widgetToSliver(_getChild());
      }
      return _getChild();
    } ();
  }

  Widget _getChild() {
    final state = requestState;

    return switch (state) {
      Failed<T>(:final message) => errorWidget != null
        ? errorWidget!(message)
        : AppErrorWidget(message: message),
      Empty<T>() => emptyWidget ?? const AppEmptyWidget(),
      Loading<T>() => loadingWidget,
      Success<T>(:final value) => successWidget(value),
      _ => initialWidget,
    };
  }
}