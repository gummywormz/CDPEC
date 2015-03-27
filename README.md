# CDPEC #
Common Dynamic Parser for Ciencias Formatted Files

## Overview: ##

The Ciencias file format is a simple key-value store that has many advantages over similar formats 
and markup languages such as XML, YAML, or INI. It is designed to be easily parsed and easily stored in objects.

## Specification: ##

* Comment lines start with a # or @. Only single line comments are supported.
* Keys and values are separated by an =. It is recommended that keys be all caps. Keys are case sensitive.
* One of the main benefits to using this format is that keys can be used multiple times. In this sense it is not a true key-value store, but it offers the advantage of not having to add numbers to the end of keys and account for that in the parser.
* Each section has to have a header and a footer. The header and footer must be different. Each header / footer is enclosed in square brackets. Names of the headers are in all caps and use underscores instead of spaces. It is reccomended to use START and END as the first words in your header / footer name.
* Sections can not have subsections. This may be added in the future.
* There can be multiple sections with the same header and footer.

## Usage ##
Check out the UnitTest class as an example. Files to parse must be a single string instead of a list or file object. This is due to Haxe's getFileContent method returning a single String. 

All of the code is written in native Haxe so it is cross platform. No special flags or workarounds are needed.

## License ##

License is LGPL
