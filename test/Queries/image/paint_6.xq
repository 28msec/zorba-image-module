(:~
 : Simple test module for the paint functions of the image library.
 : 
 : @author Daniel Thomas
 :)
import module namespace basic = 'http://zorba.io/modules/image/basic';
import module namespace file = 'http://expath.org/ns/file';
import module namespace paint = 'http://zorba.io/modules/image/paint';
import schema namespace image = 'http://zorba.io/modules/image/image';

declare namespace an = "http://www.zorba-xquery.com/annotations";

declare variable $local:image-dir := fn:concat(file:dir-name(fn:static-base-uri()), "/images/");
declare variable $local:jpg as xs:base64Binary := basic:create(xs:unsignedInt(100), xs:unsignedInt(100), image:imageFormat("JPEG"));


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
 : @return true if the man:draw-polygon function works.
 :)
declare %an:nondeterministic function local:test-draw-polygon() as xs:boolean {
    let $draw := paint:paint($local:jpg, 
    {
      "polygon" : {
        "points" : [ [ 10, 10 ], [ 40, 80 ], [ 50, 30 ] ]
      }
    })
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/polygon.jpg"))
    return basic:equals($draw, $draw-ref)
};

(:~
 : @return true if the man:draw-polygon function works.
 :)
declare %an:nondeterministic function local:test-draw-polygon-red() as xs:boolean {
    let $draw := paint:paint($local:jpg, 
    {
      "polygon" : {
        "strokeColor" : "#FF0000",
        "points" : [ [ 10, 10 ], [ 40, 80 ], [ 50, 30 ] ]
      }
    })
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/polygonRed.jpg"))
    return basic:equals($draw, $draw-ref)
};

(:~
 : @return true if the man:draw-polygon function works.
 :)
declare %an:nondeterministic function local:test-draw-polygon-red-green() as xs:boolean {
    let $draw := paint:paint($local:jpg,
    {
      "polygon" : {
        "strokeColor" : "#FF0000",
        "fillColor" : "#00FF00",
        "points" : [ [ 10, 10 ], [ 40, 80 ], [ 50, 30 ] ]
      }
    })
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/polygonRedGreen.jpg"))
    return basic:equals($draw, $draw-ref)
};

(:~
 : @return true if the man:draw-polygon function works.
 :)
declare %an:nondeterministic function local:test-draw-polygon-wide() as xs:boolean {
    let $draw := paint:paint($local:jpg, 
    {
      "polygon" : {
        "strokeWidth" : 3,
        "strokeColor" : "#FF0000",
        "fillColor" : "#00FF00",
        "points" : [ [ 10, 10 ], [ 40, 80 ], [ 50, 30 ] ]
      }
    })
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/polygonWide.jpg"))
    return basic:equals($draw, $draw-ref)
};


(:~
 : @return true if the man:draw-polygon function works.
 :)
declare %an:nondeterministic function local:test-draw-polygon-anti-aliased() as xs:boolean {
    let $draw := paint:paint($local:jpg, 
    {
      "polygon" : {
        "strokeWidth" : 3,
        "strokeColor" : "#FF0000",
        "fillColor" : "#00FF00",
        "antiAliasing" : fn:true(),
        "points" : [ [ 10, 10 ], [ 40, 80 ], [ 50, 30 ] ]
      }
    })
    let $draw-ref := file:read-binary(concat($local:image-dir, "paint/polygonAntiAliased.jpg"))
    return basic:equals($draw, $draw-ref)
};


declare %an:nondeterministic %an:sequential function local:main() as xs:string* {

  let $a := local:test-draw-polygon()
  return
    if (fn:not($a)) then
      exit returning local:error(("Drawing a polygon on an image failed."));
    else ();
  
  
  let $b := local:test-draw-polygon-red()
  return
    if (fn:not($b)) then
      exit returning local:error(("Drawing a red polygon on an image failed."));
    else ();
      
   
  let $c := local:test-draw-polygon-red-green()
  return
    if (fn:not($c)) then
      exit returning local:error(("Drawing a red polygon filled with green color on an image failed."));
    else ();
      
  
  let $d := local:test-draw-polygon-wide()
  return
    if (fn:not($d)) then
      exit returning local:error(("Drawing a polygon with wide strokes  on an image failed."));
    else ();
      
  let $e := local:test-draw-polygon-anti-aliased()
  return
    if (fn:not($e)) then
      exit returning local:error(("Drawing an anti-aliased polygon on an image failed."));
    else ();
              
      
  (: If all went well ... make sure the world knows! :)  
  "SUCCESS"
};

local:main()
