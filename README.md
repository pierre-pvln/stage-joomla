--- 
# Generic Staging Process Scripts
--- 		
Generic staging scripts for Joomla! website extensions.<br/>
<br/>
Documentation and download extension: http://www.pvln.nl/stage-joomla-extensions<br/>
<br/>
Below folder structure should be present on the workstation on which development is done:<br/>
<br/>
__Managed using git__
``` 
<extensionname>\code           folder with all code related items
<extensionname>\code\src       folder with the code for the Joomla! extension, which gets installed on the Joomla! website
<extensionname>\code\doc       documentation related to the source code
<extensionname>\code\set       specific settings for the extension
<extensionname>\code\tst       tests for the source code
			 
<extensionname>\bld            folder with scripts to build the extension zipfile
		 
<extensionname>\stg            folder with scripts to stage it to the update and download webserver <- THIS CODE

<extensionname>\dpl            folder with generic deploy scripts for Joomla! website extensions
 
<extensionname>\struc          scripts to create the Joomla! deployment skeleton
```
<br>

__Not managed, only present at development workstation__
```
<extensionname>\misc           folder with relevant information links and inspiration, but not relevant for code
<extensionname>\misc\original  if relevant the original code which is changed in \code\src

<extensionname>\_set           folder with settings used by various scripts. Files in this folder are shared between different scripts.

<extensionname>\_bin           folder with the output files from scripts. Files in this folder are shared between different scripts.

<extensionname>\_tmp           Folder used to place temporary output files from scripts. Files in this folder are shared between different scripts.
``` 
<br/>
