import 'package:flutter/material.dart';
import 'package:smartparking/screens/vehiculo/registrar_vehiculo_screen.dart';

class CardContainer extends StatelessWidget {
   CardContainer({
    Key? key,
  }) : super(key: key);

  final List<IconData> icons = [
    Icons.star,
    Icons.favorite,
    Icons.thumb_up,
    Icons.lightbulb,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 450,
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Acción de navegación al hacer clic en el elemento
              navigateToScreen(context, index);
            },
            child: Container(
              height: 100, // Ajusta la altura según tus necesidades
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Center(
                child: Icon(
                  icons[index], // Asigna el icono según el índice
                  color: Colors.white,
                  size: 40.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>   VehiculoForm()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreenTwo()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreenThree()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreenFour()));
        break;
      default:
        break;
    }
  }
}

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen One'),
      ),
      body: const Center(
        child: Text('Content for Screen One'),
      ),
    );
  }
}

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Two'),
      ),
      body: const Center(
        child: Text('Content for Screen Two'),
      ),
    );
  }
}

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Three'),
      ),
      body: const Center(
        child: Text('Content for Screen Three'),
      ),
    );
  }
}

class ScreenFour extends StatelessWidget {
  const ScreenFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Four'),
      ),
      body: const Center(
        child: Text('Content for Screen Four'),
      ),
    );
  }
}