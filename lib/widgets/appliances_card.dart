import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppliancesCard extends StatelessWidget {
  const AppliancesCard({
    super.key,
    required this.icon,
    required this.name,
    required this.isOn,
    required this.onToggle,
    required this.onTap,
    required this.value,
  });

  final String icon;
  final String name;
  final String isOn;
  final void Function(bool) onToggle;
  final VoidCallback onTap;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2.0,
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).primaryColor,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: CachedNetworkImageProvider(icon),
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      isOn,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    Switch.adaptive(
                      thumbColor: Theme.of(context).switchTheme.thumbColor,
                      trackColor: Theme.of(context).switchTheme.trackColor,
                      overlayColor: Theme.of(context).switchTheme.overlayColor,
                      value: value,
                      onChanged: onToggle,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
