(:~
 : This example uses the file module to read two GIF images from disk and combines the to a simple animation.
 : The delay is set to 1/10th of a second and by setting the iterations to zero, we get an animated gif that goes on with the animation infinitely. 
 : As it is, the example just asserts that the resulting xs:base64Binary is not empty, in a real application one could further process the image, or write it 
 : to disk using file:write-binary(a_path, $animatedGif), send it in an email etc.
 :)
import module namespace file = 'http://expath.org/ns/file';
import module namespace animation = 'http://zorba.io/modules/image/animation';

declare variable $local:image-dir := fn:concat(file:dir-name(fn:static-base-uri()), "/images/");

let $gif1 := file:read-binary(concat($local:image-dir, "bird.gif"))
let $gif2 := file:read-binary(concat($local:image-dir, "bird2.gif"))
let $animatedGif := animation:create-animated-gif(($gif1, $gif2), xs:unsignedInt(10), xs:unsignedInt(0))
return not(empty($animatedGif))
