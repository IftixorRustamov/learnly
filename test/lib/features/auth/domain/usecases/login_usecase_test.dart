// import 'package:flutter_test/flutter_test.dart';
// import 'package:kursol/features/auth/domain/entities/api_response_entity.dart';
// import 'package:kursol/features/auth/domain/entities/token_entity.dart';
// import 'package:kursol/features/auth/domain/repositories/auth_repository.dart';
// import 'package:kursol/features/auth/domain/usecases/login_usecase.dart';
// import 'package:mocktail/mocktail.dart';
//
// class MockAuthRepo extends Mock implements AuthRepository {}
//
// void main() {
//   late LoginUsecase usecase;
//   late AuthRepository repository;
//
//   setUp(() {
//     repository = MockAuthRepo();
//     usecase = LoginUsecase(repository);
//   });
//
//   test("should call the [AuthRepo.login]", () async {
//     final token = TokenEntity(
//       accessToken: 'access123',
//       refreshToken: 'refresh123',
//     );
//     final apiResponse = ApiResponseEntity(success: true, data: token);
//
//     when(() => repository.login(any(), any()))
//         .thenAnswer((_) async => apiResponse);
//
//     final result = await usecase("test_user", "password123");
//
//     expect(result.success, true);
//     expect(result.data?.accessToken, 'access123');
//     expect(result.data?.refreshToken, 'refresh123');
//   });
// }
