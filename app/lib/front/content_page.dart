// lib/pages/content.dart
import 'package:flutter/material.dart';
import '../widgets/page_layout.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return PageLayout(
      headerAssetPath: 'assets/images/phenikaa_logo.jpg',
      footerText: 'Phenikaa University, Quân - Hiếu - Cường.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- NEW: Top navigation bar inserted at the very top of body ---
          const _TopNavBar(),
          const SizedBox(height: 12),

          // Heading + Subheading
          Text('Heading', style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(
            'Subheading',
            style: textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 18),

          // Three content blocks 
          _ContentBlock(
            imageAsset: 'assets/images/group_avatar.jpg',
            title: 'Title 1',
            body:
                '123456',
            buttonLabel: 'Button',
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          _ContentBlock(
            imageAsset: 'assets/images/group_avatar.jpg',
            title: 'Title 2',
            body:
                '123456',
            buttonLabel: 'Button',
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          _ContentBlock(
            imageAsset: 'assets/images/group_avatar.jpg',
            title: 'Title 3',
            body:
                '123456',
            buttonLabel: 'Button',
            onPressed: () {},
          ),

          const SizedBox(height: 20),

          // Grid section (6 cards, 2 rows x 3 columns)
          Text('Heading', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            'Subheading',
            style: textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 12),

          _SixCardGrid(
            items: List.generate(6, (i) {
              return _GridItemData(
                imageAsset: 'assets/images/group_avatar.jpg',
                title: 'Title ${i + 1}',
                body:
                    '132456',
                buttonLabel: 'Button',
              );
            }),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

/// Top navigation bar widget
class _TopNavBar extends StatelessWidget {
  const _TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorOnSurface = theme.colorScheme.onSurface;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 700;

        if (isNarrow) {
          // Mobile / narrow: logo + menu button
          return Row(
            children: [
              // Logo (replace with Image.asset if you have a logo file)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text('P', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Text('Phenikaa', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              // Popup menu for navigation items
              PopupMenuButton<int>(
                tooltip: 'Menu',
                icon: Icon(Icons.menu, color: colorOnSurface),
                onSelected: (value) {
                  // handle navigation selection
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 0, child: Text('Products')),
                  const PopupMenuItem(value: 1, child: Text('Solutions')),
                  const PopupMenuItem(value: 2, child: Text('Community')),
                  const PopupMenuItem(value: 3, child: Text('Resources')),
                  const PopupMenuItem(value: 4, child: Text('Pricing')),
                  const PopupMenuItem(value: 5, child: Text('Contact')),
                ],
              ),
            ],
          );
        }

        // Desktop / wide: full nav bar
        return Row(
          children: [
            // Logo
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text('P', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Text('Phenikaa', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(width: 24),

            // Navigation items
            _NavText('Products'),
            const SizedBox(width: 16),
            _NavText('Solutions'),
            const SizedBox(width: 16),
            _NavText('Community'),
            const SizedBox(width: 16),
            _NavText('Resources'),
            const SizedBox(width: 16),
            _NavText('Pricing'),
            const SizedBox(width: 16),
            _NavText('Contact'),

            const Spacer(),

            // Sign in / Register buttons
            TextButton(
              onPressed: () {},
              child: const Text('Sign in'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Register'),
            ),
          ],
        );
      },
    );
  }
}

class _NavText extends StatelessWidget {
  final String label;
  const _NavText(this.label);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        // handle navigation tap
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Text(label, style: theme.textTheme.bodyMedium),
      ),
    );
  }
}

/// Reusable content block (left image, text, button)
class _ContentBlock extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String body;
  final String buttonLabel;
  final VoidCallback onPressed;

  const _ContentBlock({
    required this.imageAsset,
    required this.title,
    required this.body,
    required this.buttonLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWide = MediaQuery.of(context).size.width > 600;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageAsset,
                width: isWide ? 120 : 72,
                height: isWide ? 80 : 56,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  width: isWide ? 120 : 72,
                  height: isWide ? 80 : 56,
                  color: theme.colorScheme.primary.withOpacity(0.08),
                  alignment: Alignment.center,
                  child: Icon(Icons.image, color: theme.colorScheme.primary, size: isWide ? 36 : 20),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(
                    body,
                    style: theme.textTheme.bodySmall?.copyWith(height: 1.3),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 72),
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(buttonLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Data model for grid items
class _GridItemData {
  final String imageAsset;
  final String title;
  final String body;
  final String buttonLabel;

  _GridItemData({
    required this.imageAsset,
    required this.title,
    required this.body,
    required this.buttonLabel,
  });
}

/// Grid widget: responsive 2x3 layout, collapses to 1 column on narrow screens
class _SixCardGrid extends StatelessWidget {
  final List<_GridItemData> items;

  const _SixCardGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // columns: 3 for wide, 2 for medium, 1 for narrow
    final int crossAxisCount = width >= 1000 ? 3 : (width >= 600 ? 2 : 1);
    final double spacing = 12;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return _GridCard(item: item);
      },
    );
  }
}

/// Single card in the grid
class _GridCard extends StatelessWidget {
  final _GridItemData item;

  const _GridCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  item.imageAsset,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(
                    color: theme.colorScheme.primary.withOpacity(0.06),
                    alignment: Alignment.center,
                    child: Icon(Icons.image, color: theme.colorScheme.primary),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(item.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(
              item.body,
              style: theme.textTheme.bodySmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(item.buttonLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

