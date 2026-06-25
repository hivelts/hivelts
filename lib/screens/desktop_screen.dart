import 'package:flutter/material.dart';
import 'package:hivelts/utils/enums.dart';
import 'package:provider/provider.dart';
import '../core/os_state.dart';
import '../widgets/os/mac_dock.dart';
import '../widgets/os/mac_menu_bar.dart';
import '../widgets/os/windows_taskbar.dart';
import '../widgets/os/linux_dock.dart';
import '../widgets/os/window_frame.dart';
import '../widgets/os/mobile_shell.dart';

class DesktopScreen extends StatelessWidget {
  const DesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OSState>(
        builder: (context, osState, child) {

          //Define if is Android or Ios
          if (osState.currentOS == OS.android || osState.currentOS == OS.iOS) {
            return Stack(
              children: [
                MobileShell(platform: osState.currentOS),
                ...osState.windows.map((window) {
                  return WindowFrame(key: ValueKey(window.id), window: window);
                }),
              ],
            );
          }


          String wallpaper = 'assets/images/mac_bg.png';

          if (osState.currentOS == OS.windows) {
            wallpaper = 'assets/images/win_bg.png';
          } else if (osState.currentOS == OS.linux) {
            wallpaper = 'assets/images/linux_bg.jpg';
          }

          return Stack(
            children: [
              // 1. Wallpaper
              Positioned.fill(child: Image.asset(wallpaper, fit: BoxFit.cover)),

              // 2. Windows
              ...osState.windows.map((window) {
                return WindowFrame(key: ValueKey(window.id), window: window);
              }),

              // 3. UI del SO específico
              if (osState.currentOS == OS.macOS) ...[
                const MacMenuBar(),
                const MacDock(),
              ] else if (osState.currentOS == OS.windows) ...[
                const WindowsTaskbar(),
              ] else if (osState.currentOS == OS.linux) ...[
                const LinuxTopBar(),
                const LinuxDock(),
              ],
            ],
          );
        },
      ),
    );
  }
}
