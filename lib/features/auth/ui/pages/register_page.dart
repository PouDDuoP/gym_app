import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; 

import 'package:stability_front/core/widgets/space.dart';
import 'package:stability_front/core/widgets/app_colors.dart';
import 'package:stability_front/core/widgets/text_styles.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fistNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _isTermsAccepted = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final nameRegex = RegExp(r"^[A-Za-zñáéíóú]+(?:[ '-][A-Za-zñáéíóú]+)*$");
  bool _isHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fistNameController.dispose();
    _lastNameController.dispose();
    _birthdateController.dispose();
    _isTermsAccepted.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Minor allowed date
      lastDate: DateTime.now(), // Max allowed date
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _birthdateController.text = DateFormat('dd-MM-yyyy').format(picked); // Format date
      });
    }
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  // Alineación de los elementos en el centro del eje transversal.
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [                
                    // Título de la página.
                    Text(
                      'Registrar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.foreground,
                      ),
                    ),
                    Space.vertical(24.0),

                    TextFormField(
                      controller: _fistNameController,
                      style: TextStyle(color: AppColors.foreground), 
                      decoration: InputDecoration(
                        filled: true, 
                        fillColor: AppColors.backgroundInput, 
                        labelText: 'Nombre',
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
                        prefixIcon: const Icon(Icons.person),
                        prefixIconColor: AppColors.foreground
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu nombre';
                        }
                        if (!nameRegex.hasMatch(value)) {
                          return 'Por favor ingresa un nombre válido';
                        }
                        return null;
                      },
                    ),
                    Space.vertical(12.0),

                    TextFormField(
                      controller: _lastNameController,
                      style: TextStyle(color: AppColors.foreground), 
                      decoration: InputDecoration(
                        filled: true, 
                        fillColor: AppColors.backgroundInput, 
                        labelText: 'Apellidos',
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
                        prefixIcon: const Icon(Icons.person_outline),
                        prefixIconColor: AppColors.foreground
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu apellido';
                        }
                        if (!nameRegex.hasMatch(value)) {
                          return 'Por favor ingresa un apellido válido';
                        }
                        return null;
                      },
                    ),
                    Space.vertical(12.0),

                    TextFormField(
                      controller: _birthdateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      style: TextStyle(color: AppColors.foreground), 
                      decoration: InputDecoration(
                        filled: true, 
                        fillColor: AppColors.backgroundInput, 
                        labelText: 'Fecha de Nacimiento',
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
                        prefixIcon: const Icon(Icons.calendar_today),
                        prefixIconColor: AppColors.foreground
                      ),
                      keyboardType: TextInputType.datetime,
                      validator: (value) => value!.isEmpty ? 'Por favor ingresa su fecha de nacimiento' : null,
                    ),
                    Space.vertical(12.0),
                
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
                    Space.vertical(12.0),
                
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
                    Space.vertical(4.0),

                    FormField<bool>(
                      initialValue: false,
                      validator: (value) {
                        if (value == null || !value) {
                          return 'Debes aceptar los términos y condiciones';
                        }
                        return null;
                      },
                      builder: (formFieldState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: formFieldState.value,
                                  onChanged: (value) {
                                    formFieldState.didChange(value);
                                    setState(() {
                                      _isTermsAccepted.text = value.toString();
                                    });
                                  },
                                ),
                                const Expanded(
                                  child: Text(
                                    'Acepto los términos y condiciones',
                                    style: TextStyle(color: AppColors.foreground),
                                  ),
                                ),
                              ],
                            ),
                            if (formFieldState.hasError)
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  formFieldState.errorText!,
                                  style: TextStyle(color: const Color.fromARGB(255, 176, 47, 38)),
                                ),
                              ),
                          ],
                        );
                      },
                    ),

                    Space.vertical(32.0),

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
                        child: Text('Registrarme'),
                      ),
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