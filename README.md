ActionScript 3 code libraries
=============================

*Igazine's Code*

###Package **org.igazine.security**

Description: I've been experimenting with technologies for strengthening security for online commercial services and websites

**FSecurity class**
* **static function fingerPrint():String** - Uniquely indentifies a user according to system parameters. Returns an MD5 hashed string of the actual user's Flash fingerprint
* **static function getUniqueId(soName:String = "/org/igazine/security/FSecurity", propertyName:String = "uniqueId", secure:Boolean = false):Number** - Generates a unique by using the current time and a random number. This id is stored in a local SharedObject (named *soName*) in a property called *propertyName*.

###Package **org.igazine.filters**

Description: Non-3D-accelerated Flash filters

**SharpenFilter class**
* Creates a *sharpen* filter
