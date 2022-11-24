
Language: [English](README.md)

# Metal
[![Pub](https://img.shields.io/pub/v/metal.svg?style=flat-square)](https://pub.dartlang.org/packages/metal)  
[![support](https://img.shields.io/badge/platform-flutter%7Cflutter%20web%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://github.com/codeBlock/metal)

A powerful Http client for Dart, which supports Request Data Types, Interceptors, Global configuration, FormData, Request Cancellation, File downloading, Timeout etc.

## Get started

### Add dependency

```yaml  
dependencies:  
  metal: ^0.0.1
```  

### Super simple to use

```dart  
import 'package:metal/metal.dart';
  
  final Dio uri = Dio(  
    BaseOptions(  
      baseUrl: 'https://jsonplaceholder.typicode.com/posts/1',  
    ),  
  );  
  final postMetal = Metal.explore(uri: uri, ore: PostOre());  
  await postMetal.mine.get()
	  .then((value) {
	  })
	  .catchError((err) {  
    err as MetalError;  
    return;
});
```  


## Table of contents

- [Examples](#examples)

- [Dio APIs](#metal-apis)

- [Request Options](#request-options)

- [Response Schema](#response-schema)

- [Interceptors](#interceptors)

- [Cookie Manager](#cookie-manager)

- [Handling Errors](#handling-errors)

- [Using application/x-www-form-urlencoded format](#using-applicationx-www-form-urlencoded-format)

- [Sending FormData](#sending-formdata)

- [Transformer](#transformer)

- [Using proxy](#using-proxy)

- [Https certificate verification](#https-certificate-verification)

- [HttpClientAdapter](#httpclientadapter )

- [Cancellation](#cancellation)

- [Extends Dio class](#extends-dio-class)

- [Http2 support](#http2-support )

- [Features and bugs](#features-and-bugs)



## Copyright & License

This open source project authorized by https://wavercode.com, and the license is MIT.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/codeBlock25/metal/issues 
  