// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'bordercliprect.dart';

class Contenido extends StatelessWidget {
  const Contenido({
    Key? key,
    required this.miColor,
  }) : super(key: key);
  final Color miColor;
  @override
  Widget build(BuildContext context) {
    //varable para dar  color en cada pantalla de la app

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height *
                0.15, // 15% de la altura de la pantalla
            width: MediaQuery.of(context).size.width *
                0.30, // 15% del ancho de la pantalla
            alignment: Alignment.center,
            child: Transform.scale(
              scale: 3, // Cambia este valor para ajustar el tamaño del SVG
              child: SvgPicture.asset(
                'assets/svg/logoTwiins.svg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.width * 0.90,
              margin: const EdgeInsets.symmetric(horizontal: 60),
              decoration: BoxDecoration(
                color: miColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Espacio entre los campos

                    SizedBox(
                      width: double
                          .infinity, // Ancho igual al de los TextFormField
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF343233), // Color de fondo deseado
                        ),
                        child: const Text('HUELLA DIGITAL'),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: CustomPaint(
                        foregroundPainter: BorderPainter(),
                        child: Container(
                          height: 200,
                          width: 200,
                          alignment: Alignment.center, // <---- The magic
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            'assets/svg/interna - huella digital.svg',
                            fit: BoxFit.contain,
                            height: 150,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
