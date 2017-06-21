module Main where
--
import Lib
--
import Text.Parsec
import Data.Char
--
main :: IO ()
main = do
    -- let x = parse expressionParser "" "(1+(3-4))"
    let x = parse (optionMaybe (many $ oneOf "0123456789")) "" "123"
    putStrLn $ show x
    let y = parse (optionMaybe (many $ oneOf "0123456789")) "" "abc"
    putStrLn $ show y
    let z = parse (optionMaybe (many1 $ oneOf "0123456789")) "" "abc"
    putStrLn $ show z

pStruct :: String -> Either ParseError StructEntity
pStruct = parse pStructEntity ""



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
    | FTOther String
    deriving (Eq, Show)
--
class PP a where
    pp :: a -> String
instance PP StructEntity where
    pp (StructEntity (h:xs) sfs) =
        let name = ((toUpper h) : xs)
        in "data "
        ++ name
        ++ " = "
        ++ name
        ++ "{\n"
        ++ (tail $ concat $ map ((',':).(++"\n").pp) sfs)
        ++ "} deriving (Show, Eq)"

instance PP FieldEntity where
    pp (FieldEntity fname fty (Just comm)) =
        pp (FieldEntity fname fty Nothing) ++
        " -- ^ " ++ comm
    pp (FieldEntity fname fty Nothing) =
        fname ++ " :: " ++ (pp fty)
instance PP FTypEntity where
    pp (FTypEntity 0 ty) = pp ty
    pp (FTypEntity n ty) =
        "Ptr ( " ++ (pp (FTypEntity (n-1) ty)) ++ " )"
instance PP FTyp where
    pp FTInt   = "CInt"
    pp FTFloat = "CFloat"
    pp FTVoid  = "()"
    pp (FTOther (h:xs)) = (toUpper h) : xs
--
pStructEntity :: Parsec String st StructEntity
pStructEntity = do
    spaces
    sname <- pStructName
    spaces
    char '{'
    spaces
    sf <- many1 pFieldEntity
    return (StructEntity sname sf)
--
pStructName :: Parsec String st String
pStructName = do
    string "typedef"
    spaces
    string "struct"
    spaces
    many letter
--
pFieldEntity :: Parsec String st FieldEntity
pFieldEntity = do
    spaces
    _ <- optionMaybe (string "const")
    spaces
    ty <- pFTypEntity
    spaces
    _ <- optionMaybe (string "const")
    spaces
    name <- (many1 letter)
    spaces
    char ';'
    spaces
    mcomm <- optionMaybe pComm
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
    t <- choice [pFTInt, pFTFloat, pFTVoid, pFTOther]
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
--
pFTOther :: Parsec String st FTyp
pFTOther = do
    spaces
    tname <- (many1 letter)
    spaces
    return (FTOther tname)
--
