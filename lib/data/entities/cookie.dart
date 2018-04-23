
class Cookie {
  final String name;
  final String value;
  final String domain;

  Cookie({this.name, this.value, this.domain});

  factory Cookie.fromJson(Map<String, dynamic> json) {
    return new Cookie(
        name: json['name'],
        value: json['value'],
        domain: json['domain']
    );
  }
}