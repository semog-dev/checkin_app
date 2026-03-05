import 'package:core/src/extensions/string_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringExtensions.capitalized', () {
    test('coloca a primeira letra em maiúscula', () {
      expect('hello'.capitalized, 'Hello');
    });

    test('mantém já maiúscula sem alterar o resto', () {
      expect('Hello'.capitalized, 'Hello');
    });

    test('string vazia retorna string vazia', () {
      expect(''.capitalized, '');
    });

    test('string com uma letra minúscula', () {
      expect('a'.capitalized, 'A');
    });

    test('string com uma letra maiúscula', () {
      expect('A'.capitalized, 'A');
    });

    test('não altera o restante da string', () {
      expect('hello world'.capitalized, 'Hello world');
    });

    test('palavra toda em maiúscula não é alterada', () {
      expect('HELLO'.capitalized, 'HELLO');
    });

    test('palavra toda em minúscula capitaliza apenas o primeiro char', () {
      expect('flutter'.capitalized, 'Flutter');
    });

    test('string que começa com número não altera', () {
      expect('1hello'.capitalized, '1hello');
    });

    test('string com espaço inicial não capitaliza letra', () {
      expect(' hello'.capitalized, ' hello');
    });

    test('string de uma palavra com acento', () {
      expect('álgebra'.capitalized, 'Álgebra');
    });
  });
}
