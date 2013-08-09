(:~
 : This example uses the file module to read an image from disk and zooms the image by its width using the zoom-by-width function from the image/manipulation module. 
 : As it is, the example just asserts that the resulting xs:base64Binary is not empty, 
 : in a real application one could further process the image, or write it 
 : to disk using file:write(a_path, $zoomed-image, <method>binary</method>), send it in an email etc.
 :)
import module namespace file = 'http://expath.org/ns/file';                                         
import module namespace manipulation = 'http://zorba.io/modules/image/manipulation';                                 
import module namespace basic = 'http://zorba.io/modules/image/basic';

declare variable $local:image-dir := fn:concat(file:dir-name(fn:static-base-uri()), "/images/");                    

                                                                                                                   
let $bird as xs:base64Binary := file:read-binary(concat($local:image-dir, "/bird.jpg"))
let $zoomed-image := manipulation:zoom-by-width($bird, xs:unsignedInt(580))
return not(empty($zoomed-image))
