(:~
 : Simple test module for the paint functions of the image library.
 : 
 : @author Daniel Thomas
 :)
import module namespace basic = 'http://www.zorba-xquery.com/modules/image/basic';
import module namespace file = 'http://expath.org/ns/file';
import module namespace paint = 'http://www.zorba-xquery.com/modules/image/paint';
import schema namespace image = 'http://www.zorba-xquery.com/modules/image/image';

declare namespace an = "http://zorba.io/annotations";

declare variable $local:image-dir := fn:concat(file:dir-name(fn:static-base-uri()), "/images/");


declare variable $local:gif as xs:base64Binary := basic:create(xs:unsignedInt(100), xs:unsignedInt(100), image:imageFormat("GIF"));


(:~
 : Outputs a nice error message to the screen ...
 :
 : @param $messsage is the message to be displayed
 : @return The passed message but really very, very nicely formatted.
 :)
declare function local:error($messages as xs:string*) as xs:string* {
  "
************************************************************************
ERROR:
  Location:", file:path-to-native("."), "
  Cause:",
  $messages,
  "
************************************************************************
"
};


(:~
 : @return true if the man:draw-rectangle function works.
 :)
declare %an:nondeterministic function local:test-draw-rectangle() as xs:boolean {
    let $draw := paint:paint($local:gif, <image:rectangle><image:upperLeft><image:x>20</image:x><image:y>20</image:y></image:upperLeft><image:lowerRight><image:x>50</image:x><image:y>50</image:y></image:lowerRight></image:rectangle>)
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/rectangle.gif"))
    return basic:equals($draw, $draw-ref)
};

(:~
 : @return true if the man:draw-rectangle function works.
 :)
