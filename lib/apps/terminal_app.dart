import 'package:flutter/material.dart';
import 'package:hivelts/utils/enums.dart';
import 'package:provider/provider.dart';
import '../core/os_state.dart';

class TerminalApp extends StatelessWidget {
  const TerminalApp({super.key});

  @override
  Widget build(BuildContext context) {
    final os = context.watch<OSState>().currentOS;
    switch (os) {
      case OS.windows:
        return const _WindowsCMD();
      case OS.linux:
        return const _LinuxBash();
      default:
        return const _MacZsh();
    }
  }
}

// ─────────────────────────── macOS Zsh ───────────────────────────
class _MacZsh extends StatelessWidget {
  const _MacZsh();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E1E1E),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _line(
            'Last login: Mon Jun 15 10:20:45 on ttys000',
            const Color(0xFF888888),
          ),
          const SizedBox(height: 4),
          _prompt(
            'hivelts@MacBook-Pro ~ %',
            'cat experience.json',
            const Color(0xFF66FF66),
            Colors.white,
          ),
          const SizedBox(height: 8),
          _jsonBlock([
            {
              'role': 'Senior Flutter Developer',
              'company': 'TechCorp X',
              'period': '2021 - Present',
            },
            {
              'role': 'Frontend Developer',
              'company': 'Creative Agency Y',
              'period': '2018 - 2021',
            },
            {
              'role': 'Mobile Developer Jr.',
              'company': 'StartUp Z',
              'period': '2016 - 2018',
            },
          ]),
          const SizedBox(height: 8),
          _prompt(
            'hivelts@MacBook-Pro ~ %',
            '',
            const Color(0xFF66FF66),
            Colors.white,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── Windows CMD ───────────────────────────
class _WindowsCMD extends StatelessWidget {
  const _WindowsCMD();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _line('Microsoft Windows [Version 11.0.22621.2428]', Colors.white),
          _line(
            '(c) Microsoft Corporation. All rights reserved.',
            Colors.white,
          ),
          const SizedBox(height: 8),
          _prompt(
            'C:\\Users\\hivelts>',
            'type experience.txt',
            Colors.white,
            Colors.white,
          ),
          const SizedBox(height: 8),
          _expBlock([
            '[1] Senior Flutter Developer | TechCorp X | 2021 - Present',
            '    ► Desarrollé apps multi-plataforma de alto rendimiento.',
            '',
            '[2] Frontend Developer | Creative Agency Y | 2018 - 2021',
            '    ► UI/UX con React, Angular y Flutter Web.',
            '',
            '[3] Mobile Developer Jr. | StartUp Z | 2016 - 2018',
            '    ► Primeras apps iOS/Android nativas.',
          ], Colors.white),
          const SizedBox(height: 8),
          _prompt('C:\\Users\\hivelts>', '', Colors.white, Colors.white),
        ],
      ),
    );
  }
}

// ─────────────────────────── Linux Bash ───────────────────────────
class _LinuxBash extends StatelessWidget {
  const _LinuxBash();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF300A24),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _line(
            'GNU bash, version 5.2.15(1)-release (x86_64-pc-linux-gnu)',
            const Color(0xFFAAAAAA),
          ),
          const SizedBox(height: 4),
          _prompt(
            'hivelts@ubuntu:~\$',
            'cat experience.sh',
            const Color(0xFF4EE44E),
            Colors.white,
          ),
          const SizedBox(height: 8),
          _expBlock([
            '#!/bin/bash',
            '# === Experiencia Laboral ===',
            '',
            'ROLE_1="Senior Flutter Developer @ TechCorp X (2021-Present)"',
            'ROLE_2="Frontend Developer @ Creative Agency Y (2018-2021)"',
            'ROLE_3="Mobile Developer Jr. @ StartUp Z (2016-2018)"',
            '',
            'echo "Cargando experiencia..." && echo \$ROLE_1',
          ], const Color(0xFF89DDFF)),
          const SizedBox(height: 8),
          _prompt(
            'hivelts@ubuntu:~\$',
            '',
            const Color(0xFF4EE44E),
            Colors.white,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── Helpers ───────────────────────────
Widget _line(String text, Color color) {
  return Text(
    text,
    style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 13),
  );
}

Widget _prompt(
  String prompt,
  String command,
  Color promptColor,
  Color cmdColor,
) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: '$prompt ',
          style: TextStyle(
            color: promptColor,
            fontFamily: 'monospace',
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: command,
          style: TextStyle(
            color: cmdColor,
            fontFamily: 'monospace',
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}

Widget _jsonBlock(List<Map<String, String>> entries) {
  final buf = StringBuffer('[\n');
  for (final e in entries) {
    buf.writeln('  {');
    e.forEach((k, v) => buf.writeln('    "$k": "$v",'));
    buf.writeln('  },');
  }
  buf.write(']');
  return Text(
    buf.toString(),
    style: const TextStyle(
      color: Color(0xFF89DDFF),
      fontFamily: 'monospace',
      fontSize: 13,
    ),
  );
}

Widget _expBlock(List<String> lines, Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: lines
        .map(
          (l) => Text(
            l,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontSize: 13,
            ),
          ),
        )
        .toList(),
  );
}
