module Spine.Raw.Event
    ( -- * functions
      spEvent_create_FFI
    , spEvent_dispose_FFI
    ) where
--
#include "spine/Event.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spEvent_create" spEvent_create_FFI
    :: CFloat -- ^ time
    -> Ptr SpEventData -- ^ data
    -> IO (Ptr SpEvent)

foreign import ccall "spEvent_dispose" spEvent_dispose_FFI
    :: Ptr SpEvent -- ^ self
    -> IO ()
