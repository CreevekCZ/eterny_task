import 'package:auto_route/auto_route.dart';
import 'package:eterny_task/core/extensions/l10n.dart';
import 'package:eterny_task/di.dart';
import 'package:eterny_task/features/home/bloc/characters_bloc.dart';
import 'package:eterny_task/features/home/bloc/characters_event.dart';
import 'package:eterny_task/features/home/bloc/characters_state.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/expandable_table.dart';
import 'package:eterny_task/ui/app_snack_bar.dart';
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
        listener: (context, state) {
          if (state is CharactersErrorState) {
            AppSnackBar.showError(
              context,
              message: state.message,
              actionLabel: context.l10n.charactersTable__btnReloadCharacters,
              onAction: () => _charactersBloc.add(const CharactersEvent.loadCharacters()),
            );
          }
        },
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state.isEmpty)
                  Center(
                    child: Card(
                      elevation: 8,
                      color: theme.colorScheme.primaryContainer,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        constraints: const BoxConstraints(
                          maxWidth: 300,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 16,
                          children: [
                            Text(
                              context.l10n.charactersTable__lblNoCharacters,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                            Text(
                              context.l10n.charactersTable__lblTapToReloadCharacters,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () =>
                                    _charactersBloc.add(const CharactersEvent.loadCharacters()),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.refresh),
                                    const SizedBox(width: 8),
                                    Text(context.l10n.charactersTable__btnReloadCharacters),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (state.isNotEmpty)
                  Expanded(
                    child: Container(
                      color: theme.colorScheme.surface,
                      child: ExpandableTable(
                        characters: state.maybeCharacters,
                        onDeleteCharacter: (uuid) =>
                            _charactersBloc.add(CharactersEvent.deleteCharacter(uuid: uuid)),
                        onDeleteNemesis: (uuid, nemesisId) => _charactersBloc.add(
                          CharactersEvent.deleteNemesis(uuid: uuid, nemesisId: nemesisId),
                        ),
                        onDeleteSecret: (uuid, secretId, nemesisId) => _charactersBloc.add(
                          CharactersEvent.deleteSecret(
                            uuid: uuid,
                            secretId: secretId,
                            nemesisId: nemesisId,
                          ),
                        ),
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
