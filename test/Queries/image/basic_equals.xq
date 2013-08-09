(:~
 : This exaple uses the file module to read two different images from disk and uses the equals function from the image/basic module to assert that they
 : are not equal. 
 :)
import module namespace file = 'http://expath.org/ns/file';
import module namespace basic = 'http://zorba.io/modules/image/basic';

declare variable $local:image-dir := fn:concat(file:dir-name(fn:static-base-uri()), "/images/");

let $image as xs:base64Binary := file:read-binary(concat($local:image-dir, "/bird.jpg"))
let $different-image as xs:base64Binary := file:read-binary(concat($local:image-dir, "manipulation/gamma1Bird.gif")) 
return basic:equals($image, $different-image)

