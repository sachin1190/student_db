class Student {
  String id;
  String name;
  String fathersName;
  String dob;
  String phone;
  String address;
  String city;
  String zip;

  Student(
      {this.id,
      this.name,
      this.fathersName,
      this.city,
      this.phone,
      this.address,
      this.zip,
      this.dob});

  factory Student.fromMap(Map<String, dynamic> json) => new Student(
      id: json['id'],
      name: json['name'],
      fathersName: json['fathersName'],
      city: json['city'],
      phone: json['phone'],
      address: json['address'],
      zip: json['zip'],
      dob: json['dob']);

  Map getUpdateDoc(Student student) {
    return {
      'id': student.id,
      'name': student.name,
      'fathersName': student.name
    };
  }
}
