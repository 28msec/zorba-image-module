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
#ifndef ZORBA_IMAGEMODULE_BASICMODULE_BASIC_H
#define ZORBA_IMAGEMODULE_BASICMODULE_BASIC_H

#include "image_function.h"

namespace zorba { 
  
  class ItemFactory;
  class SerializationItemProvider;

  namespace imagemodule { namespace basicmodule {
    
//*****************************************************************************

class WidthFunction : public zorba::imagemodule::ImageFunction 

  {
    public:
      WidthFunction(const ImageModule* aModule);
      virtual String getLocalName() const { return "width";}

      virtual ItemSequence_t
      evaluate(const ExternalFunction::Arguments_t& args,
               const StaticContext* aSctxCtx,
               const DynamicContext* aDynCtx) const;

  };


//*****************************************************************************


class HeightFunction : public zorba::imagemodule::ImageFunction 

  {
    public:
      HeightFunction(const ImageModule* aModule);
      virtual String getLocalName() const { return "height";}

      virtual ItemSequence_t
      evaluate(const ExternalFunction::Arguments_t& args,
               const StaticContext* aSctxCtx,
               const DynamicContext* aDynCtx) const;

  };


//*****************************************************************************


  class FormatFunction : public zorba::imagemodule::ImageFunction 
  {
    public:
      FormatFunction(const ImageModule* aModule);
      virtual String getLocalName() const { return "format"; }

      virtual ItemSequence_t
      evaluate(const ExternalFunction::Arguments_t& args,
               const StaticContext* aSctxCtx,
               const DynamicContext* aDynCtx) const;

  };

//*****************************************************************************


class ConvertFunction : public zorba::imagemodule::ImageFunction 
  {
    public:
      ConvertFunction(const ImageModule* aModule);
      virtual String getLocalName() const { return "convert-impl"; }

      virtual ItemSequence_t
      evaluate(const ExternalFunction::Arguments_t& args,
               const StaticContext* aSctxCtx,
               const DynamicContext* aDynCtx) const;

  };

//*****************************************************************************


class CompressFunction : public zorba::imagemodule::ImageFunction
  {
    public:
      CompressFunction(const ImageModule* aModule);
      virtual String getLocalName() const { return "compress"; }

      virtual ItemSequence_t
      evaluate(const ExternalFunction::Arguments_t& args,
               const StaticContext* aSctxCtx,
               const DynamicContext* aDynCtx) const;

  };

//*****************************************************************************

class CreateFunction : public zorba::imagemodule::ImageFunction 
  {
    public:
      CreateFunction(const ImageModule* aModule);
      virtual String getLocalName() const { return "create-impl"; }

      virtual ItemSequence_t
      evaluate(const ExternalFunction::Arguments_t& args,
               const StaticContext* aSctxCtx,
               const DynamicContext* aDynCtx) const;

  };

//*****************************************************************************

class EqualsFunction : public zorba::imagemodule::ImageFunction
  {
    public:
      EqualsFunction(const ImageModule* aModule);
      virtual String getLocalName() const { return "equals"; }

      virtual ItemSequence_t
      evaluate(const ExternalFunction::Arguments_t& args,
               const StaticContext* aSctxCtx,
               const DynamicContext* aDynCtx) const;

  };



//*****************************************************************************

class ExifFunction : public zorba::imagemodule::ImageFunction
  {
    public:
      ExifFunction(const ImageModule* aModule);
      virtual String getLocalName() const { return "exif"; }

      virtual ItemSequence_t
      evaluate(const ExternalFunction::Arguments_t& args,
               const StaticContext* aSctxCtx,
               const DynamicContext* aDynCtx) const;

  };


//*****************************************************************************

class ConvertSVGFunction : public zorba::imagemodule::ImageFunction
  {
    public:
      ConvertSVGFunction(const ImageModule* aModule);
      virtual String getLocalName() const { return "convert-svg-impl"; }

      virtual ItemSequence_t
      evaluate(const ExternalFunction::Arguments_t& args,
               const StaticContext* aSctxCtx,
               const DynamicContext* aDynCtx) const;

  };




} /* namespace basicmodule */  } /* namespace imagemodule */ }  /* namespace zorba */

#endif /* ZORBA_IMAGEMODULE_BASICMODULE_BASIC_H */
