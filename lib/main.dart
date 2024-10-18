import 'package:flutter/material.dart';

void main() {
  runApp(const Examen1());
}

class Examen1 extends StatelessWidget {
  const Examen1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 108, 3, 3)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHome(title: 'Agenda de Ingenieros'),
    );
  }
}

class Agenda {
  final String nombre;
  final String control;

  Agenda(this.nombre, this.control);
}

class MyHome extends StatefulWidget {
  const MyHome({super.key, required this.title});

  final String title;

  @override
  State<MyHome> createState() => _PrincipalState();
}

class _PrincipalState extends State<MyHome> {
  final List<Agenda> _contactos = [];
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _controlController = TextEditingController();
  int _contactosContados = 0;

  final _formKey = GlobalKey<FormState>();

  void _agregarContacto() {
    if (_formKey.currentState!.validate()) {
      final nombre = _nombreController.text.trim();
      final control = _controlController.text.trim();

      setState(() {
        _contactos.add(Agenda(nombre, control));
        _contactosContados++;
        _nombreController.clear();
        _controlController.clear();
      });
    }
  }

  void _verAgenda() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListadoContactos(contactos: _contactos),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromARGB(255, 150, 37, 37), 
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Agenda',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20), // Espacio entre el título y los campos
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    hintText: 'Nombre completo',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El nombre no puede estar vacío';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10), 
                TextFormField(
                  controller: _controlController,
                  decoration: const InputDecoration(
                    hintText: 'No. de control',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El número de control no puede estar vacío';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10), 
                Text('Contactos agregados: $_contactosContados'),
                const SizedBox(height: 20), 
                const SizedBox(height: 20), 
                ElevatedButton(
                  onPressed: _agregarContacto,
                  child: const Text('Agregar'),
                ),
                const Divider(
                  color:  const Color.fromARGB(255, 150, 37, 37), 
                  thickness: 2, 
                ),
                const SizedBox(height: 10), 
                ElevatedButton(
                  onPressed: _verAgenda,
                  child: const Text('Ver agenda'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListadoContactos extends StatelessWidget {
  final List<Agenda> contactos;

  const ListadoContactos({super.key, required this.contactos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Contactos'),
        backgroundColor:  const Color.fromARGB(255, 150, 37, 37)
      ),
      body: ListView.builder(
        itemCount: contactos.length,
        itemBuilder: (context, index) {
          final contacto = contactos[index];
          return ListTile(
            title: Text(contacto.nombre),
            subtitle: Text(contacto.control),
          );
        },
      ),
    );
  }
}



