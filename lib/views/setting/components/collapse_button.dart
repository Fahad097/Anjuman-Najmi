import 'package:flutter/material.dart';

class CollapseButton extends StatelessWidget {
  CollapseButton({Key? key, required this.onTapDEL, required this.onEditTap});
  final VoidCallback onEditTap;
  final VoidCallback onTapDEL;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTapDEL,
          child: CustomPaint(
              size: Size(26, 26), // Set the size of the canvas
              painter: CirclePainter(),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              )),
        ),

        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: onEditTap,
          child: CustomPaint(
              size: Size(26, 26), // Set the size of the canvas
              painter: CirclePainter(),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              )),
        ),
        SizedBox(
          width: 5,
        ),
        // InkWell(
        //   onTap: () {
        //     if (isBtnPressed == true) {
        //       setState(() {
        //         isBtnPressed = false;
        //         // isBtnPressed ? isBtnPressed = false : isBtnPressed = true;
        //       });
        //     } else if (isBtnPressed == false) {
        //       setState(() {
        //         isBtnPressed = true;
        //       });
        //     }
        //   },
        //   child: CustomPaint(
        //     size: Size(26, 26), // Set the size of the canvas
        //     painter: CirclePainter(),
        //     child: Padding(
        //       padding: const EdgeInsets.all(2.0),
        //       child: ImageIcon(
        //         AssetImage(AssetConfig.kmoreHorizontleIcon),
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..color = Color(0xFF2E4D9D)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
