(:~
 : Simple test module for the paint functions of the image library.
 : 
 : @author Daniel Thomas
 :)
import module namespace basic = 'http://www.zorba-xquery.com/modules/image/basic';
import module namespace file = 'http://expath.org/ns/file';
import module namespace paint = 'http://www.zorba-xquery.com/modules/image/paint';
import schema namespace img = 'http://www.zorba-xquery.com/modules/image/image';

declare namespace an = "http://zorba.io/annotations";

declare variable $local:image-dir := fn:concat(file:dir-name(fn:static-base-uri()), "/images/");


declare variable $local:gif as xs:base64Binary := basic:create(xs:unsignedInt(100), xs:unsignedInt(100), img:imageFormat("GIF"));


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


declare %an:nondeterministic function local:test-draw-poly-line() as xs:boolean 
{
  let $draw := paint:paint($local:gif, <img:polyLine><img:point><img:x>10</img:x><img:y>10</img:y></img:point><img:point><img:x>40</img:x><img:y>80</img:y></img:point><img:point><img:x>50</img:x><img:y>30</img:y></img:point><img:point><img:x>200</img:x><img:y>200</img:y></img:point></img:polyLine>)
  let $draw-ref := file:read-binary(concat($local:image-dir, "paint/polyLine.gif"))
  return basic:equals($draw, $draw-ref)
};

declare %an:nondeterministic function local:test-draw-poly-line-anti-aliased() as xs:boolean
{
  let $draw := paint:paint($local:gif, <img:polyLine><img:antiAliasing>true</img:antiAliasing><img:point><img:x>10</img:x><img:y>10</img:y></img:point><img:point><img:x>40</img:x><img:y>80</img:y></img:point><img:point><img:x>50</img:x><img:y>30</img:y></img:point></img:polyLine>)
  let $draw-ref := file:read-binary(concat($local:image-dir, "paint/polyLineAntiAliased.gif"))
  return basic:equals($draw,  $draw-ref)
};


(:~
 : @return true if the man:draw-poly-line function works.
 :)
declare %an:nondeterministic function local:test-draw-poly-line-red() as xs:boolean 
{
    let $draw := paint:paint($local:gif, <img:polyLine><img:strokeColor>#FF0000</img:strokeColor><img:antiAliasing>true</img:antiAliasing><img:point><img:x>10</img:x><img:y>10</img:y></img:point><img:point><img:x>40</img:x><img:y>80</img:y></img:point><img:point><img:x>50</img:x><img:y>30</img:y></img:point></img:polyLine>)
    
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/polyLineRed.gif"))
    return basic:equals($draw, $draw-ref)
};


(:~
 : @return true if the man:draw-poly-line function works.
 :)
declare %an:nondeterministic function local:test-draw-poly-line-wide() as xs:boolean {
     let $draw := paint:paint($local:gif, <img:polyLine><img:strokeWidth>5</img:strokeWidth><img:antiAliasing>true</img:antiAliasing><img:point><img:x>10</img:x><img:y>10</img:y></img:point><img:point><img:x>40</img:x><img:y>80</img:y></img:point><img:point><img:x>50</img:x><img:y>30</img:y></img:point></img:polyLine>)
    
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/polyLineWide.gif"))
    return basic:equals($draw, $draw-ref)
};



declare %an:nondeterministic %an:sequential function local:main() as xs:string* {


  let $a := local:test-draw-poly-line()
  return
    if (fn:not($a)) then
      exit returning local:error(("Drawing a poly-line on an image failed."));
    else ();

  let $b := local:test-draw-poly-line-anti-aliased()
  return
    if (fn:not($b)) then
      exit returning local:error(("Drawing a anti-aliased poly-line on an image failed."));
    else ();

  let $c := local:test-draw-poly-line-red()
  return
    if (fn:not($c)) then
      exit returning local:error(("Drawing a red poly-line on an image failed."));
    else ();

  let $d := local:test-draw-poly-line-wide()
  return
    if (fn:not($d)) then
      exit returning local:error(("Drawing wide poly-line on an image failed."));
    else ();

  (: If all went well ... make sure the world knows! :)
  "SUCCESS"

};

local:main()

