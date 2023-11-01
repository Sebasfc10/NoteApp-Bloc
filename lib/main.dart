import 'package:bloc_to_do/bloc/notes_bloc_bloc.dart';
import 'package:bloc_to_do/bloc/notes_bloc_event.dart';
import 'package:bloc_to_do/bloc/search_notes_bloc.dart';
import 'package:bloc_to_do/screen/add_note_screen.dart';
import 'package:bloc_to_do/screen/notes_screen.dart';
import 'package:bloc_to_do/screen/search_notes_screen.dart';
import 'package:bloc_to_do/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<NotesBloc>(
        create: (context) => NotesBloc()..add(GetAllNotesEvent())),
    BlocProvider<NotesSearchBloc>(
      create: (context) => NotesSearchBloc()..add(GetAllNotesSearchEvent()),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: notesTheme,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    NotesScreen(),
    SearchNotesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Notas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
