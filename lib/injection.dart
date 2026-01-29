import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
// Questo file verrà generato automaticamente
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // nome della funzione generata
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();
