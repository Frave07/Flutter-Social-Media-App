import 'package:form_field_validator/form_field_validator.dart';


final validatedEmail = MultiValidator([
  RequiredValidator(errorText: 'El correo es requerido'),
  EmailValidator(errorText: 'Ingresa un correo valido')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Contraseña es requerida'),
  MinLengthValidator(8, errorText: 'Minimo 8 caracteres')
]);