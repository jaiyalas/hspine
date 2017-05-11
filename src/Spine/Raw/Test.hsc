{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE PatternSynonyms #-}
--
module Spine.Raw.Test where
--
import Control.Monad.IO.Class
import Foreign.C.Types
--
#include "spine/Animation.h"
#include "spine/Bone.h"
--
pattern AA = (#const SP_TIMELINE_ROTATE) :: CInt
--
foreign import ccall "spine/Bone.h spBone_setYDown" spBone_setYDown_FFI :: CInt -> IO ()
foreign import ccall "spine/Bone.h spBone_isYDown" spBone_isYDown_FFI :: IO CInt
--
spBone_setYDown_haskell :: MonadIO m => CInt -> m ()
spBone_setYDown_haskell cint = liftIO $ spBone_setYDown_FFI cint
{-# INLINE spBone_setYDown_haskell #-}
spBone_isYDown_haskell :: MonadIO m => m CInt
spBone_isYDown_haskell = liftIO $ spBone_isYDown_FFI
{-# INLINE spBone_isYDown_haskell #-}
