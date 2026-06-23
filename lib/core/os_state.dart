import 'package:flutter/material.dart';
import 'package:hivelts/utils/enums.dart';

class OSWindow {
  final String id;
  final String title;
  final Widget content;
  final IconData icon;
  Offset position;
  Size size;
  bool isMinimized;
  bool isFocused;
  bool isFullscreen;

  OSWindow({
    required this.id,
    required this.title,
    required this.content,
    required this.icon,
    this.position = const Offset(100, 100),
    this.size = const Size(800, 600),
    this.isMinimized = false,
    this.isFocused = true,
    this.isFullscreen = false,
  });
}

//CONTROLA  EL ESTADO DE QUE SISTEMA OPERATIVO ESTA ABIERTO
//Igual controlara el tema claro oscuro
// Controla igual LOCALE

class OSState extends ChangeNotifier {
  final List<OSWindow> _windows = [];

  OS _currentOS = OS.macOS;
  Locale _currentLocale = const Locale('en');
  ThemeMode _themeMode = ThemeMode.light;

  List<OSWindow> get windows => _windows;

  OS get currentOS => _currentOS;

  Locale get currentLocale => _currentLocale;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  List<OS> get supportedSystems => OS.values;

  void setOS(OS os) {
    _currentOS = os;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _currentLocale = locale;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void toggleThemeMode() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void openApp(String id, String title, Widget content, IconData icon) {
    final existing = _windows.indexWhere((w) => w.id == id);
    if (existing != -1) {
      focusWindow(id);
      _windows[existing].isMinimized = false;
    } else {
      _windows.add(
        OSWindow(
          id: id,
          title: title,
          content: content,
          icon: icon,
          position: Offset(100 + (_windows.length * 30.0), 100 + (_windows.length * 30.0)),
        ),
      );
      focusWindow(id);
    }
  }

  void closeWindow(String id) {
    _windows.removeWhere((w) => w.id == id);
    notifyListeners();
  }

  void toggleMinimize(String id) {
    final index = _windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      _windows[index].isMinimized = !_windows[index].isMinimized;
      if (!_windows[index].isMinimized) {
        focusWindow(id);
      } else {
        notifyListeners();
      }
    }
  }

  void toggleFullscreen(String id) {
    final index = _windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      _windows[index].isFullscreen = !_windows[index].isFullscreen;
      notifyListeners();
    }
  }

  void focusWindow(String id) {
    final index = _windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      final window = _windows.removeAt(index);
      window.isFocused = true;
      for (var w in _windows) {
        w.isFocused = false;
      }
      _windows.add(window);
      notifyListeners();
    }
  }

  void updateWindowPosition(String id, Offset newPosition) {
    final index = _windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      _windows[index].position = newPosition;
      notifyListeners();
    }
  }
}
