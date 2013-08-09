(:~
 : This example uses the file module to reads 2 images from disk and lays one over the other using the overlay function from the image/manipulation module. 
 : As it is, the example just asserts that the resulting xs:base64Binary is not empty, 
 : in a real application one could further process the image, or write it 
 : to disk using file:write(a_path, $overlayed-image, <method>binary</method>), send it in an email etc.
 :)
import module namespace file = 'http://expath.org/ns/file';                                         
import module namespace manipulation = 'http://zorba.io/modules/image/manipulation';                                 
import module namespace basic = 'http://zorba.io/modules/image/basic';

declare variable $local:image-dir := fn:concat(file:dir-name(fn:static-base-uri()), "/images/");                    

let $bird as xs:base64Binary := file:read-binary(concat($local:image-dir, "/bird.jpg"))
let $bird-to-overlay as xs:base64Binary := file:read-binary(concat($local:image-dir, "/manipulation/subBird.jpg"))
let $overlayed-image := manipulation:overlay($bird, $bird-to-overlay, xs:unsignedInt(30), xs:unsignedInt(40), "OverCompositeOp")
return not(empty($overlayed-image))
