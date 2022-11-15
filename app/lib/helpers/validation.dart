class Validation {
  String validatePassword(String value) {
    if (value.isEmpty) {
      return "Password harus diisi";
    }
    return null;
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return "No Anggota harus diisi";
    }
    return null;
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return 'Nama lengkap harus diisi';
    }
    return null;
  }
}
