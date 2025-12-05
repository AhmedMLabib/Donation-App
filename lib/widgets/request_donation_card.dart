import 'package:flutter/material.dart';

class RequestDonationCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String status;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const RequestDonationCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.status,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(imagePath, width: 50, height: 50),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(status, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: buttonText != null
            ? SizedBox(
                width: 130,
                child: ElevatedButton(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                  ),
                  child: Text(
                    buttonText!,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
