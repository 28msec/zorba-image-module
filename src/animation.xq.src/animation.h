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
#ifndef ZORBA_IMAGEMODULE_ANIMATIONMODULE_ANIMATION_H
#define ZORBA_IMAGEMODULE_ANIMATIONMODULE_ANIMATION_H

#include "image_function.h"

namespace zorba { 
  
  class ItemFactory;
  class SerializationItemProvider;

  namespace imagemodule { namespace animationmodule {
    


//*****************************************************************************


class CreateAnimatedGifFunction : public zorba::imagemodule::ImageFunction 
  {
    public:
      CreateAnimatedGifFunction(const ImageModule* aModule);
      virtual String getLocalName() const { return "create-animated-gif"; }

      virtual ItemSequence_t
      evaluate(const ExternalFunction::Arguments_t& args,
               const StaticContext* aSctxCtx,
               const DynamicContext* aDynCtx) const;

  };



//*****************************************************************************


class CreateMorphedGifFunction : public zorba::imagemodule::ImageFunction
  {
    public:
      CreateMorphedGifFunction(const ImageModule* aModule);
      virtual String getLocalName() const { return "create-morphed-gif"; }

      virtual ItemSequence_t
      evaluate(const ExternalFunction::Arguments_t& args,
               const StaticContext* aSctxCtx,
               const DynamicContext* aDynCtx) const;

  };





  
  

} /* namespace animationmodule */  } /* namespace imagemodule */ }  /* namespace zorba */

#endif /* ZORBA_IMAGEMODULE_ANIMATIONMODULE_ANIMATION_H */
