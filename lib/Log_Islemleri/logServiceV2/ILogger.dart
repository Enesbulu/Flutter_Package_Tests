import 'dart:io';

abstract class ILogger {
  void log(String message);
}

class ConsoleLogger implements ILogger {
  @override
  void log(String message) {
    print('Console log : $message');
  }
}

class JsonLogger implements ILogger {
  @override
  void log(String message) {
    log('JSON Log: {{ "log": "${message}" }}');
  }
}

class XmlLogger implements ILogger {
  @override
  void log(String message) {
    print('\x1B[32mXML Log: <log>${message}</log>\x1B[0m');
  }
}

// ILogger sınıfını uygula
class FileLogger implements ILogger {
  // Bir dosya nesnesi oluştur
  final File file;

  // Sınıfın kurucu metodunu tanımla
  FileLogger(this.file);

  @override
  void log(String message) {
    // Dosyayı aç
    var sink = file.openWrite(mode: FileMode.append);
    // Log mesajını dosyaya yaz
    sink.writeln('File log : $message');
    // Dosyayı kapat
    sink.close();
  }
  /*
  // Bir File nesnesi oluştur
var file = File('log.txt');

// FileLogger sınıfının bir örneğini al
var fileLogger = FileLogger(file);

// Log seviyesini debug olarak ayarla
fileLogger.log('Log seviyesi debug');

// Log seviyesini info olarak ayarla
fileLogger.log('Log seviyesi info');

// Log seviyesini warning olarak ayarla
fileLogger.log('Log seviyesi warning');

// Log seviyesini error olarak ayarla
fileLogger.log('Log seviyesi error');

// Log seviyesini fatal olarak ayarla
fileLogger.log('Log seviyesi fatal');

   */
}
