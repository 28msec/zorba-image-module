(:~
 : This example uses the file module read an image from disk and solarizes the image, giving it a similar effect 
 : as exposing a photographic film to light during the development using the solarize function from the image/manipulation module.
 : As it is, the example just asserts that the resulting xs:base64Binary is not empty, 
 : in a real application one could further process the image, or write it 
 : to disk using file:write(a_path, $solarized-image, <method>binary</method>), send it in an email etc.
 :)
import module namespace file = 'http://expath.org/ns/file';
import module namespace manipulation = 'http://zorba.io/modules/image/manipulation';

declare variable $local:image-dir := fn:concat(file:dir-name(fn:static-base-uri()), "/images/");


let $bird as xs:base64Binary := file:read-binary(concat($local:image-dir, "/bird.jpg"))
let $solarized-image := manipulation:solarize($bird, 2)
return not(empty($solarized-image))

