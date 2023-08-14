import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final bool showPositioned;
  const Background({super.key, required this.showPositioned});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/foto fondo.PNG'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        if (showPositioned)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.200, // Ajusta la altura según tus necesidades
              color: const Color(0xFFf2cd48),
            ),
          ),
      ],
    );
  }
}
