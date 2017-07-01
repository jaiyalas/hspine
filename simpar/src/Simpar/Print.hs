module Simpar.Print
    ( -- * PrintHsc
      PrintHsc(..)
    , printStorable
    -- * Print exposing (model-level) infomation for hsc
    , printModel_struct
    , printModel_function
    , printModel_constant
    -- * auxiliary functions
    , nline
    , softtab
    , upHead
    ) where
--
import Simpar.Types
--
import Text.Parsec
import Data.Char (toUpper)
--
class PrintHsc a where
    -- | print string for .hsc
    printHsc :: a -> String
--
instance PrintHsc Magic where
    printHsc (MagicStruct se) = printHsc se
    printHsc (MagicFunction fe) = printHsc fe
    printHsc (MagicConstant ce) = printHsc ce
instance PrintHsc a => PrintHsc [a] where
    printHsc [] = ""
    printHsc (x:xs) = (printHsc x) ++ nline ++ (printHsc xs)
instance PrintHsc StructEntity where
    printHsc (StructEntity structName sfs) =
        let fsMount = length sfs
            argNames = take fsMount
                     $ (\xs -> xs ++ map (++"2") xs)
                     $ map (\c->[c]) ['a'..'z']
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
            $ map (((softtab 1 ++ ", ")++).(++ nline).(structName++).("_"++).printHsc)
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
    printHsc FTInt    = "CInt"
    printHsc FTShort  = "CShort"
    printHsc FTUInt   = "CUInt"
    printHsc FTUShort = "CUShort"
    printHsc FTFloat  = "CFloat"
    printHsc FTChars  = "CString"
    printHsc FTVoid   = "()"
    printHsc (FTOther (x : xs)) = (toUpper x) : xs
--
instance PrintHsc ArgEntity where
    printHsc (ArgEntity aname aty) =
        printHsc aty
        ++ " -- ^ "
        ++ aname
--
instance PrintHsc FunctionEntity where
    printHsc (FunctionEntity fname rttype argTypes (Just comm)) =
        "-- | "
        ++ comm
        ++ nline
        ++ (printHsc $ FunctionEntity fname rttype argTypes Nothing)
    printHsc (FunctionEntity fname rttype argTypes Nothing) =
        "foreign import ccall \"" ++ fname ++"\" "
        ++fname ++"_FFI"
        ++ nline ++ softtab 1 ++ ":: "
        ++ concat (map ((++ nline ++ softtab 1 ++ "-> ").printHsc) argTypes)
        ++ "IO ( "
        ++ printHsc rttype
        ++ " )"
        ++ nline
--
instance PrintHsc ConstantEntity where
    printHsc (ConstantEntity ctype cname) = concat
        [ "pattern " , cname , " :: " , printHsc ctype
        , nline
        , "pattern " , cname , " = #{const " , cname , "}"
        ]
--
printModel_struct :: [StructEntity] -> String
printModel_struct [] = ""
printModel_struct (x:xs) =
    softtab 1
    ++ ", "
    ++ upHead (sname x)
    ++ "(..)"
    ++ nline
    ++ printModel_struct xs
--
printModel_function :: [FunctionEntity] -> String
printModel_function [] = ""
printModel_function (x:xs) =
    softtab 1
    ++ ", "
    ++ fname x
    ++ "_FFI"
    ++ nline
    ++ printModel_function xs
--
printModel_constant :: [ConstantEntity] -> String
printModel_constant [] = ""
printModel_constant (x:xs) = concat
    [ softtab 1
    , ", pattern "
    , cname x
    , nline
    , printModel_constant xs ]
--
-- | Generate a string of storable instance. Required by the instance `PrintHsc StructEntity`
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
-- | Generate a string of peek function required within storable instance
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
-- | Generate a string of poke function required within storable instance
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
-- | new line, equals to "\n"
nline :: String
nline = "\n"
--
-- | tab replacement (as 4 spaces)
softtab :: Int -- ^ numbers of required tabs
        -> String
softtab 0 = ""
softtab n = "    " ++ softtab (n-1)
--
-- | capitalize the first char of given string
upHead :: String -> String
upHead (x:xs) = toUpper x : xs
--
