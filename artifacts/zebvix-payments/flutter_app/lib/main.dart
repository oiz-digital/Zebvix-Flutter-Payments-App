import 'package:flutter/widgets.dart';

import 'app/zebvix_app.dart';
import 'core/platform/system_ui_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemUiConfig.configure();
  runApp(const ZebvixApp());
}
