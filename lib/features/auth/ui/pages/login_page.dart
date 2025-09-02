import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stability_front/core/widgets/space.dart';
import 'package:stability_front/core/widgets/app_colors.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

import '../pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

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
                    Space.vertical(MediaQuery.of(context).size.height * 0.32),
                
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
                    Space.vertical(32.0),
                
                    TextFormField(
                      controller: _emailController,
                      style: TextStyle(color: AppColors.foreground), 
                      decoration: InputDecoration(
                        filled: true, 
                        fillColor: AppColors.backgroundInput, 
                        labelText: 'Correo Electronico',
                        labelStyle: TextStyle(
                          color: AppColors.foreground,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: AppColors.foreground),
                        ),
                        prefixIcon: const Icon(Icons.email),
                        prefixIconColor: AppColors.foreground
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
                    Space.vertical(16.0),
                
                    TextFormField(
                      controller: _passwordController,
                      style: TextStyle(color: AppColors.foreground), 
                      decoration: InputDecoration(
                        filled: true, 
                        fillColor: AppColors.backgroundInput, 
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(
                          color: AppColors.foreground,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: AppColors.foreground),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        prefixIconColor: AppColors.foreground,
                        suffixIcon: GestureDetector(
                          onTap: _togglePasswordView,
                          child: Icon(
                              _isHidden ? Icons.visibility : Icons.visibility_off,
                            )
                          ),
                        suffixIconColor: AppColors.foreground,
                      ),
                      obscureText: _isHidden,
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
                    Space.vertical(16.0),

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
                    
                    Space.vertical(24.0),
                    
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
                    Space.vertical(8.0),
                        
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
                        
                        Space.horizontal(12.0),
                        
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
                        
                        Space.horizontal(12.0),
                
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
                    Space.vertical(2.0),
                
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
                            Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => RegisterPage(
                                // height: selectedHeight,
                                // weight: selectedWeight,
                              ))
                            );
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

}