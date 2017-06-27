module Simpar where
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
    t <- choice [ try pFTInt
                , try pFTFloat
                , try pFTVoid
                , try pFTChars
                , try pFTOther ]
    spaces
    parseConst
    p2 <- many (char '*')
    parseConst
    return $ FTypEntity (length p1 + length p2) t
--
parseConst :: Parsec String st ()
parseConst = spaces >> optional (string "const") >> spaces >> return ()
--
parseComm :: Parsec String st String
parseComm = do
    string "/*"
    spaces
    s <- manyTill anyChar (try (spaces >> string "*/"))
    spaces
    return s
