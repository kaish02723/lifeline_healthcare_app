import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/providers/surgery_provider/surgery_provider.dart';
import 'package:lifeline_healthcare_app/screens/surgery/my_surgery_screen.dart';
import 'package:provider/provider.dart';

class SurgeryBookingScreen extends StatefulWidget {
  const SurgeryBookingScreen({super.key});

  @override
  State<SurgeryBookingScreen> createState() => _SurgeryBookingScreenState();
}

class _SurgeryBookingScreenState extends State<SurgeryBookingScreen> {
  String? selectedCity;

  final List<String> surgeryTypes = ["Heart", "Lungs", "Kidney", "Eyes"];
  final List<String> cities = ["Mumbai", "Delhi", "Kolkata", "Patna"];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff00796B),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Book for Surgery",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _headerRow(theme),
            const SizedBox(height: 20),
            _formCard(theme),
            const SizedBox(height: 25),
            _glassDoctorCard(theme),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _headerRow(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Text(
              "LifeLine ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              "HealthCare",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xffFFB956),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        _callNowButton(theme),
      ],
    );
  }

  Widget _callNowButton(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: theme.colorScheme.secondary, width: 1.4),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.call, size: 16, color: theme.colorScheme.secondary),
                const SizedBox(width: 6),
                Text(
                  "Call Now",
                  style: TextStyle(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formCard(ThemeData theme) {
    var theme = Theme.of(context);
    var isDark = theme.brightness == Brightness.dark;
    var provider = Provider.of<SurgeryProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.cardColor.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color:
                  isDark
                      ? Colors.white.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                "Book an appointment with the best surgeons\nfor your health needs.",
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 25),
              _premiumTextField(theme, provider.testNameController, "Name"),
              const SizedBox(height: 14),
              _premiumTextField(
                theme,
                provider.testPhoneNoController,
                "Phone Number",
                keyboard: TextInputType.phone,
              ),
              const SizedBox(height: 14),
              _premiumDropdown(
                theme: theme,
                hint: "Surgery Type",
                value: provider.selectedSurgery,
                items: surgeryTypes,
                onChanged: (value) {
                  provider.changeSelectedSurgeryValue(value!);
                },
              ),
              const SizedBox(height: 14),
              _premiumTextField(
                theme,
                provider.testDescriptionController,
                "Description",
                maxLines: 4,
              ),
              const SizedBox(height: 22),
              Consumer<SurgeryProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return _gradientButton(
                    theme,
                    title: "Book Appointment",
                    icon: Icons.phone,
                    onTap: () {
                      value.addSurgeryDataProvider(context);
                    },
                  );
                },
              ),
              const SizedBox(height: 12),
              Text(
                "By submitting this form, you agree to LifeLine HealthCare’s T&C",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _premiumTextField(
    ThemeData theme,
    TextEditingController controller,
    String hint, {
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      decoration: _inputDecoration(theme),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.hintColor,
          ),
        ),
      ),
    );
  }

  Widget _premiumDropdown({
    required ThemeData theme,
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: _inputDecoration(theme),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          hint: Text(
            hint,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          ),
          value: value,
          items:
              items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  BoxDecoration _inputDecoration(ThemeData theme) {
    return BoxDecoration(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: theme.dividerColor),
      boxShadow: [
        BoxShadow(
          color: theme.shadowColor.withOpacity(0.03),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Widget _gradientButton(
    ThemeData theme, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [Color(0xff26A69A), Color(0xff00796B)],
          ),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: theme.colorScheme.onPrimary),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassDoctorCard(ThemeData theme) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.cardColor.withOpacity(0.55),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                offset: const Offset(0, 6),
                color: Colors.black.withOpacity(0.01),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage("assets/images/doctor1.png"),
                  ),
                  SizedBox(width: 12),
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage("assets/images/doctor3.png"),
                  ),
                  SizedBox(width: 12),
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage("assets/images/doctor2.png"),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                "Our top surgeons are ready to help you.",
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Available now to answer all your queries",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
              const SizedBox(height: 16),
              _gradientButton(
                theme,
                title: "Call Now",
                icon: Icons.call,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
