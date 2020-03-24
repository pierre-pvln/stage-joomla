--- 
# Generic Staging Process Scripts
--- 		
Generic deployment scripts for Joomla! website extensions.<br/>
<br/>
* Documentation and download extension: http://www.pvln.nl/stage-joomla-extensions<br/>
<br/>
Below folder structure should be present on the workstation on which development is done:

``` 
ipheionmaps\code           folder with all code related items __git managed__
ipheionmaps\code\src       folder with the code for the Joomla! extension, which gets installed on the Joomla! website
ipheionmaps\code\doc       documentation related to the source code
ipheionmaps\code\set       specific settings for the extension
ipheionmaps\code\tst       tests for the source code
			 
ipheionmaps\bld            folder with scripts to build the extension zipfile __git managed__
		 
ipheionmaps\stg            folder with scripts to stage it to the update and download webserver <- THIS CODE __git managed__

ipheionmaps\dpl            folder with generic deploy scripts for Joomla! website extensions __git managed__
 
ipheionmaps\struc          scripts to create the Joomla! deployment skeleton __git managed__

ipheionmaps\misc           folder with relevant information links and inspiration, but not relevant for code
ipheionmaps\misc\original  if relevant the original code which is changed in \code\src

ipheionmaps\_set           folder with settings used by various scripts. Files in this folder are shared between different scripts.

ipheionmaps\_bin           folder with the output files from scripts. Files in this folder are shared between different scripts.

ipheionmaps\_tmp           Folder used to place temporary output files from scripts. Files in this folder are shared between different scripts.
``` 
<br/>
The downloadable extension .zip file is available at:
```
```
<br/>
The downloadable extension update .xml file is available at:
```
```
