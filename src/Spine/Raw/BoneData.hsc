{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE PatternSynonyms #-}
--
module Spine.Raw.BoneData where
--
#include "spine/BoneData.h"
--
import Foreign.Ptr
import Foreign.C.Types
import Foreign.C.String
import Foreign.Storable
--
import Control.Monad.IO.Class
import Data.Default
--

{-
newtype TransformMode = TransformMode {rule :: CInt} deriving (Show, Eq)
#{enum TransformMode, TransformMode,
    sp_transformmode_normal =
        SP_TRANSFORMMODE_NORMAL,
    sp_transformmode_onlytranslation =
        SP_TRANSFORMMODE_ONLYTRANSLATION,
    sp_transformmode_norotationorreflection =
        SP_TRANSFORMMODE_NOROTATIONORREFLECTION,
    sp_transformmode_noscale =
        SP_TRANSFORMMODE_NOSCALE,
    sp_transformmode_noscaleorreflection =
        SP_TRANSFORMMODE_NOSCALEORREFLECTION
}
-}
--
type TransformMode = CInt
--
pattern SP_TRANSFORMMODE_NORMAL =
    (#const SP_TRANSFORMMODE_NORMAL) :: TransformMode
pattern SP_TRANSFORMMODE_ONLYTRANSLATION =
    (#const SP_TRANSFORMMODE_ONLYTRANSLATION) :: TransformMode
pattern SP_TRANSFORMMODE_NOROTATIONORREFLECTION =
    (#const SP_TRANSFORMMODE_NOROTATIONORREFLECTION) :: TransformMode
pattern SP_TRANSFORMMODE_NOSCALE =
    (#const SP_TRANSFORMMODE_NOSCALE) :: TransformMode
pattern SP_TRANSFORMMODE_NOSCALEORREFLECTION =
    (#const SP_TRANSFORMMODE_NOSCALEORREFLECTION) :: TransformMode

#if __GLASGOW_HASKELL__ < 800
#let alignment t = "%lu", (unsigned long)offsetof(struct {char x__; t (y__); }, y__)
#endif

data SpBoneData = SpBoneData
    { spBoneData_index    :: CInt
    , spBoneData_name     :: CString
    , spBoneData_parent   :: Ptr SpBoneData
    , spBoneData_length   :: CFloat
    , spBoneData_x        :: CFloat
    , spBoneData_y        :: CFloat
    , spBoneData_rotation :: CFloat
    , spBoneData_scaleX   :: CFloat
    , spBoneData_scaleY   :: CFloat
    , spBoneData_shearX   :: CFloat
    , spBoneData_shearY   :: CFloat
    , spBoneData_transformMode :: TransformMode
    } deriving (Show, Eq)
--
instance Storable SpBoneData where
    alignment _ = #{alignment spBoneData}
    sizeOf _ = #{size spBoneData}
    peek ptr = do
        i <-   #{peek spBoneData, index} ptr
        n <-   #{peek spBoneData, name} ptr
        p <-   #{peek spBoneData, parent} ptr
        l <-   #{peek spBoneData, length} ptr
        x <-   #{peek spBoneData, x} ptr
        y <-   #{peek spBoneData, y} ptr
        r <-   #{peek spBoneData, rotation} ptr
        sx <-  #{peek spBoneData, scaleX} ptr
        sy <-  #{peek spBoneData, scaleY} ptr
        shx <- #{peek spBoneData, shearX} ptr
        shy <- #{peek spBoneData, shearY} ptr
        t <-   #{peek spBoneData, transformMode} ptr
        return (SpBoneData i n p l x y r sx sy shx shy t)
    poke ptr (SpBoneData i n p l x y r sx sy shx shy t) = do
        #{poke spBoneData, index} ptr i
        #{poke spBoneData, name} ptr n
        #{poke spBoneData, parent} ptr p
        #{poke spBoneData, length} ptr l
        #{poke spBoneData, x} ptr x
        #{poke spBoneData, y} ptr y
        #{poke spBoneData, rotation} ptr r
        #{poke spBoneData, scaleX} ptr sx
        #{poke spBoneData, scaleY} ptr sy
        #{poke spBoneData, shearX} ptr shx
        #{poke spBoneData, shearY} ptr shy
        #{poke spBoneData, transformMode} ptr t
--
instance Default SpBoneData where
    def = SpBoneData 0 nullPtr nullPtr 0 0 0 0 0 0 0 0 SP_TRANSFORMMODE_NORMAL

-- spBoneData* spBoneData_create (int index, const char* name, spBoneData* parent);
-- void spBoneData_dispose (spBoneData* self);
