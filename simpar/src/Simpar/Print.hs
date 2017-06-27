module Simpar where
--
import Simpar.Types
--
class PrintHsc a where
    printHsc :: a -> String
--
instance PrintHsc a => PrintHsc [a] where
    printHsc [] = ""
    printHsc (x:xs) = (printHsc x) ++ nline ++ (printHsc xs)
instance PrintHsc StructEntity where
    printHsc (StructEntity structName sfs) =
        let fsMount = length sfs
            argNames = take fsMount $ map (\c->[c]) ['a'..'z']
            fnames = map fieldName sfs
        in "-- | "
        ++ upHead structName
        ++ nline
        ++ "data "
        ++ upHead structName
        ++ " = "
        ++ upHead structName
        ++ nline
        ++ softtab 1 ++ "{ "
        ++  ( drop 6
            $ concat
            $ map (((softtab 1 ++ ", ")++).(++ nline).printHsc)
            sfs)
        ++ softtab 1 ++ "} deriving (Show, Eq)"
        ++ nline
        ++ printStorable structName argNames fnames
instance PrintHsc FieldEntity where
    printHsc (FieldEntity fname fty (Just comm)) =
        printHsc (FieldEntity fname fty Nothing) ++
        " -- ^ " ++ comm
    printHsc (FieldEntity fname fty Nothing) =
        fname ++ " :: " ++ (printHsc fty)
instance PrintHsc FTypEntity where
    printHsc (FTypEntity 0 ty) = printHsc ty
    printHsc (FTypEntity 1 ty) = "Ptr " ++ printHsc ty
    printHsc (FTypEntity n ty) =
        "Ptr ( " ++ (printHsc (FTypEntity (n-1) ty)) ++ " )"
instance PrintHsc FTyp where
    printHsc FTInt   = "CInt"
    printHsc FTFloat = "CFloat"
    printHsc FTChars  = "CString"
    printHsc FTVoid  = "()"
    printHsc (FTOther (x : xs)) = (toUprintHscer x) : xs
--
instance PrintHsc FunctionEntity where
    printHsc (FunctionEntity fname rttype argTypes fcomm) =
        "foreign import ccall \"" ++ fname ++"\" "
        ++fname ++"_FFI"
        ++ nline ++ softtab 1 ++ ":: "
        ++ concat (map (++(nline ++ softtab 1 ++ "-> ").printHsc) argTypes)
        ++ printHsc rttype
--
printStorable :: String -> [String] -> [String] -> String
printStorable name args fields =
    "instance Storable " ++ upHead name ++ " where"
    ++ nline
    ++ softtab 1
    ++ "alignment _ = #{alignment " ++ name ++ "}"
    ++ nline
    ++ softtab 1
    ++ "sizeOf _    = #{size " ++ name ++ "}"
    ++ nline
    ++ softtab 1
    ++ printPeek name args fields
    ++ nline
    ++ softtab 1
    ++ printPoke name args fields
--
printPeek :: String -> [String] -> [String] -> String
printPeek name args fields =
    "peek ptr = do"
    ++ nline
    ++ peekline name (zip args fields)
    ++ softtab 2
    ++ "return ("
    ++ upHead name ++ (concat $ map (' ':) args)
    ++ ")"
--
printPoke :: String -> [String] -> [String] -> String
printPoke name args fields =
    "poke ptr ("
    ++ upHead name ++ (concat $ map (' ':) args)
    ++ ") = do"
    ++ nline
    ++ pokeline name (zip args fields)
--
peekline :: String -> [(String, String)] -> String
peekline cname ((a,b):xs) =
    softtab 2
    ++ (genPeekLine cname a b)
    ++ nline
    ++ (peekline cname xs)
peekline cname [] = ""
--
genPeekLine :: String -> String -> String -> String
genPeekLine cname argName fname =
    argName ++ " <- #{peek " ++
    cname ++ ", " ++ fname ++ "} ptr"
--
pokeline :: String -> [(String, String)] -> String
pokeline cname ((a,b):xs) =
    softtab 2
    ++ (genPokeLine cname a b)
    ++ nline
    ++ (pokeline cname xs)
pokeline cname [] = ""
--
genPokeLine :: String -> String -> String -> String
genPokeLine cname argName fname =
    "#{poke " ++ cname ++ ", " ++
    fname ++ "} ptr " ++ argName
--
nline :: String
nline = "\n"
--
softtab :: Int -> String
softtab 0 = ""
softtab n = "    " ++ softtab (n-1)
--
upHead :: String -> String
upHead (x:xs) = toUpper x : xs
