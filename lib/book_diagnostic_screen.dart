import 'package:flutter/material.dart';

class BookDiagnosticScreen extends StatelessWidget {
  const BookDiagnosticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,

        appBar: AppBar(
          backgroundColor: Colors.teal,
          leading:  Icon(Icons.arrow_back, color: Colors.white),
          title:  Text(
            "Book Diagnostic Reports",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),

        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'Patient Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12),

                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset:  Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(

                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Patient Name',
                            //isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style:  TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Change patient logic
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize:  Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child:  Text(
                          'Change Patient',
                          style: TextStyle(
                            color: Color(0xFF00BCD4),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),


                Container(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset:  Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Apply Coupon',
                            hintStyle: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style:  TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black54,
                        size: 24,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Bill Details Section
                Text(
                  'Bill Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),

                // Bill Details Card
                Container(
                  padding:  EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    children: [
                      _buildBillRow('Total MRP', '₹934'),
                      SizedBox(height: 12),
                      _buildBillRow('sample Pickup charges', '₹0'),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding:  EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color:  Color(0xFF00BCD4),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child:  Text(
                              'PLUS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Discount',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '-₹0.00',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Divider(height: 1, thickness: 1),
                      SizedBox(height: 16),
                      _buildBillRow('Payable Amount', '₹934.00', isTotal: true),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Cancellation Policy
                Container(
                  padding:  EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please check your order details to avoid cancellation',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'An order can be cancelled with full refund 2 hours before sample pickup.If you still want to cancel the order ,please reach out to our support team.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100,
                        color: Colors.white,
                        padding: EdgeInsets.all(12),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10),),
                                  ),
                                ),
                                child: Text("Add Patient Details & Address",style: TextStyle(color: Colors.black,fontSize: 16),),
                              ),
                            ),
                          ),
                        ),
                      )



                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildBillRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
