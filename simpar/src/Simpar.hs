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
parseFTOther = (many1 $ choice [alphaNum, char '_']) >>= (return . FTOther)
--
parseFTypEntity :: Parsec String st FTypEntity
parseFTypEntity = do
    parseConst
    optional (try $ string "struct")
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
    name <- many1 $ choice [alphaNum, char '_']
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
    fname <- many1 $ choice [alphaNum, char '_']
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
    optional (try $ string "struct")
    spaces
    ty <- parseFTypEntity
    spaces
    tname <- many1 $ choice [alphaNum, char '_']
    spaces
    return (ArgEntity tname ty)
--
parseConstantEntity :: Parsec String st ConstantEntity
parseConstantEntity = do
    string "static const"
    spaces
    cty <- parseFTypEntity
    spaces
    cname <- many1 $ choice [alphaNum, char '_']
    spaces
    char '='
    spaces
    many1 $ choice [char '-', alphaNum, char '_']
    spaces
    choice [char ';', char ',']
    return (ConstantEntity cty cname)
--
-- MAGIC
parseStructEntityM :: Parsec String st Magic
parseStructEntityM = parseStructEntity >>= (return . MagicStruct)
parseFunctionEntityM :: Parsec String st Magic
parseFunctionEntityM = parseFunctionEntity >>= (return . MagicFunction)
parseConstantEntityM :: Parsec String st Magic
parseConstantEntityM = parseConstantEntity >>= (return . MagicConstant)
--
parseMagics :: Parsec String st [Magic]
parseMagics = many
    (   try (spaces >> parseConstantEntityM >>= (\x -> spaces >> return x))
    <|> try (spaces >> parseStructEntityM   >>= (\x -> spaces >> return x))
    <|> try (spaces >> parseFunctionEntityM >>= (\x -> spaces >> return x)) )
--
-- parseBoth :: Parsec String st [Either StructEntity FunctionEntity]
-- parseBoth = many (try parseRightFunc <|> try parseLeftStruct)
--
-- spsf :: (a -> b) -> Parsec String st a -> Parsec String st b
-- spsf f p = do
--     spaces
--     x <- p
--     spaces
--     return (f x)
-- --
-- parseRightFunc = spsf Right parseFunctionEntity
-- parseLeftStruct = spsf Left parseStructEntity
