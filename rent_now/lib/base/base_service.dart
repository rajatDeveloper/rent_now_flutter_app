import 'dart:developer';

class BaseService {
  Map<String, String> getHeaders() {
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
  }

  // Map<String, String> getAuthorizationHeaders() {
  //   log("Token of user ${StaticConstData.user!.token}");
  //   return {
  //     "Accept": "application/json",
  //     "Content-Type": "application/json",
  //     "Authorization": "Token ${StaticConstData.user!.token}"
  //   };
  // }

  // Map<String, String> getAuthorizationHeadersWithMultiMediaType() {
  //   log("Token of user ${StaticConstData.user!.token}");
  //   return {
  //     "Content-Type": "multipart/form-data",
  //     "Authorization": "Token ${StaticConstData.user!.token}"
  //   };
  // }
}
