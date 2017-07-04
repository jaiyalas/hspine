import Spine.Raw
--
import Foreign.C
import Foreign.Ptr
import Foreign.Storable
--
main :: IO ()
<<<<<<< HEAD
main = undefined --
=======
main = do
    cpath <- newCString "data/powerup/export/powerup.atlas"
    ptr_Atlas <- spAtlas_createFromFile_FFI cpath nullPtr
    atlas <- peek ptr_Atlas
    putStrLn $ show atlas
>>>>>>> 15ac6e9835089150dd70fb491ff00585a2c0bd0b
