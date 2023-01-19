part of generator_types;

abstract class TypeGenerator {
  final int id;
  final String fileName;
  final String className;
  final String filePath;
  final bool isGeneric;
  final List<String> imports;
  final List<TypeFields> fields;
  final List<String> docs;

  const TypeGenerator({
    required this.id,
    required this.fileName,
    required this.className,
    required this.filePath,
    required this.isGeneric,
    required this.fields,
    this.imports = const <String>[],
    this.docs = const <String>[],
  });

  String toClass() {
    final buffer = StringBuffer();

    //
    // Write imports
    buffer
      ..writeln(toImports())

      //
      //Write class name
      ..write('class ')
      ..write(className)

      //
      // Generate <T, K> generics if exists
      ..write(toGenerics())

      //
      // Extend Current class to scale_codec.Encoder
      ..writeln(' extends scale_codec.Encoder {')

      //
      // Write fields type definitions `final TypeName{?} variableName;`
      ..writeln(toTypeDefinitions())

      //
      // Write constructor with required fields
      ..write('  ')
      ..write(className)
      ..write('(')

      //
      // Write constructor fields
      // {
      // `required this.variableName,`
      // `this.variableName,` // if nullable
      // }
      ..write(toConstructorDefinitions())
      ..writeln(');')

      //
      // Write empty line
      ..writeln()

      //
      // Write encode method
      ..writeln(toEncodeMethod())

      //
      // Write close class
      ..writeln('}');

    return buffer.toString();
  }

  ///
  /// Generate Encode method
  ///
  /// ```dart
  /// @override
  /// void encode(scale_codec.Encoder encoder) {
  ///  variableName.encode(encoder);
  /// }
  /// ```
  String toEncodeMethod() {
    final buffer = StringBuffer();

    buffer
      ..writeln('  @override')
      ..writeln('  void encode(scale_codec.Encoder encoder) {');
    for (final field in fields) {
      buffer
        ..write('    ')
        ..write(field.fieldVariableName);
      if (field.isNullable) {
        buffer.write('?');
      }
      buffer.writeln('.encode(encoder);');
    }
    buffer.writeln('  }');

    return buffer.toString();
  }

  ///
  /// Get imports
  ///
  /// ```dart
  /// import 'some_other_import.dart';
  /// import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as scale_codec;
  /// ```
  String toImports() {
    final buffer = StringBuffer();

    for (final import in imports.toSet()) {
      buffer.writeln('import \'$import\';');
    }
    buffer.writeln(
        'import \'package:polkadart_scale_codec/polkadart_scale_codec.dart\'; as scale_codec');

    return buffer.toString();
  }

  ///
  /// Get generic type names
  ///
  /// ```dart
  /// <T extends scale_codec.Encode, V extends scale_codec.Encode>
  /// ```
  String toGenerics() {
    final buffer = StringBuffer();

    //
    // Get generics list and check if it is empty or not
    final genericFields = fields.where((field) => field.isGeneric).toList();

    if (genericFields.isEmpty) {
      return '';
    }

    buffer.write('<');

    for (var index = 0; index < genericFields.length - 1; index++) {
      buffer
        ..write(genericFields[index].fieldType)
        ..write(' extends scale_codec.Encoder, ');
    }
    buffer
      ..write(genericFields.last.fieldType)
      ..write(' extends scale_codec.Encoder')
      ..write('>');

    return buffer.toString();
  }

  ///
  /// Get field type definitions
  ///
  /// ```dart
  /// final TypeName{?} variableName;
  /// ```
  String toTypeDefinitions() {
    if (fields.isEmpty) {
      return '';
    }
    final buffer = StringBuffer();

    buffer.writeln();

    //
    // Check if fields are present or not
    //
    // If fields are present then generate type definitions
    //
    // final TypeName variableName;
    for (final field in fields) {
      buffer
        ..write('final ')
        ..write(field.fieldType);
      if (field.isNullable) {
        buffer.write('?');
      }
      buffer
        ..write(' ')
        ..write(field.fieldVariableName)
        ..writeln(';');
    }

    return buffer.toString();
  }

  ///
  /// Get constructor definitions
  ///
  /// ```dart
  /// {
  /// required this.variableName,
  /// this.variableName // if field is nullable
  /// }
  /// ```
  String toConstructorDefinitions() {
    if (fields.isEmpty) {
      return '';
    }

    final buffer = StringBuffer();

    buffer.writeln('{');
    for (final field in fields) {
      buffer.write('    ');
      if (field.isNullable == false) {
        buffer.write('required ');
      }
      buffer
        ..write('this.')
        ..write(field.fieldVariableName)
        ..writeln(',');
    }
    buffer.write('  }');
    return buffer.toString();
  }
}
