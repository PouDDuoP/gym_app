// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: TextField(
//             keyboardType: TextInputType.emailAddress,
//             decoration: InputDecoration(
//               prefixIcon: Icon(Icons.email),
//               border: OutlineInputBorder(),
//               labelText: 'Enter your email',
//             ),
//           ),
//         ),
//         SizedBox(height: 20),
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: TextField(
//             obscureText: true,
//             decoration: InputDecoration(
//               prefixIcon: Icon(Icons.lock),
//               border: OutlineInputBorder(),
//               labelText: 'Enter your password',
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/widgets/vertical_space.dart';
import 'package:gym_app/core/widgets/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Login')),
      backgroundColor: AppColors.background,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // Escuchamos los estados para manejar la navegación o mostrar mensajes
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('¡Inicio de sesión exitoso!')),
            );
            // Navegar a la pantalla principal
            // Navigator.of(context).pushReplacementNamed('/');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          // Construimos la UI en base al estado actual
          return Center(
            // Se utiliza un SingleChildScrollView para evitar desbordamiento al usar el teclado en dispositivos móviles.
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  // Alineación de los elementos en el centro del eje principal.
                  mainAxisAlignment: MainAxisAlignment.end,
                  // Alineación de los elementos en el centro del eje transversal.
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Colocado para empujar el contenido, notra: tengo que verificar si con la imagen lo empuja o no
                    SizedBox(height: MediaQuery.of(context).size.height * 0.32),
                
                    // Título de la página.
                    Text(
                      'STABILITY',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.foreground,
                      ),
                    ),
                    SizedBox(height: 32),
                
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo Electronico', // Pudiese ser usuario y Contraseña?
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu email';
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Por favor ingresa un email válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu contraseña';
                        }
                        if (value.length < 6) {
                          return 'La contraseña debe tener al menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    if (state is AuthLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para el inicio de sesión.
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              LoginRequested(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secundary,
                          foregroundColor: AppColors.foreground,
                          padding: const EdgeInsets.only(top: 16, bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text('Iniciar Sesión'),
                      ),
                    
                    SizedBox(height: 24),
                    
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            'O',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 8),
                        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              // Lógica para inicio de sesión con Google.
                            },
                            icon: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/2048px-Google_%22G%22_logo.svg.png',
                              height: 24,
                            ),
                          ),
                        ),
                        
                        SizedBox(width: 12),
                        
                        Expanded(
                          child: IconButton(
                            iconSize: 40,
                            onPressed: () {
                              // Lógica para inicio de sesión con Apple.
                            },
                            icon: Icon(
                              Icons.apple,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        
                        SizedBox(width: 12),
                
                        Expanded(
                          child: IconButton(
                            iconSize: 40,
                            onPressed: () {
                              // Lógica para inicio de sesión con Facebook.
                            },
                            icon: Icon(
                              Icons.facebook,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                    SizedBox(height: 2),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No tienes una cuenta?', 
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        
                        TextButton(
                          onPressed: () {
                            // Lógica para navegar a la pantalla de registro.
                          },
                          child: const Text(
                            'Crear una cuenta',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}