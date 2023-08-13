import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Reloj extends StatelessWidget {
  const Reloj({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: MediaQuery.of(context).size.width / 2 -
              30, // Ajusta la posición del reloj
          child: SizedBox(
            width: 400,
            height: 450,
            child: SvgPicture.asset(
              'assets/svg/reloj.svg', // Ruta de tu SVG de reloj
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
