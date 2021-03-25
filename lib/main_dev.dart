import 'package:flutter/material.dart';
import 'package:flutter_architecture_demo/request/api/api_demo_dao2.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'event_bus/event_bus_init.dart';
import 'my_app.dart';
import 'request/dio_init.dart';
import 'utils/alice_init.dart';
import 'utils/application.dart';
import 'utils/run_platform.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //FIXME： 如果main函数 是 async  就必须调用这个
  BASE_URL = 'http://www.baidu.com';
  PEM = '''
-----BEGIN CERTIFICATE-----
MIIGRDCCBSygAwIBAgIMSn61QLc4mJsDtbx/MA0GCSqGSIb3DQEBCwUAMEwxCzAJ
BgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSIwIAYDVQQDExlB
bHBoYVNTTCBDQSAtIFNIQTI1NiAtIEcyMB4XDTIxMDMwMzA2MzY0MloXDTIyMDQw
NDA2MzY0MlowHDEaMBgGA1UEAwwRKi5jb2NrZmlnaHRiZXQuY2MwggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDPzUSc4TfQWOY0MIbestDpd0ScOoLTQJMP
sIcYuyZlondQyQF6iljOgj+hneDrw/MkbAkfVRixye4XqWpp046v8jLruuqP5abG
V7mLRte/lk+yJ4tPBXL/33hA3TTloR7ECDjCIpqP22BnZGHeuZNAGs1nOqMJZnyJ
TZUu7rJXiu5Pt223h7Wn8p6bWJo+ojfwP/ziq6tbKPB6EgEAmzveRja6+KvvYDip
rUFxLfdfJEdEPR/taEf2JDAj0s0huHHxifOewqP1cO7hWrCJIOTotplgupacrJl0
KBqv2aJe3+t3SPqqTojHBK3mughMcZyLAjstVcsD1Sf7Gv/JqW5NAgMBAAGjggNU
MIIDUDAOBgNVHQ8BAf8EBAMCBaAwgYkGCCsGAQUFBwEBBH0wezBCBggrBgEFBQcw
AoY2aHR0cDovL3NlY3VyZTIuYWxwaGFzc2wuY29tL2NhY2VydC9nc2FscGhhc2hh
MmcycjEuY3J0MDUGCCsGAQUFBzABhilodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NhbHBoYXNoYTJnMjBXBgNVHSAEUDBOMEIGCisGAQQBoDIBCgowNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8w
CAYGZ4EMAQIBMAkGA1UdEwQCMAAwPgYDVR0fBDcwNTAzoDGgL4YtaHR0cDovL2Ny
bDIuYWxwaGFzc2wuY29tL2dzL2dzYWxwaGFzaGEyZzIuY3JsMC0GA1UdEQQmMCSC
ESouY29ja2ZpZ2h0YmV0LmNjgg9jb2NrZmlnaHRiZXQuY2MwHQYDVR0lBBYwFAYI
KwYBBQUHAwEGCCsGAQUFBwMCMB8GA1UdIwQYMBaAFPXN1TwIUPlqTzq3l9pWg+Zp
0mj3MB0GA1UdDgQWBBTwKBzT8RX1wPStkHSHYvDzxwD7vDCCAX4GCisGAQQB1nkC
BAIEggFuBIIBagFoAHcAb1N2rDHwMRnYmQCkURX/dxUcEdkCwQApBo2yCJo32RMA
AAF39s2QJgAABAMASDBGAiEArpKraL+POI0u9kuJ7vtI2QNLI3mnE8wmN17PfhAG
EnUCIQCaa0nkgfYYQgas3Dg1tesfNSNREKdWoCFyl43F67jZSgB1ACl5vvCeOTkh
8FZzn2Old+W+V32cYAr4+U1dJlwlXceEAAABd/bNkCwAAAQDAEYwRAIgC6OWAbzv
obwcnRtnDrMQUWkSEbTdLvEhbwJlinyBuf0CIAImVPXpJgWDEfOh4HGqqBmLCuZo
7G6MUdfWrRxfxxRAAHYAVYHUwhaQNgFK6gubVzxT8MDkOHhwJQgXL6OqHQcT0wwA
AAF39s2QTQAABAMARzBFAiB9j0FjXFucorv5pS+SFFXUEpzA1zqJ/MG0k41tuNrT
OQIhAMMsthiL/dTIu+pmg7NsNliQ6wP9hxxhKVfqn5ktjy6wMA0GCSqGSIb3DQEB
CwUAA4IBAQCUvnU5AoNbmJD3D0v5gk8lwi6kugFzxh16S6Et0Vwb+NwDEw9H9Uob
AReMyf3k8usriwU1GQgA2AdDGI6j5zsJM3KdR0tqonZ1RS9zEUxLFAEiFQG8/9Er
hhJNcdJHW9tsvXedC4as5a3/3TtdnxpNPOBlNjTLI/ni8y0rzn4ClGavBy7oYlDi
Bv8GwnaGBTxrxx86Ajd3e4t6rE5aUWCjBUT3QU34BHULLrA2NglEbgaz7vgXPU/f
10YvkdKTupst8BRGzUOqPM/ssqM0KzlasxyGWKnVYwxhzmXUrrCODI3mnMp6PHiK
NT4+PdaG/AvuKkj0+xdfge368909522da
-----END CERTIFICATE-----
''';

  Application.sp = await SharedPreferences.getInstance();
  EventBusInit.logInit();
  // 只支持部分平台
  if(RunPlatform.isAndroid || RunPlatform.isIOS || RunPlatform.isMacOS){
    Application.packageInfo = await PackageInfo.fromPlatform();
  }
  // 只支持部分平台
  if(RunPlatform.isAndroid || RunPlatform.isIOS || RunPlatform.isMacOS || RunPlatform.isWindows || RunPlatform.isLinux){
    Application.tempDir = await getTemporaryDirectory();
  }
  AliceInit();
  DioInit();
  Application.client = RestClient(Application.dio);


  runApp(MyApp());
}
