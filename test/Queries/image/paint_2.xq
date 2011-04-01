(:~
 : Simple test module for the paint functions of the image library.
 : 
 : @author Daniel Thomas
 :)
import module namespace basic = 'http://www.zorba-xquery.com/modules/image/basic';
import module namespace file = 'http://www.zorba-xquery.com/modules/file';
import module namespace paint = 'http://www.zorba-xquery.com/modules/image/paint';
import schema namespace image = 'http://www.zorba-xquery.com/modules/image/image';

declare variable $local:image-dir := fn:concat(file:dirname(fn:static-base-uri()), "/images/");


declare variable $local:gif as xs:base64Binary := basic:create(xs:unsignedInt(100), xs:unsignedInt(100), image:imageType("GIF"));


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
  Location:", file:path-to-full-path("."), "
  Cause:",
  $messages,
  "
************************************************************************
"
};


declare function local:test-draw-poly-line() as xs:boolean {
    let $draw := paint:paint($local:gif, <image:polyLine><point><x>10</x><y>10</y></point><point><x>40</x><y>80</y></point><point><x>50</x><y>30</y></point><point><x>200</x><y>200</y></point></image:polyLine>)
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/polyLine.gif"))
    return basic:equals($draw, $draw-ref)
};

declare function local:test-draw-poly-line-anti-aliased() as xs:boolean {
    
    let $draw := paint:paint($local:gif, <image:polyLine><antiAliasing>true</antiAliasing><point><x>10</x><y>10</y></point><point><x>40</x><y>80</y></point><point><x>50</x><y>30</y></point></image:polyLine>)
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/polyLineAntiAliased.gif"))
    return basic:equals($draw,  $draw-ref)
};


(:~
 : @return true if the man:draw-poly-line function works.
 :)
declare function local:test-draw-poly-line-red() as xs:boolean {
    let $draw := paint:paint($local:gif, <image:polyLine><strokeColor>#FF0000</strokeColor><antiAliasing>true</antiAliasing><point><x>10</x><y>10</y></point><point><x>40</x><y>80</y></point><point><x>50</x><y>30</y></point></image:polyLine>)
    
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/polyLineRed.gif"))
    return basic:equals($draw, $draw-ref)
};

(:~
 : @return true if the man:draw-poly-line function works.
 :)
declare function local:test-draw-poly-line-wide() as xs:boolean {
     let $draw := paint:paint($local:gif, <image:polyLine><strokeWidth>5</strokeWidth><antiAliasing>true</antiAliasing><point><x>10</x><y>10</y></point><point><x>40</x><y>80</y></point><point><x>50</x><y>30</y></point></image:polyLine>)
    
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/polyLineWide.gif"))
    return basic:equals($draw, $draw-ref)
};



declare sequential function local:main() as xs:string* {


  let $a := local:test-draw-poly-line()
  return
    if (fn:not($a)) then
      exit returning local:error(("Drawing a poly-line on an image failed."))
    else ();

  let $b := local:test-draw-poly-line-anti-aliased()
  return
    if (fn:not($b)) then
      exit returning local:error(("Drawing a anti-aliased poly-line on an image failed."))
    else ();

  let $c := local:test-draw-poly-line-red()
  return
    if (fn:not($c)) then
      exit returning local:error(("Drawing a red poly-line on an image failed."))
    else ();

  let $d := local:test-draw-poly-line-wide()
  return
    if (fn:not($d)) then
      exit returning local:error(("Drawing wide poly-line on an image failed."))
    else ();

  (: If all went well ... make sure the world knows! :)
  "SUCCESS";




};

local:main();


