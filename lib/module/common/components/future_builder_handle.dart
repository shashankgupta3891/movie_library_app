import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/core/type_defination.dart';

class FutureBuilderHandle<T> extends StatelessWidget {
  const FutureBuilderHandle({
    Key? key,
    required this.future,
    required this.builder,
    this.loadingWidget,
    this.errorWidget,
    this.placeholderWidget,
  }) : super(key: key);

  final Future<T> future;
  final DataBuilder<T> builder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? placeholderWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget ??
              const Center(
                child: CircularProgressIndicator(),
              );
        }

        if (snapshot.hasError) {
          return errorWidget ??
              Center(
                child: Text(snapshot.error.toString()),
              );
        }

        if (snapshot.hasData && snapshot.data != null) {
          return builder.call(context, snapshot.data as T);
        }
        return placeholderWidget ?? const SizedBox();
      },
    );
  }
}

class StreamBuilderHandle<T> extends StatelessWidget {
  const StreamBuilderHandle({
    Key? key,
    required this.stream,
    required this.builder,
    this.loadingWidget,
    this.errorWidget,
    this.placeholderWidget,
  }) : super(key: key);

  final Stream<T> stream;
  final DataBuilder<T> builder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? placeholderWidget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget ??
              const Center(
                child: CircularProgressIndicator(),
              );
        }

        if (snapshot.hasError) {
          return errorWidget ??
              Center(
                child: Text(snapshot.error.toString()),
              );
        }

        if (snapshot.hasData && snapshot.data != null) {
          return builder.call(context, snapshot.data as T);
        }
        return placeholderWidget ?? const SizedBox();
      },
    );
  }
}
