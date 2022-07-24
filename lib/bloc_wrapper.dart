import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This BlocProvider is used to provide the Bloc to the widget tree.
/// The purpose is to make the bloc acessible right after the bloc is created.
/// And to expose this bloc listner
/// The widget does provide the bloc and state but does not rerender on state change.
/// Because this widget will most likely wrap the whole screen.
/// So it will be expensive to rerender the whole screen.
/// To observe the change in state use the bloc builder.
class WrapperBlocProvider<B extends StateStreamableSource<S>, S> extends StatelessWidget {
  final B Function(BuildContext context) create;
  final bool lazy;
  final Widget Function(BuildContext context, S state, B bloc) builder;
  final void Function(BuildContext context, S state, B bloc)? listener;
  const WrapperBlocProvider({
    Key? key,
    required this.create,
    this.lazy = true,
    required this.builder,
    this.listener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>(
      create: create,
      lazy: lazy,
      child: Builder(
        builder: (context) {
          final bloc = context.read<B>();
          return BlocConsumer<B, S>(
            bloc: bloc,
            buildWhen: (_, __) => false, // never rebuild
            builder: (context, state) {
              return builder.call(context, state, bloc);
            },
            listener: (context, state) {
              listener?.call(context, state, bloc);
            },
          );
        },
      ),
    );
  }
}
