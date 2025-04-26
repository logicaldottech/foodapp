import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreProductCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final Color primary;

  const ExploreProductCard({
    super.key,
    required this.item,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSubscription = item['type'] == 'Subscription';
    final IconData icon =
        isSubscription ? Icons.subscriptions : Icons.shopping_cart;

    return Container(
      constraints: const BoxConstraints(maxWidth: 330),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📸 Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              item['image'],
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),

          // 📋 Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item['tagline'],
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: Colors.grey[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(item['price'],
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: item['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item['type'],
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: item['color']),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

          const SizedBox(width: 10),

          // 🔘 Icon Button
          ElevatedButton(
            onPressed: () {
              // TODO: Trigger Add to Cart or Subscribe flow
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Icon(icon, size: 18),
          ),
        ],
      ),
    );
  }
}
