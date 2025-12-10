import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/surgery_provider.dart';
import '../../widgets/animated_loader.dart';

class MySurgeryScreen extends StatefulWidget {
  const MySurgeryScreen({super.key});

  @override
  State<MySurgeryScreen> createState() => _MySurgeryScreenState();
}

class _MySurgeryScreenState extends State<MySurgeryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<SurgeryProvider>(
        context,
        listen: false,
      ).getSurgeryDataProvider();
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xff0E0E0E) : Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff00796B),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          "My Surgeries",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.04,
            vertical: h * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info top box
              Container(
                padding: EdgeInsets.all(w * 0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    colors: isDark
                        ? [
                            Colors.white.withOpacity(0.08),
                            Colors.white.withOpacity(0.04),
                          ]
                        : [
                            Colors.white.withOpacity(0.90),
                            Colors.white.withOpacity(0.70),
                          ],
                  ),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.12)
                        : Colors.black12,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.6)
                          : Colors.black12,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.orange,
                      size: 28,
                    ),
                    SizedBox(width: w * 0.03),
                    Expanded(
                      child: Text(
                        "Your surgery bookings and status details.",
                        style: TextStyle(
                          fontSize: w * 0.035,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.03),

              // LIST
              Consumer<SurgeryProvider>(
                builder: (context, value, child) {
                  if (value.surgeryList.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 240),
                        child: MedicalHeartECGLoader(
                          width: 320,
                          color: Colors.teal.shade100,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.surgeryList.length,
                    itemBuilder: (context, index) {
                      var item = value.surgeryList[index];

                      return SurgeryCard(
                        name: item.name ?? '',
                        phone: item.phone_no ?? '',
                        type: item.surgery_type ?? '',
                        description: item.description ?? '',
                        status: item.status ?? '',
                        bookedAt: item.booked_At ?? "",
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SurgeryCard extends StatelessWidget {
  final String name;
  final String phone;
  final String type;
  final String description;
  final String status;
  final String bookedAt;

  const SurgeryCard({
    super.key,
    required this.name,
    required this.phone,
    required this.type,
    required this.description,
    required this.status,
    required this.bookedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: $name", style: const TextStyle(fontSize: 16)),
            Text("Phone: $phone"),
            Text("Surgery Type: $type"),
            Text("Description: $description"),
            Text("Status: $status"),
            Text("Booked At: $bookedAt"),
          ],
        ),
      ),
    );
  }
}
