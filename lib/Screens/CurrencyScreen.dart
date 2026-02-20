import 'package:api/Provider/CurrencyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final TextEditingController amountController = TextEditingController();

  String? selectedFrom;
  String? selectedTo;
  double? convertedAmount;

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<CurrencyProvider>();
      provider.getCurrencies();
      provider.getCurrencyConversion(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CurrencyProvider>();

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                'https://plus.unsplash.com/premium_photo-1679397476740-a236a0c87fad?fm=jpg&q=60&w=3000&auto=format&fit=crop',
                fit: BoxFit.cover,
              ),
            ),
            Container(color: Colors.black.withOpacity(0.4)),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "Convert Any Currency",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 28),
                              ),
                              const SizedBox(height: 20),

                              /// Amount Input
                              TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: "Enter Amount",
                                  border: OutlineInputBorder(),
                                ),
                              ),

                              const SizedBox(height: 20),

                              /// Dropdowns
                              (provider.currencies ?? {}).isEmpty
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: DropdownMenu<String>(
                                            initialSelection: selectedFrom,
                                            label: const Text("From"),
                                            onSelected: (value) {
                                              setState(() {
                                                selectedFrom = value;
                                              });
                                            },
                                            dropdownMenuEntries: (provider
                                                    .currencies ??
                                                {})
                                                .entries
                                                .map(
                                                  (entry) =>
                                                      DropdownMenuEntry<String>(
                                                    value: entry.key,
                                                    label:
                                                        "${entry.key} - ${entry.value}",
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          "To",
                                          style:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: DropdownMenu<String>(
                                            initialSelection: selectedTo,
                                            label: const Text("To"),
                                            onSelected: (value) {
                                              setState(() {
                                                selectedTo = value;
                                              });
                                            },
                                            dropdownMenuEntries: (provider.currencies ?? {})
                                                .entries
                                                .map(
                                                  (entry) =>
                                                      DropdownMenuEntry<String>(
                                                    value: entry.key,
                                                    label:
                                                        "${entry.key} - ${entry.value}",
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),

                              const SizedBox(height: 20),

                              /// Convert Button
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                ),
                                onPressed: () {
                                  if (amountController.text.isEmpty ||
                                      selectedFrom == null ||
                                      selectedTo == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Please fill all fields")),
                                    );
                                    return;
                                  }

                                  if (provider.currencyModel == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Rates not loaded yet")),
                                    );
                                    return;
                                  }

                                  final amount =
                                      double.tryParse(amountController.text);

                                  if (amount == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Enter valid number")),
                                    );
                                    return;
                                  }

                                  final fromRate = provider
                                          .currencyModel!
                                          .rates[selectedFrom] ??
                                      1;

                                  final toRate = provider
                                          .currencyModel!
                                          .rates[selectedTo] ??
                                      1;

                                  final result =
                                      (amount / fromRate) * toRate;

                                  setState(() {
                                    convertedAmount = result;
                                  });
                                },
                                child: const Text(
                                  "Convert",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),

                              const SizedBox(height: 20),

                              /// Result
                              Text(
                                convertedAmount == null
                                    ? "Converted Amount: -"
                                    : "Converted Amount: ${convertedAmount!.toStringAsFixed(2)}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}