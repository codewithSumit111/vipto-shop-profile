import 'package:flutter/material.dart';

/// A simple model representing the data a Shop Profile screen needs.
/// In the real app this would come from an API response; here it's
/// hard-coded dummy data since no backend integration is required.
class ShopProfile {
  final String imageUrl;
  final String name;
  final String category;
  final double rating;
  final int reviewCount;
  final String address;
  final String about;
  final String contactNumber;
  final bool isOpen;

  const ShopProfile({
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.address,
    required this.about,
    required this.contactNumber,
    required this.isOpen,
  });
}

const dummyShop = ShopProfile(
  imageUrl:
      'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800&q=80',
  name: 'Sharma Electronics',
  category: 'Electronics & Mobile Accessories',
  rating: 4.6,
  reviewCount: 218,
  address: 'Shop No. 12, FC Road, Near Deccan Gymkhana, Pune, Maharashtra 411004',
  about:
      'Sharma Electronics has been serving the Deccan Gymkhana neighborhood '
      'for over 15 years. We stock mobile accessories, chargers, laptop '
      'parts, and a wide range of electronics at fair prices, with genuine '
      'products and honest service.',
  contactNumber: '+91 98765 43210',
  isOpen: true,
);

class ShopProfileScreen extends StatelessWidget {
  const ShopProfileScreen({super.key, this.shop = dummyShop});

  final ShopProfile shop;

  static const _brandColor = Color(0xFFFF6B35);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNameAndStatus(),
                  const SizedBox(height: 6),
                  _buildCategoryChip(),
                  const SizedBox(height: 14),
                  _buildRatingRow(),
                  const SizedBox(height: 24),
                  _buildInfoCard(
                    icon: Icons.location_on_outlined,
                    title: 'Shop Address',
                    content: shop.address,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    icon: Icons.info_outline,
                    title: 'About Shop',
                    content: shop.about,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    icon: Icons.call_outlined,
                    title: 'Contact Number',
                    content: shop.contactNumber,
                  ),
                  const SizedBox(height: 32),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Sections
  // ---------------------------------------------------------------------

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 240,
      backgroundColor: _brandColor,
      leading: _circleIconButton(
        icon: Icons.arrow_back,
        onTap: () => Navigator.maybePop(context),
      ),
      actions: [
        _circleIconButton(icon: Icons.share_outlined, onTap: () {}),
        const SizedBox(width: 12),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              shop.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: _brandColor.withOpacity(0.2),
                child: const Icon(Icons.storefront,
                    size: 72, color: Colors.white70),
              ),
            ),
            // Gradient overlay so the back/share buttons stay legible.
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.35),
                    Colors.transparent,
                    Colors.black.withOpacity(0.25),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.35),
        child: IconButton(
          icon: Icon(icon, color: Colors.white, size: 20),
          onPressed: onTap,
        ),
      ),
    );
  }

  Widget _buildNameAndStatus() {
    return Row(
      children: [
        Expanded(
          child: Text(
            shop.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ),
        _buildStatusBadge(),
      ],
    );
  }

  Widget _buildStatusBadge() {
    final color = shop.isOpen ? Colors.green : Colors.redAccent;
    final label = shop.isOpen ? 'Open Now' : 'Closed';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _brandColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        shop.category,
        style: const TextStyle(
          color: _brandColor,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildRatingRow() {
    return Row(
      children: [
        const Icon(Icons.star_rounded, color: Color(0xFFFFB800), size: 22),
        const SizedBox(width: 4),
        Text(
          shop.rating.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(width: 6),
        Text(
          '(${shop.reviewCount} reviews)',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _brandColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _brandColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 14.5,
                    color: Color(0xFF2A2A2A),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.call, size: 18),
            label: const Text('Call Shop'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _brandColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.directions_outlined, size: 18),
            label: const Text('Directions'),
            style: OutlinedButton.styleFrom(
              foregroundColor: _brandColor,
              side: const BorderSide(color: _brandColor),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
