module Simpar where
--
import Text.Parsec
--
import Simpar.Types
import Simpar.Print
--
parseFTInt :: Parsec String st FTyp
parseFTInt = string "int" >> return FTInt
--
parseFTFloat :: Parsec String st FTyp
parseFTFloat = string "float" >> return FTFloat
--
parseFTVoid :: Parsec String st FTyp
parseFTVoid = string "void" >> return FTVoid
--
parseFTChars :: Parsec String st FTyp
parseFTChars = string "char*" >> return FTChars
--
parseFTOther :: Parsec String st FTyp
parseFTOther = many1 letter >>= (return.FTOther)
--
parseFTypEntity :: Parsec String st FTypEntity
parseFTypEntity = do
    parseConst
    p1 <- many (char '*')
    parseConst
    spaces
    t <- choice [ try parseFTInt
                , try parseFTFloat
                , try parseFTVoid
                , try parseFTChars
                , try parseFTOther ]
    spaces
    parseConst
    p2 <- many (char '*')
    parseConst
    return $ FTypEntity (length p1 + length p2) t
--
parseConst :: Parsec String st ()
parseConst = spaces
    >> optional (try $ string "const")
    >> spaces
    >> return ()
--
parseComm :: Parsec String st String
parseComm = do
    string "/*"
    spaces
    s <- manyTill anyChar (try (spaces >> string "*/"))
    spaces
    return s
--
parseFieldEntity :: Parsec String st FieldEntity
parseFieldEntity = do
    ty <- parseFTypEntity
    spaces
    name <- (many1 letter)
    spaces
    char ';'
    spaces
    mcomm <- optionMaybe parseComm
    return $ FieldEntity name ty mcomm
--
parseStructName :: Parsec String st String
parseStructName = do
    optional (string "typedef")
    spaces
    string "struct"
    spaces
    s <- many letter
    return s
--
parseStructEntity :: Parsec String st StructEntity
parseStructEntity = do
    sname <- parseStructName
    spaces
    string "{"
    spaces
    sf <- many1 parseFieldEntity
    manyTill anyChar (try $ parseFieldClose sname)
    return (StructEntity sname sf)
--
parseFieldClose :: String -> Parsec String st ()
parseFieldClose sname =
    char '}'
    >> spaces
    >> optional (string sname)
    >> char ';'
    >> (return ())
--
parseFunctionEntity :: Parsec String st FunctionEntity
parseFunctionEntity = do
    mcomm <- optionMaybe parseComm
    spaces
    ret <- parseFTypEntity
    spaces
    fname <- many1 $ choice [letter, char '_']
    spaces
    char '('
    spaces
    argts <- sepBy parseArgEntity (spaces >> char ',' >> spaces)
    string ");"
    spaces
    return (FunctionEntity fname ret argts mcomm)
--
parseArgEntity :: Parsec String st ArgEntity
parseArgEntity = do
    spaces
    ty <- parseFTypEntity
    spaces
    tname <- many1 $ choice [alphaNum, char '_']
    spaces
    return (ArgEntity tname ty)
