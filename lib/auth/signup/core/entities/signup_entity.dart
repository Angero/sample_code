class SignupEntity {
  String first;
  String last;
  String email;
  String birth;
  String post;
  String password;

  SignupEntity({
    this.first = '',
    this.last = '',
    this.email = '',
    this.birth = '',
    this.post = '',
    this.password = '',
  });

  SignupEntity copyWith({
    String first,
    String last,
    String email,
    String birth,
    String post,
    String password,
  }) {
    if ((first == null || identical(first, this.first)) &&
        (last == null || identical(last, this.last)) &&
        (email == null || identical(email, this.email)) &&
        (birth == null || identical(birth, this.birth)) &&
        (post == null || identical(post, this.post)) &&
        (password == null || identical(password, this.password))) {
      return this;
    }

    return SignupEntity(
      first: first ?? this.first,
      last: last ?? this.last,
      email: email ?? this.email,
      birth: birth ?? this.birth,
      post: post ?? this.post,
      password: password ?? this.password,
    );
  }
}
