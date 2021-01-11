class TokenEntity {
  String tokenType;
  int expiresIn;
  String accessToken;
  String refreshToken;

  TokenEntity({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
  });
}