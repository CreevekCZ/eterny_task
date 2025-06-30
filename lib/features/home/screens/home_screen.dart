import 'package:auto_route/auto_route.dart';
import 'package:eterny_task/core/extensions/l10n.dart';
import 'package:eterny_task/di.dart';
import 'package:eterny_task/features/home/bloc/characters_bloc.dart';
import 'package:eterny_task/features/home/bloc/characters_event.dart';
import 'package:eterny_task/features/home/bloc/characters_state.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/expandable_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final CharactersBloc _charactersBloc;

  @override
  void initState() {
    super.initState();
    _charactersBloc = sl<CharactersBloc>()..add(const CharactersEvent.loadCharacters());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => _charactersBloc,
      child: BlocConsumer<CharactersBloc, CharactersState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(context.l10n.charactersTable__lblTitle),
              backgroundColor: theme.colorScheme.primaryContainer,
              foregroundColor: theme.colorScheme.onPrimaryContainer,
              elevation: 2,
              toolbarHeight: 0,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    color: theme.colorScheme.surface,
                    child: ExpandableTable(
                      characters: state.maybeCharacters,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
