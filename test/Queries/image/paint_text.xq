(:~
 : This example creates a new image using the image/basic function and paints a text to it. 
 : As it is, the example just asserts that the resulting xs:base64Binary is not empty, in a real application one could further process the image, or write it 
 : to disk using file:write-binary(a_path, $image-with-text), send it in an email etc.
 :)
import module namespace basic = 'http://www.zorba-xquery.com/modules/image/basic';                                                                                                                                                     import module namespace paint = 'http://www.zorba-xquery.com/modules/image/paint';                                                                                                                                                     
import schema namespace image = 'http://www.zorba-xquery.com/modules/image/image';

let $new-image := basic:create(xs:unsignedInt(200), xs:unsignedInt(100), "GIF")

(: write a really important message to the image :)

let $image-with-text := paint:paint($new-image, <image:text><image:origin><image:x>10</image:x><image:y>40</image:y></image:origin><image:text>Zorba really rocks!</image:text><image:font>Arial</image:font><image:font-size>12</image:font-size></image:text>)

return not(empty($image-with-text)) 
