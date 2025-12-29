import 'package:flutter/material.dart';

class TipBar extends StatelessWidget {
  const TipBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Tip(
            title: 'Move',
            text: 'Tap anywhere to dash toward the light.',
          ),
          _Tip(
            title: 'Avoid',
            text: 'Shadows drain you on touch.',
          ),
          _Tip(
            title: 'Collect',
            text: 'Light shards boost your score.',
          ),
        ],
      ),
    );
  }
}

class _Tip extends StatelessWidget {
  const _Tip({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.white60),
        ),
      ],
    );
  }
}
