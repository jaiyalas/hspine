import Spine.Raw
--
import Foreign.C
import Foreign.Ptr
import Foreign.Storable
--
main :: IO ()
main = do
    cpath <- newCString "data/powerup/export/powerup.atlas"
    ptr_Atlas <- spAtlas_createFromFile_FFI cpath nullPtr
    atlas <- peek ptr_Atlas
    putStrLn $ show atlas
