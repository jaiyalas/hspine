module Main where
--
import Lib
--
import Text.Parsec
import Data.Char
import System.Environment (getArgs)
import System.IO
import Debug.Trace
--
main :: IO ()
main = do
    xs <- getArgs
    h1 <- openFile (head xs) ReadMode
    h2 <- openFile "output.hsc" WriteMode
    str <- hGetContents h1
    let parsed = pStructs $ rmLn str
    hPutStr h2 $ either show pp parsed
    hPutStr h2 $ either show pm parsed
    hClose h1
    hClose h2
    -- (putStrLn . either show pp . pStruct . rmLn) str
    -- putStrLn $ show $ pStructs $ rmLn str

pm :: [StructEntity] -> String
pm [] = ""
pm (x:xs) = softtab 1
    ++ ", data "
    ++ upHead (sname x)
    ++ "(..)"
    ++ nline
    ++ pm xs

rmLn :: String -> String
rmLn str = map (\x -> if x == '\n' || x == '\t' then ' ' else x) str

-- -- -- -- -- -- -- -- -- --

pStructs :: String -> Either ParseError [StructEntity]
pStructs = parse (many pStructEntity) ""

pStruct :: String -> Either ParseError StructEntity
pStruct = parse pStructEntity ""
--
pStructEntity :: Parsec String st StructEntity
pStructEntity = do
    spaces
    sname <- pStructName
    spaces
    sf <- many1 pFieldEntity
    manyTill anyChar (try $ do{ char '}'; spaces; optional (string sname); char ';' })
    spaces
    return (StructEntity sname sf)
--
pStructName :: Parsec String st String
pStructName = do
    optional (string "typedef")
    -- string "typedef"
    spaces
    string "struct"
    spaces
    s <- many letter
    spaces
    string "{"
    return s
--
pFieldEntity :: Parsec String st FieldEntity
pFieldEntity = do
    spaces
    optional (try $ string "const")
    spaces
    ty <- pFTypEntity
    spaces
    optional (try $ string "const")
    spaces
    name <- (many1 letter)
    spaces
    char ';'
    spaces
    mcomm <- optionMaybe pComm
    -- traceShow "mcomm" spaces
    -- traceShow mcomm spaces
    spaces
    return $ FieldEntity name ty mcomm
--
pComm :: Parsec String st String
pComm = do
    choice [string "/* ", string "/*"]
    spaces
    s <- manyTill anyChar (try (choice [string " */", string "*/"]))
    spaces
    return s
--
pFTypEntity :: Parsec String st FTypEntity
pFTypEntity = do
    p1 <- many (char '*')
    spaces
    t <- choice [pFTInt, pFTFloat, pFTVoid, pFTChars, pFTOther]
    spaces
    p2 <- many (char '*')
    return $ FTypEntity (length p1 + length p2) t
--
pFTInt :: Parsec String st FTyp
pFTInt = string "int" >> return FTInt
--
pFTFloat :: Parsec String st FTyp
pFTFloat = string "float" >> return FTFloat
--
pFTVoid :: Parsec String st FTyp
pFTVoid = string "void" >> return FTVoid
pFTChars :: Parsec String st FTyp
pFTChars = string "char*" >> return FTChars
--
pFTOther :: Parsec String st FTyp
pFTOther = do
    spaces
    tname <- (many1 letter)
    spaces
    return (FTOther tname)
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
data StructEntity = StructEntity
    { sname   :: String
    , sfields :: [FieldEntity]
    } deriving (Eq, Show)
--
data FieldEntity = FieldEntity
    { fieldName :: String
    , fieldType :: FTypEntity
    , fieldComm :: Maybe String
    } deriving (Eq, Show)
--
data FTypEntity = FTypEntity
    { ptrCounter :: Int
    , typeBody :: FTyp
    } deriving (Eq, Show)
--
data FTyp
    = FTInt
    | FTFloat
    | FTVoid
    | FTChars
    | FTOther String
    deriving (Eq, Show)
--
class PP a where
    pp :: a -> String
--
instance PP a => PP [a] where
    pp [] = ""
    pp (x:xs) = (pp x) ++ nline ++ (pp xs)
instance PP StructEntity where
    pp (StructEntity structName sfs) =
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
            $ map (((softtab 1 ++ ", ")++).(++ nline).pp)
            sfs)
        ++ softtab 1 ++ "} deriving (Show, Eq)"
        ++ nline
        ++ printStorable structName argNames fnames
instance PP FieldEntity where
    pp (FieldEntity fname fty (Just comm)) =
        pp (FieldEntity fname fty Nothing) ++
        " -- ^ " ++ comm
    pp (FieldEntity fname fty Nothing) =
        fname ++ " :: " ++ (pp fty)
instance PP FTypEntity where
    pp (FTypEntity 0 ty) = pp ty
    pp (FTypEntity 1 ty) = "Ptr " ++ pp ty
    pp (FTypEntity n ty) =
        "Ptr ( " ++ (pp (FTypEntity (n-1) ty)) ++ " )"
instance PP FTyp where
    pp FTInt   = "CInt"
    pp FTFloat = "CFloat"
    pp FTChars  = "CString"
    pp FTVoid  = "()"
    pp (FTOther (h:xs)) = (toUpper h) : xs
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
    ++ ppeekline name (zip args fields)
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
    ++ ppokeline name (zip args fields)
--
ppeekline :: String -> [(String, String)] -> String
ppeekline cname ((a,b):xs) =
    softtab 2
    ++ (genPeekLine cname a b)
    ++ nline
    ++ (ppeekline cname xs)
ppeekline cname [] = ""
--
ppokeline :: String -> [(String, String)] -> String
ppokeline cname ((a,b):xs) =
    softtab 2
    ++ (genPokeLine cname a b)
    ++ nline
    ++ (ppokeline cname xs)
ppokeline cname [] = ""
--
genPokeLine :: String -> String -> String -> String
genPokeLine cname argName fname =
    "#{poke " ++ cname ++ ", " ++
    fname ++ "} ptr " ++ argName
--
genPeekLine :: String -> String -> String -> String
genPeekLine cname argName fname =
    argName ++ " <- #{peek " ++
    cname ++ ", " ++ fname ++ "} ptr"
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