declare %an:nondeterministic function local:test-draw-rectangle-green() as xs:boolean {
    let $draw := paint:paint($local:gif, <image:rectangle><image:strokeColor>#00AF00</image:strokeColor><image:upperLeft><image:x>20</image:x><image:y>20</image:y></image:upperLeft><image:lowerRight><image:x>50</image:x><image:y>50</image:y></image:lowerRight></image:rectangle>)
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/rectangleGreen.gif"))
    return basic:equals($draw, $draw-ref)
};


(:~
 : @return true if the man:draw-rectangle function works.
 :)
declare %an:nondeterministic function local:test-draw-rectangle-green-red() as xs:boolean {
    let $draw := paint:paint($local:gif, <image:rectangle><image:strokeColor>#00AF00</image:strokeColor><image:fillColor>#A10000</image:fillColor><image:upperLeft><image:x>20</image:x><image:y>20</image:y></image:upperLeft><image:lowerRight><image:x>50</image:x><image:y>50</image:y></image:lowerRight></image:rectangle>)
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/rectangleGreenRed.gif"))
    return basic:equals($draw, $draw-ref)
};


(:~
 : @return true if the man:draw-rectangle function works.
 :)
declare %an:nondeterministic function local:test-draw-rectangle-anti-aliased() as xs:boolean {
    let $draw := paint:paint($local:gif, <image:rectangle><image:strokeWidth>5</image:strokeWidth><image:strokeColor>#00AF00</image:strokeColor><image:fillColor>#A10000</image:fillColor><image:antiAliasing>true</image:antiAliasing><image:upperLeft><image:x>20</image:x><image:y>20</image:y></image:upperLeft><image:lowerRight><image:x>50</image:x><image:y>50</image:y></image:lowerRight></image:rectangle>)
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/rectangleAntiAliased.gif"))
    return basic:equals($draw, $draw-ref)
};

(:~
 : @return true if the man:draw-rounded-rectangle function works.
 :)
declare %an:nondeterministic function local:test-draw-rounded-rectangle() as xs:boolean {
    let $draw := paint:paint($local:gif, <image:roundedRectangle><image:upperLeft><image:x>20</image:x><image:y>20</image:y></image:upperLeft><image:lowerRight><image:x>50</image:x><image:y>50</image:y></image:lowerRight><image:cornerWidth>10</image:cornerWidth><image:cornerHeight>10</image:cornerHeight></image:roundedRectangle>)
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/rectangleRounded.gif"))
    return basic:equals($draw, $draw-ref)
};

(:~
 : @return true if the man:draw-rounded-rectangle function works.
 :)
declare %an:nondeterministic function local:test-draw-rounded-rectangle-blue() as xs:boolean {
    let $draw := paint:paint($local:gif, <image:roundedRectangle><image:strokeColor>#0000FF</image:strokeColor><image:upperLeft><image:x>20</image:x><image:y>20</image:y></image:upperLeft><image:lowerRight><image:x>50</image:x><image:y>50</image:y></image:lowerRight><image:cornerWidth>10</image:cornerWidth><image:cornerHeight>10</image:cornerHeight></image:roundedRectangle>)
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/rectangleRoundedBlue.gif"))
    return basic:equals($draw, $draw-ref)
};


(:~
 : @return true if the man:draw-rounded-rectangle function works.
 :)
declare %an:nondeterministic function local:test-draw-rounded-rectangle-blue-green() as xs:boolean {
    let $draw := paint:paint($local:gif, <image:roundedRectangle><image:strokeColor>#0000FF</image:strokeColor><image:fillColor>#00FF00</image:fillColor><image:upperLeft><image:x>20</image:x><image:y>20</image:y></image:upperLeft><image:lowerRight><image:x>50</image:x><image:y>50</image:y></image:lowerRight><image:cornerWidth>10</image:cornerWidth><image:cornerHeight>10</image:cornerHeight></image:roundedRectangle>)
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/rectangleRoundedBlueGreen.gif"))
    return basic:equals($draw, $draw-ref)
};


(:~
 : @return true if the man:draw-rounded-rectangle function works.
 :)
declare %an:nondeterministic function local:test-draw-rounded-rectangle-anti-aliased() as xs:boolean {
    let $draw := paint:paint($local:gif, <image:roundedRectangle><image:strokeColor>#0000FF</image:strokeColor><image:fillColor>#00FF00</image:fillColor><image:antiAliasing>true</image:antiAliasing><image:upperLeft><image:x>20</image:x><image:y>20</image:y></image:upperLeft><image:lowerRight><image:x>50</image:x><image:y>50</image:y></image:lowerRight><image:cornerWidth>10</image:cornerWidth><image:cornerHeight>10</image:cornerHeight></image:roundedRectangle>)
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/rectangleRoundedAntiAliased.gif"))
    return basic:equals($draw, $draw-ref)
};


declare %an:nondeterministic %an:sequential function local:main() as xs:string* {

  let $a := local:test-draw-rectangle()
  return
    if (fn:not($a)) then
      exit returning local:error(("Drawing a rectangle on an image failed."));
    else ();
    
  let $c := local:test-draw-rectangle-green()
  return
    if (fn:not($c)) then
      exit returning local:error(("Drawing a green rectangle on an image failed."));
    else ();    
  
   
  let $e := local:test-draw-rectangle-anti-aliased()
  return
    if (fn:not($e)) then
      exit returning local:error(("Drawing a anti-aliased wide green rectangle filled with red on an image failed."));
    else ();    
   
    
  let $f := local:test-draw-rounded-rectangle()
  return
    if (fn:not($f)) then
      exit returning local:error(("Drawing a rounded rectangle on an image failed."));
    else ();    
  
      
  let $g := local:test-draw-rounded-rectangle-blue()
  return
    if (fn:not($g)) then
      exit returning local:error(("Drawing a blue rounded rectangle on an image failed."));
    else ();          
    
  let $h := local:test-draw-rounded-rectangle-blue-green()
  return
    if (fn:not($h)) then
      exit returning local:error(("Drawing a blue rounded rectangle filled with green on an image failed."));
    else ();               
           
             
  let $j := local:test-draw-rounded-rectangle-anti-aliased()
  return
    if (fn:not($j)) then
      exit returning local:error(("Drawing a blue rounded rectangle anti-aliased filled with green on an image failed."));
    else ();               
    
  (: If all went well ... make sure the world knows! :)  
  "SUCCESS"
};

local:main()

