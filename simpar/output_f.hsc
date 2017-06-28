foreign import ccall "spAnimation_create" spAnimation_create_FFI
    :: CString -- ^ name
    -> CInt -- ^ timelinesCount
    -> IO Ptr SpAnimation

foreign import ccall "spAnimation_dispose" spAnimation_dispose_FFI
    :: Ptr SpAnimation -- ^ self
    -> IO ()



    , SpAnimation_create
    , SpAnimation_dispose
