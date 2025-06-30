import 'package:eterny_task/features/home/models/character.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/character_header.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/character_row_with_children.dart';
import 'package:eterny_task/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ExpandableTable extends StatefulWidget {
  const ExpandableTable({
    required this.characters,
    super.key,
  });
  final List<Character> characters;

  @override
  State<ExpandableTable> createState() => _ExpandableTableState();
}

class _ExpandableTableState extends State<ExpandableTable> {
  late final ValueNotifier<Set<String>> _expandedItemsNotifier;

  @override
  void initState() {
    super.initState();
    _expandedItemsNotifier = ValueNotifier<Set<String>>(<String>{});
  }

  void _toggleExpansion(String key) {
    final expandedItems = Set<String>.from(_expandedItemsNotifier.value);
    if (expandedItems.contains(key)) {
      expandedItems.remove(key);
    } else {
      expandedItems.add(key);
    }
    _expandedItemsNotifier.value = expandedItems;
  }

  @override
  void dispose() {
    _expandedItemsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _expandedItemsNotifier,
      builder: (context, expandedItems, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: ExpandableTableColumnConfig.tableWidth(),
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    child: const CharacterHeader(),
                  ),
                ),
                SliverList.builder(
                  itemCount: widget.characters.length,
                  addRepaintBoundaries: true,
                  itemBuilder: (context, index) {
                    final character = widget.characters[index];

                    return CharacterRowWithChildren(
                      character: character,
                      expandedItems: expandedItems,
                      onToggleExpansion: _toggleExpansion,
                    );
                  },
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 42),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({required this.child});

  final Widget child;

  @override
  double get minExtent => 60;

  @override
  double get maxExtent => 60;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}

enum ExpandableTableColumnConfig {
  expand, // special column for the expand icon
  id,
  name,
  gender,
  ability,
  minimalDistance,
  weight,
  born,
  inSpaceSince,
  beerConsumption,
  knowsTheAnswer,
  nemeses,
  secrets,
  nemesisId,
  characterId,
  isAlive,
  years,
  secretId,
  secreteCode;

  double get width => switch (this) {
    expand => 40,
    id => 55,
    name => 180,
    gender => 80,
    ability => 150,
    minimalDistance => 180,
    weight => 80,
    born => 240,
    inSpaceSince => 240,
    beerConsumption => 150,
    knowsTheAnswer => 150,
    nemeses => 100,
    secrets => 100,
    nemesisId => 100,
    characterId => 100,
    isAlive => 80,
    years => 65,
    secretId => 80,
    secreteCode => 150,
  };

  static List<ExpandableTableColumnConfig> get characterColumns => [
    ExpandableTableColumnConfig.expand,
    ExpandableTableColumnConfig.id,
    ExpandableTableColumnConfig.name,
    ExpandableTableColumnConfig.gender,
    ExpandableTableColumnConfig.ability,
    ExpandableTableColumnConfig.minimalDistance,
    ExpandableTableColumnConfig.weight,
    ExpandableTableColumnConfig.born,
    ExpandableTableColumnConfig.inSpaceSince,
    ExpandableTableColumnConfig.beerConsumption,
    ExpandableTableColumnConfig.knowsTheAnswer,
    ExpandableTableColumnConfig.nemeses,
    ExpandableTableColumnConfig.secrets,
  ];

  String getLocalizedName(AppLocalizations l10n) => switch (this) {
    expand => '',
    id => l10n.charactersTable__lblId,
    name => l10n.charactersTable__lblName,
    gender => l10n.charactersTable__lblGender,
    ability => l10n.charactersTable__lblAbility,
    minimalDistance => l10n.charactersTable__lblMinimalDistance,
    weight => l10n.charactersTable__lblWeight,
    born => l10n.charactersTable__lblBorn,
    inSpaceSince => l10n.charactersTable__lblInSpaceSince,
    beerConsumption => l10n.charactersTable__lblBeerConsumption,
    knowsTheAnswer => l10n.charactersTable__lblKnowsTheAnswer,
    nemeses => l10n.charactersTable__lblNemeses,
    secrets => l10n.charactersTable__lblSecrets,
    nemesisId => l10n.charactersTable__lblNemesisId,
    characterId => l10n.charactersTable__lblCharacterId,
    isAlive => l10n.charactersTable__lblIsAlive,
    years => l10n.charactersTable__lblYears,
    secretId => l10n.charactersTable__lblSecretId,
    secreteCode => l10n.charactersTable__lblSecreteCode,
  };

  static double tableWidth() {
    return characterColumns.map((column) => column.width).reduce((a, b) => a + b);
  }
}
