{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE PatternSynonyms #-}
--
module Spine.Raw.Test where
--
#include "spine/Animation.h"
--
import Foreign.C.Types
--
pattern AA = (#const SP_TIMELINE_ROTATE) :: CInt
