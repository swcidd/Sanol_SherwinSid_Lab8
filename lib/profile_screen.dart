import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              _buildProfileHeader(context),
              const SizedBox(height: 32),
              _buildSettingsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              'https://scontent.fcgy2-4.fna.fbcdn.net/v/t39.30808-6/489823654_638527112358797_3786538714552230693_n.jpg?stp=dst-jpg_tt6&cstp=mx960x960&ctp=s960x960&_nc_cat=105&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeGKtYf_2vYnWhr_lrZCyxCKXYDAfknq8w1dgMB-SerzDe1rz22A3nDOit6U7IVGr3JbHkA7AhYI2GtHiPdWEbbw&_nc_ohc=3iI6IOOI2CgQ7kNvwEFlRx9&_nc_oc=AdoACfcauzIipAjyejWWXvp09VJ3q7FvqxXlmnVG3roKlONpMwJNGs_wXbu2sdnCRSE&_nc_zt=23&_nc_ht=scontent.fcgy2-4.fna&_nc_gid=4ydoPcG8h-uhmtCXoY3b4g&_nc_ss=7b2a8&oh=00_AQIYcvyQhZKnilM10CqjaJTCdMyC-EfO68Y_uOaFDxReJw&oe=6A9E0E36',
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Sherwin Sid',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'sanol.sherwinsid@gmail.com',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: LuminousColors.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: LuminousColors.containerLow,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            _SettingsTile(
              icon: Icons.receipt_long,
              title: 'My Orders',
              subtitle: 'View your order history',
              onTap: () {},
            ),
            const Divider(height: 1, indent: 56),
            _SettingsTile(
              icon: Icons.location_on_outlined,
              title: 'Shipping Address',
              subtitle: 'Manage your addresses',
              onTap: () {},
            ),
            const Divider(height: 1, indent: 56),
            _SettingsTile(
              icon: Icons.credit_card,
              title: 'Payment Methods',
              subtitle: 'Manage your cards',
              onTap: () {},
            ),
            const Divider(height: 1, indent: 56),
            _SettingsTile(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              subtitle: 'Push & email preferences',
              onTap: () {},
            ),
            const Divider(height: 1, indent: 56),
            _SettingsTile(
              icon: Icons.help_outline,
              title: 'Help & Support',
              subtitle: 'Get assistance',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: LuminousColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 22, color: LuminousColors.onSurface),
      ),
      title: Text(
        title,
        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          color: LuminousColors.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        size: 20,
        color: LuminousColors.onSurface.withValues(alpha: 0.4),
      ),
      onTap: onTap,
    );
  }
}
