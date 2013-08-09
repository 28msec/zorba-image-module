/*
 * Copyright 2006-2008 The FLWOR Foundation.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <sstream>
#include <Magick++.h>

#include <zorba/zorba.h>
#include <zorba/diagnostic_list.h>
#include <zorba/empty_sequence.h>
#include <zorba/singleton_item_sequence.h>
#include <zorba/user_exception.h>
#include <zorba/util/base64_util.h>

#include "image_function.h"
#include "image_module.h"

namespace zorba {  namespace imagemodule {

ImageFunction::ImageFunction(const ImageModule* aModule)
        : theModule(aModule)
{
}

ImageFunction::~ImageFunction()
{
}

String
ImageFunction::getURI() const
{
        return theModule->getURI();
}
void
ImageFunction::throwError(
        const std::string aErrorMessage,
        const Error& aErrorType)
{
  throw USER_EXCEPTION(aErrorType, aErrorMessage.c_str() );
}

void
ImageFunction::throwImageError(const DynamicContext* aDynamicContext, const char *aMessage) {
  std::stringstream lErrorMessage;
  // constuct error QName
  String lNamespace = "http://zorba.io/modules/image/error";
  String lLocalname = "INVALID_IMAGE";
  Item lQName = ImageModule::getItemFactory()->createQName(lNamespace, "image", lLocalname);
  // if we have zero length image, then tell the user so
  if (std::string(aMessage).find("zero-length") != std::string::npos) {
    lErrorMessage << "The passed xs:base64Binary seems to be empty.";
    USER_EXCEPTION(lQName, lErrorMessage.str());
  } else {
    lErrorMessage << "Error while processing xs:base64Binary. Possibly not a valid image type.";
    USER_EXCEPTION(lQName, lErrorMessage.str());
  }
}

void 
ImageFunction::throwErrorWithQName (const DynamicContext* aDynamicContext, const String& aLocalName, const String& aMessage) {
   String lNamespace = "http://zorba.io/modules/image/error";
   Item lQName = ImageModule::getItemFactory()->createQName(lNamespace, "image", aLocalName);
   USER_EXCEPTION(lQName, aMessage); 
}

void
ImageFunction::checkIfItemIsNull(Item& aItem) {
  if (aItem.isNull()) {
	std::stringstream lErrorMessage;
	lErrorMessage << "Error while building the base64binary item. ";
	throwError(lErrorMessage.str(), err::XPST0083);
  }
}
String
ImageFunction::getOneStringArg(
    const ExternalFunction::Arguments_t& aArgs,
    int aPos)
{
  Item lItem;
  Iterator_t  arg_iter = aArgs[aPos]->getIterator();
  arg_iter->open();
  if (!arg_iter->next(lItem)) {
    std::stringstream lErrorMessage;
    lErrorMessage << "An empty-sequence is not allowed as "
                  << aPos << ". parameter.";
    throwError(lErrorMessage.str(), err::XPTY0004);
  }
  zorba::String lTmpString = lItem.getStringValue();
  if (arg_iter->next(lItem)) {
    std::stringstream lErrorMessage;
    lErrorMessage << "A sequence of more then one item is not allowed as "
                  << aPos << ". parameter.";
    throwError(lErrorMessage.str(), err::XPTY0004);
  }
  arg_iter->close();
  return lTmpString;
}

bool
ImageFunction::getOneBoolArg(
    const ExternalFunction::Arguments_t& aArgs,
    int aPos)
{
  Item lItem;
  Iterator_t  arg_iter = aArgs[aPos]->getIterator();
  arg_iter->open();
  if (!arg_iter->next(lItem)) {
    std::stringstream lErrorMessage;
    lErrorMessage << "An empty-sequence is not allowed as "
                  << aPos << ". parameter.";
    throwError(lErrorMessage.str(), err::XPTY0004);
  }
  bool lTmpBool = lItem.getBooleanValue();
  if (arg_iter->next(lItem)) {
    std::stringstream lErrorMessage;
    lErrorMessage << "A sequence of more then one item is not allowed as "
                  << aPos << ". parameter.";
    throwError(lErrorMessage.str(), err::XPTY0004);
  }
  arg_iter->close();
  return lTmpBool;
}

void
ImageFunction::getOneColorArg(
     const ExternalFunction::Arguments_t& aArgs,
     int aPos,
     Magick::ColorRGB& aColor)
{
  Item lItem;
  Iterator_t  arg_iter = aArgs[aPos]->getIterator();
  arg_iter->open();
  if (!arg_iter->next(lItem)) {
    aColor = Magick::ColorRGB(0.0,0.0,0.0);
    return;
  }
  zorba::String lTmpString = lItem.getStringValue();
  if (arg_iter->next(lItem)) {
    std::stringstream lErrorMessage;
    lErrorMessage << "A sequence of more then one item is not allowed as "
                  << aPos << ". parameter.";
    throwError(lErrorMessage.str(), err::XPTY0004);
  }
  arg_iter->close();
  getColorFromString(lTmpString, aColor);
}



void 
ImageFunction::getColorFromString(const String aColorString,
                                  Magick::ColorRGB& aColor)
{
  int lRed = 0;
  int lGreen = 0;
  int lBlue = 0;
  sscanf(aColorString.substr(1,2).c_str(), "%x", &lRed);
  sscanf(aColorString.substr(3,2).c_str(), "%x", &lGreen);
  sscanf(aColorString.substr(5,2).c_str(), "%x", &lBlue);
  aColor = Magick::ColorRGB((double)lRed/(double)255.0, (double)lGreen/(double)255.0, (double)lBlue/(double)255.0);

}

int
ImageFunction::getOneIntArg(
    const ExternalFunction::Arguments_t& aArgs,
    int aPos)
{
  Item lItem;
  Iterator_t  arg_iter = aArgs[aPos]->getIterator();
  arg_iter->open();
  if (!arg_iter->next(lItem)) {
    std::stringstream lErrorMessage;
    lErrorMessage << "An empty-sequence is not allowed as "
                  << (aPos + 1)  << ". parameter.";
    throwError(lErrorMessage.str(), err::XPTY0004);
  }
  int lTmpInt = (int) lItem.getIntValue();
  if (arg_iter->next(lItem)) {
    std::stringstream lErrorMessage;
    lErrorMessage << "A sequence of more then one item is not allowed as "
                  << (aPos + 1)  << ". parameter.";
    throwError(lErrorMessage.str(), err::XPTY0004);
  }
  arg_iter->close();
  return lTmpInt;

}

unsigned int
ImageFunction::getOneUnsignedIntArg(const ExternalFunction::Arguments_t& aArgs,
                                    int aPos)
{
  Item lItem;
  Iterator_t  arg_iter = aArgs[aPos]->getIterator();
  arg_iter->open();
  if (!arg_iter->next(lItem)) {
    std::stringstream lErrorMessage;
    lErrorMessage << "An empty-sequence is not allowed as "
                  << (aPos + 1) << ". parameter.";
    throwError(lErrorMessage.str(), err::XPTY0004);
  }
  unsigned int lTmpInt = lItem.getUnsignedIntValue();
  if (arg_iter->next(lItem)) {
    std::stringstream lErrorMessage;
    lErrorMessage << "A sequence of more then one item is not allowed as "
                  << (aPos + 1) << ". parameter.";
    throwError(lErrorMessage.str(), err::XPTY0004);
  }
  arg_iter->close();
  return lTmpInt;

}

double
ImageFunction::getOneDoubleArg(
    const ExternalFunction::Arguments_t& aArgs,
    int aPos)
{
  Item lItem;
  Iterator_t  arg_iter = aArgs[aPos]->getIterator();
  arg_iter->open();
  if (!arg_iter->next(lItem)) {
    std::stringstream lErrorMessage;
    lErrorMessage << "An empty-sequence is not allowed as "
                  << (aPos + 1)  << ". parameter.";
    throwError(lErrorMessage.str(), err::XPTY0004);
  }
  double lTmpDouble =  lItem.getDoubleValue();
  if (arg_iter->next(lItem)) {
    std::stringstream lErrorMessage;
    lErrorMessage << "A sequence of more then one item is not allowed as "
                  << (aPos + 1) << ". parameter.";
    throwError(lErrorMessage.str(), err::XPTY0004);
  }
  arg_iter->close();
  return lTmpDouble;
}


String
ImageFunction::getEncodedStringFromBlob(Magick::Blob& aBlob) {
  String result;
  base64::encode(
    static_cast<char const*>( aBlob.data() ), aBlob.length(), &result
  );
  return result;
}

String
ImageFunction::getEncodedStringFromImage(const DynamicContext* aDynamicContext, Magick::Image& aImage) {
  Magick::Blob lBlob;
  try {
    aImage.write(&lBlob);
  } catch (Magick::Exception& error) {
    throwImageError(aDynamicContext, error.what());
  }
  return getEncodedStringFromBlob(lBlob);
}





void
ImageFunction::getOneImageArg(const DynamicContext* aDynamicContext,
                              const ExternalFunction::Arguments_t& aArgs,
                              int aPos,
                              Magick::Image& aImage)
{
  String lData;
  lData = getOneStringArg(aArgs, aPos);
  getImageFromString(aDynamicContext, lData, aImage);
}

void
ImageFunction::getOneOrMoreImageArg(const DynamicContext* aDynamicContext,
                                     const ExternalFunction::Arguments_t& aArgs,
                                     int aPos,
                                     std::list<Magick::Image>& aImages,
                                     const unsigned int aDelay,
                                     const unsigned int aIterations)

{
  Item lItem;
  // make sure there is at least one item at the position
  Iterator_t  arg_iter = aArgs[aPos]->getIterator();
  arg_iter->open();
  if (!arg_iter->next(lItem)) {
    throwError("An empty sequence is not allowed as first parameter", err::XPTY0004);
  }

  Magick::Image lFirstImage;
  ImageFunction::getImageFromString(aDynamicContext, lItem.getStringValue(), lFirstImage);
  lFirstImage.animationDelay(aDelay);
  lFirstImage.animationIterations(aIterations);
  lFirstImage.gifDisposeMethod(3);
  aImages.push_back(lFirstImage);
  Magick::Image lTempImage;
  while (arg_iter->next(lItem)) {
    getImageFromString(aDynamicContext, lItem.getStringValue(), lTempImage);
    aImages.push_back(lTempImage);
  }
  arg_iter->close();

}

void
ImageFunction::getImageFromString(const DynamicContext* aDynamicContext,
                                  const String& aString,
                                  Magick::Image& aImage,
                                  bool aIsBase64) {

  String lDecodedContent;
  if (aIsBase64)
  {
    zorba::base64::decode(aString, &lDecodedContent);
  }
  else
  {
    lDecodedContent = aString;
  }

  Magick::Blob lBlob(lDecodedContent.c_str(), lDecodedContent.size());

  try {
    aImage.read(lBlob);

  } catch (Magick::Exception &error)   {
      throwImageError(aDynamicContext, error.what());
  }
}


bool
ImageFunction::getAntiAliasingArg(
    const ExternalFunction::Arguments_t& aArgs,
    int aPos)
{
  Item lItem;
  Iterator_t  arg_iter = aArgs[aPos]->getIterator();
  arg_iter->open();
  if (!arg_iter->next(lItem)) {
    return false;
  }
  bool lTmpBool = lItem.getBooleanValue();
  if (arg_iter->next(lItem)) {
    std::stringstream lErrorMessage;
    lErrorMessage << "A sequence of more then one item is not allowed as "
                  << (aPos + 1) << ". parameter.";
    throwError(lErrorMessage.str(), err::XPTY0004);
  }
  arg_iter->close();
  return lTmpBool;
}

double
ImageFunction::getStrokeWidthArg(const ExternalFunction::Arguments_t& aArgs,
                                 int aPos)
{
  Item lItem;
  Iterator_t  arg_iter = aArgs[aPos]->getIterator();
  arg_iter->open();
  if (!arg_iter->next(lItem)) {
    return 1;
  }
  double lTmpDouble = lItem.getDoubleValue();
  if (arg_iter->next(lItem)) {
    std::stringstream lErrorMessage;
    lErrorMessage << "A sequence of more then one item is not allowed as "
                  << (aPos + 1) << ". parameter.";
    throwError(lErrorMessage.str(), err::XPTY0004);
  }
  arg_iter->close();
  return lTmpDouble;
}



} // imagemodule 
} // zorba
/* vim:set et sw=2 ts=2: */
