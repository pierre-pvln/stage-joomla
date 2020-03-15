--- 
# Generic Staging Process Scripts
--- 		
Generic deployment scripts for Joomla! website extensions.<br/>
<br/>
* Documentation and download extension: http://www.pvln.nl/stage-joomla-extensions<br/>
<br/>
Below folder structure should be present on the workstation on which development is done:

``` 
ipheiongraphs\code           folder with all code related items __git managed__
ipheiongraphs\code\src       folder with the code for the Joomla! extension, which gets installed on the Joomla! website
ipheiongraphs\code\doc       documentation related to the source code
ipheiongraphs\code\set       specific settings for the extension
ipheiongraphs\code\tst       tests for the source code
			 
ipheiongraphs\bld            folder with scripts to build the extension zipfile __git managed__
		 
ipheiongraphs\stg            folder with scripts to stage it to the update and download webserver <- THIS CODE __git managed__

ipheiongraphs\dpl            folder with generic deploy scripts for Joomla! website extensions __git managed__
 
ipheiongraphs\struc          scripts to create the Joomla! deployment skeleton __git managed__

ipheiongraphs\misc           folder with relevant information links and inspiration, but not relevant for code
ipheiongraphs\misc\original  if relevant the original code which is changed in \code\src

ipheiongraphs\_set           folder with settings used by various scripts. Files in this folder are shared between different scripts.

ipheiongraphs\_bin           folder with the output files from scripts. Files in this folder are shared between different scripts.

ipheiongraphs\_tmp           Folder used to place temporary output files from scripts. Files in this folder are shared between different scripts.
``` 
<br/>
The downloadable extension .zip file is available at:
```
```
<br/>
The downloadable extension update .xml file is available at:
```
```
