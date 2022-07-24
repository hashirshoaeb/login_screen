import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_screen/bloc_wrapper.dart';
import 'package:login_screen/theme_cubit.dart';
import 'package:login_screen/tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WrapperBlocProvider<ThemeModeCubit, ThemeCubitState>(
      create: (context) => ThemeModeCubit(),
      builder: (context, state, bloc) {
        return BlocBuilder<ThemeModeCubit, ThemeCubitState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                brightness: Brightness.light,
                primarySwatch: Colors.blue,
                listTileTheme: Theme.of(context).listTileTheme.copyWith(
                      tileColor: Colors.grey[200],
                    ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.blue,
                listTileTheme: Theme.of(context).listTileTheme.copyWith(
                      tileColor: Colors.grey[800],
                    ),
              ),
              themeMode: state.toThemeMode,
              home: const LoginPage(),
            );
          },
        );
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: const [
            Align(
              alignment: Alignment.topRight,
              child: _ThemeModeIcon(),
            ),
            // profile
            Profile(),
            SizedBox(height: 16),
            // name
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            // email
            Text(
              'jhon.doe@example.com',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16),
            // filled button => upgrade to pro
            _PremiumSubscription(),
            SizedBox(height: 16),
            // privacy
            OptionsTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy',
            ),
            // purchase history
            OptionsTile(
              icon: Icons.history_outlined,
              title: 'Purchase History',
            ),
            // help and support
            OptionsTile(
              icon: Icons.help_outline,
              title: 'Help & Support',
            ),
            // settings
            OptionsTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
            ),
            // invite a friend
            OptionsTile(
              icon: Icons.person_add_outlined,
              title: 'Invite a Friend',
            ),
            // logout
            LogoutTile(),
          ],
        ),
      ),
    );
  }
}

// abstraction below just to make code look neat, and to make const classes for speed

class _ThemeModeIcon extends StatelessWidget {
  const _ThemeModeIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: BlocBuilder<ThemeModeCubit, ThemeCubitState>(
        builder: (context, state) {
          if (state.isLight) {
            return const Icon(Icons.dark_mode_outlined);
          } else {
            return const Icon(Icons.light_mode_outlined);
          }
        },
      ),
      onPressed: () {
        context.read<ThemeModeCubit>().toggle();
      },
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.brown[900],
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.orange,
          width: 6,
        ),
      ),
      child: const Icon(
        Icons.person_outline,
        size: 70,
        color: Colors.orange,
      ),
    );
  }
}

class _PremiumSubscription extends StatelessWidget {
  const _PremiumSubscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text(
        'Upgrade to Pro',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      // flat rounded button style
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.brown[900]!),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        )),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      onPressed: () {},
    );
  }
}
