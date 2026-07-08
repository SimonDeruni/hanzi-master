var fs = require('fs');
var c = fs.readFileSync('lib/shared/widgets/info_bulb.dart', 'utf8');
var old1 = 'required this.title,\r\n    required this.message,';
var new1 = 'this.title = "",\r\n    this.message = "",';
c = c.split(old1).join(new1);
fs.writeFileSync('lib/shared/widgets/info_bulb.dart', c);
console.log('DONE');