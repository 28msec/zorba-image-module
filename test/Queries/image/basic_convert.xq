(:~
 : This example uses the file module to read a JPG image from disk and converts it to a GIF image. 
 : As it is, the example just asserts that the resulting xs:base64Binary is not empty, in a real application one could further process the image, or write it 
 : to disk using file:write-binary(a_path, basic:compress($gif-bird, xs:unsignedInt(2))), send it in an email etc.
 :)
import module namespace file = 'http://expath.org/ns/file';                                         
import module namespace basic = 'http://zorba.io/modules/image/basic';                                 

declare variable $local:image-dir := fn:concat(file:dir-name(fn:static-base-uri()), "/images/");                    

                                                                                                                   
let $jpg-bird as xs:base64Binary := file:read-binary(concat($local:image-dir, "/bird.jpg")) 
let $gif-bird := basic:convert($jpg-bird, "GIF")
return not(empty($gif-bird))

