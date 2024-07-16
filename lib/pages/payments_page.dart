import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import '../models/invoice_model.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  PaymentsPageState createState() => PaymentsPageState();
}

class PaymentsPageState extends State<PaymentsPage> {
  List<Invoice> invoices = [
    Invoice(
      invoiceNumber: 'INV001',
      clientName: 'John Doe',
      amount: 150.00,
      dueDate: DateTime.now().add(const Duration(days: 15)),
      isPaid: false,
      pdfPath: 'facture.pdf',
    ),
    Invoice(
      invoiceNumber: 'INV002',
      clientName: 'Jane Smith',
      amount: 200.00,
      dueDate: DateTime.now().add(const Duration(days: 10)),
      isPaid: true,
      pdfPath: 'facture.pdf',
    ),
    Invoice(
      invoiceNumber: 'INV003',
      clientName: 'Jim Beam',
      amount: 250.00,
      dueDate: DateTime.now().add(const Duration(days: 5)),
      isPaid: false,
      pdfPath: 'facture.pdf',
    ),
  ];

  void _markAsPaid(int index) {
    setState(() {
      invoices[index].isPaid = true;
    });
  }

  void _deleteInvoice(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: const Text('Êtes-vous sûr de vouloir supprimer cette facture ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                invoices.removeAt(index);
              });
              Navigator.of(context).pop();
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadInvoice(String pdfPath) async {
    try {
      final ByteData data = await rootBundle.load('assets/$pdfPath');
      final Uint8List bytes = data.buffer.asUint8List();
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/$pdfPath';
      final file = File(path);
      await file.writeAsBytes(bytes);
      OpenFile.open(path);
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalRevenue = invoices.fold(0, (sum, item) => sum + item.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paiements'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Numéro de facture')),
                DataColumn(label: Text('Nom du client')),
                DataColumn(label: Text('Montant')),
                DataColumn(label: Text('Date d\'échéance')),
                DataColumn(label: Text('Statut')),
                DataColumn(label: Text('Actions')),
              ],
              rows: invoices.map((invoice) {
                return DataRow(
                  cells: [
                    DataCell(Text(invoice.invoiceNumber)),
                    DataCell(Text(invoice.clientName)),
                    DataCell(Text('${invoice.amount} €')),
                    DataCell(Text(invoice.dueDate.toLocal().toString().split(' ')[0])),
                    DataCell(Text(
                      invoice.isPaid ? 'Payé' : 'Non payé',
                      style: TextStyle(
                        color: invoice.isPaid ? Colors.green : Colors.red,
                      ),
                    )),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: invoice.isPaid
                              ? null
                              : () {
                            _markAsPaid(invoices.indexOf(invoice));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteInvoice(invoices.indexOf(invoice));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () {
                            _downloadInvoice(invoice.pdfPath);
                          },
                        ),
                      ],
                    )),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Total Revenue: $totalRevenue €',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
