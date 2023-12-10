import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/intl/app_localizations.dart';

typedef BlocProviderAlias = BlocProvider<StateStreamableSource<Object?>>;

typedef LocalizedMessage = String Function(AppLocalizations l);
