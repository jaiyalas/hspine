module Spine.Raw.EventData
    ( -- * functions
      spEventData_create
    , spEventData_dispose
    ) where
--
#include "spine/EventData.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spEventData_create" spEventData_create_FFI
    :: CString -- ^ name
    -> IO Ptr SpEventData

foreign import ccall "spEventData_dispose" spEventData_dispose_FFI
    :: Ptr SpEventData -- ^ self
    -> IO ()
