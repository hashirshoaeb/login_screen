import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _DefaultTile extends StatelessWidget {
  final Color? backgroundColor;
  final Widget? child;
  final VoidCallback? onTap;
  const _DefaultTile({
    Key? key,
    this.backgroundColor,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: child,
        ),
      ),
    );
  }
}

// tile
class OptionsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? ontap;
  const OptionsTile({
    Key? key,
    required this.icon,
    required this.title,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).listTileTheme;
    return _DefaultTile(
      backgroundColor: theme.tileColor,
      onTap: ontap,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}

// logout
class LogoutTile extends StatelessWidget {
  const LogoutTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DefaultTile(
      backgroundColor: Colors.black,
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Logout',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
