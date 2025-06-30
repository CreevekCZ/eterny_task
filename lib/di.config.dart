// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/app.dart' as _i914;
import 'features/home/bloc/characters_bloc.dart' as _i961;
import 'features/home/services/character_service.dart' as _i415;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i914.AppRouteObserver>(() => _i914.AppRouteObserver());
    gh.singleton<_i415.CharacterService>(() => _i415.CharacterService());
    gh.factory<_i961.CharactersBloc>(
      () => _i961.CharactersBloc(gh<_i415.CharacterService>()),
    );
    return this;
  }
}
